//
//  XHGraphsView.m
//  LineDemo
//
//  Created by XuHuan on 16/3/7.
//  Copyright © 2016年 XuHuan. All rights reserved.
//

#import "XHGraphsView.h"

@interface XHGraphsView ()

@property (strong, nonatomic) NSArray   *colorArr;//**<曲线颜色数组  */
@property (strong, nonatomic) NSArray   *dataArr;//**< 曲线数据 */
@property (strong, nonatomic) NSMutableArray   *layerArr;//**<  */
@property (assign, nonatomic) CGFloat maxValue;
//垂直间隔
#define LINESEPARATE  (self.frame.size.height / 6)
//水平间隔
#define TRANSVERMARGIN ((self.bounds.size.width - ((self.bounds.size.width / 6) / 2))/ 6)
//线宽
#define LINEWIDTH 5.0f


@end

@implementation XHGraphsView

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

- (NSMutableArray *)layerArr {
    if (!_layerArr) {
        _layerArr = [[NSMutableArray alloc] init];
    }
    return _layerArr;
}

#pragma mark - lifeCycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [self creatDownSubView];
}
#pragma mark - creatSubView

//创建曲线图
- (void)creatDownSubView {
    //横线
    CGFloat lineHeight = self.frame.size.height / 6 ;
    for (int i = 0; i < 6; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, lineHeight / 2 + lineHeight*i, self.bounds.size.width - TRANSVERMARGIN / 2, 1)];
        if (i == 0) {
            view.backgroundColor = [UIColor lightGrayColor];
        } else {
            view.backgroundColor = [UIColor grayColor];
        }
        [self addSubview:view];
    }
}

#pragma mark - 数据传入
- (void)setColorsArr:(NSArray *)arr {
    self.colorArr = arr;
}

- (void)setDataArr:(NSArray *)arr maxValue:(CGFloat)maxValue {
    self.dataArr = arr;
    self.maxValue = maxValue;
}

#pragma mark - 折线图
//开始绘图
- (void)begin {
    [self clearnLayer];
    [self drawLine];
}

- (void)drawLine{
    for (int i = 0; i < self.dataArr.count; i++) {
        NSArray *arr = self.dataArr[i];
        UIBezierPath *path = [self getLinePath:arr];
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = path.CGPath;
        UIColor *color = self.colorArr[i];
        layer.lineWidth = LINEWIDTH;
        layer.strokeColor = color.CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];
        [self.layerArr addObject:layer];
    }
}
//获取BezierPath
- (UIBezierPath *)getLinePath:(NSArray *)arr {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (int i = 0; i < arr.count; i ++) {
        CGFloat x = i * TRANSVERMARGIN;
        CGFloat y = self.bounds.size.height - LINESEPARATE / 2 - LINESEPARATE * ([arr[i] floatValue] / self.maxValue * 5);
        if (i == 0) {
            [path moveToPoint:CGPointMake(x, y)];
        }else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    return path;
}

#pragma mark - 清空
//清除当前折线
- (void)clearnLayer {
    for (CALayer *layer in self.layerArr) {
       [layer removeFromSuperlayer];
    }
    [self.layerArr removeAllObjects];
}

@end
