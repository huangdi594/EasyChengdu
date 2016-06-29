//
//  XHGraphsMainView.m
//  LineDemo
//
//  Created by XuHuan on 16/3/7.
//  Copyright © 2016年 XuHuan. All rights reserved.
//

#import "XHGraphsMainView.h"
#import "XHGraphsView.h"

@interface XHGraphsMainView ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *nameLables;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *countLables;//纵向

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *timeLables;//横向

@property (weak, nonatomic) IBOutlet UIView *graphsView;
@property (strong, nonatomic) XHGraphsView *graphs;//**< 折线图 */
@property (strong, nonatomic) UISwipeGestureRecognizer *leftSwipe;//**< 左滑 */
@property (strong, nonatomic) UISwipeGestureRecognizer *rightSwipe;//**< 右滑 */
@property (strong, nonatomic) NSArray *colorArr;//**< 颜色数组 */

@end

@implementation XHGraphsMainView
#pragma mark - lazyLoad
- (NSArray *)colorArr {
    if (!_colorArr) {
        _colorArr = @[[UIColor colorWithRed:252/255.0 green:139/255.0 blue:56/255.0 alpha:1],
                      [UIColor colorWithRed:90/255.0 green:171/255.0 blue:255/255.0 alpha:1],
                      [UIColor colorWithRed:177/255.0 green:114/255.0 blue:231/255.0 alpha:1],
                      [UIColor colorWithRed:246/255.0 green:207/255.0 blue:66/255.0 alpha:1],
                      [UIColor colorWithRed:136/255.0 green:33/255.0 blue:32/255.0 alpha:1]];
    }
    return _colorArr;
}

#pragma mark - lifecycle
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSwipeGesture];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNameLablesTextAttributes];
    [self creatSubView];
}

- (void)creatSubView {
    self.graphs = [[XHGraphsView alloc] initWithFrame:self.graphsView.bounds];
    [self.graphsView addSubview:self.graphs];
}

- (void)setDateArr:(NSArray *)dateArr {
    _dateArr = dateArr;
    [self dataProcessing];
}

#pragma mark - 数据处理
//设置namelable字体属性
- (void)setNameLablesTextAttributes {
    
    for (int i = 0; i < self.nameLables.count; i++) {
        UILabel *lable = self.nameLables[i];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lable.text];
        [str addAttribute:NSForegroundColorAttributeName value:self.colorArr[i] range:NSMakeRange(0,4)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, 4)];
        lable.attributedText = str;
    }
}
//数据解析
- (void)dataProcessing {
    //折线数据
    NSArray *lineDataArr = @[[[NSMutableArray alloc] init],
                             [[NSMutableArray alloc] init],
                             [[NSMutableArray alloc] init],
                             [[NSMutableArray alloc] init],
                             [[NSMutableArray alloc] init],
                             ];
    //最大值
    CGFloat max = 25.0f;
    for (int i = 0; i < self.dateArr.count; i++) {
        NSDictionary *dic = self.dateArr[i];
        //time
        NSTimeInterval interval = [dic[@"time"] doubleValue] * 1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yy/MM";
        UILabel *timeLable = self.timeLables[i];
        timeLable.text = [formatter stringFromDate:date];
        
        //hasMonitoredNum
        [lineDataArr[0] addObject:dic[@"hasMonitoredNum"]];
        if (max < [dic[@"hasMonitoredNum"] floatValue]) {
            max = [dic[@"hasMonitoredNum"] floatValue];
        }
        //programRunNum
        [lineDataArr[1] addObject:dic[@"programRunNum"]];
        if (max < [dic[@"programRunNum"] floatValue]) {
            max = [dic[@"programRunNum"] floatValue];
        }
        //SASNum
        [lineDataArr[2] addObject:dic[@"SASNum"]];
        if (max < [dic[@"SASNum"] floatValue]) {
            max = [dic[@"SASNum"] floatValue];
        }
        //COPDNum
        [lineDataArr[3] addObject:dic[@"COPDNum"]];
        if (max < [dic[@"COPDNum"] floatValue]) {
            max = [dic[@"COPDNum"] floatValue];
        }
        //OSANum
        [lineDataArr[4] addObject:dic[@"OSANum"]];
        if (max < [dic[@"OSANum"] floatValue]) {
            max = [dic[@"OSANum"] floatValue];
        }
    }
    NSInteger tempFloat = 5;
    if (max > 25) {
        max = 50;
        tempFloat = 10;
    }
    
    for (int i = 0; i < self.countLables.count; i++) {
        UILabel *lable = self.countLables[i];
        lable.text = [NSString stringWithFormat:@"%.0ld",(i + 1)*tempFloat];
    }
    
    [self.graphs setDataArr:lineDataArr maxValue:max];
    [self.graphs begin];
}

#pragma mark - 添加手势
- (void)addSwipeGesture {
    self.leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
    [self.leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
    [self.rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:self.rightSwipe];
}
//代理返回刷新后的数据
- (void)swiped:(UISwipeGestureRecognizer *)gesture {
    NSArray *tempArr;
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        //左滑
        if ([self.delegate respondsToSelector:@selector(graphsMainViewLeft:)]) {
            tempArr = [self.delegate graphsMainViewLeft:self];
        }
    } else {
        //右滑
        if ([self.delegate respondsToSelector:@selector(graphsMainViewRight:)]) {
            tempArr = [self.delegate graphsMainViewRight:self];
        }
    }
    //返回数组不为nil 重绘则线条
    if (tempArr) {
        self.dateArr = [NSArray arrayWithArray:tempArr];
        [self dataProcessing];
    }
}


@end
