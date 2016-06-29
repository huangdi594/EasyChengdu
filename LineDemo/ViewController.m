//
//  ViewController.m
//  LineDemo
//
//  Created by XuHuan on 16/3/7.
//  Copyright © 2016年 XuHuan. All rights reserved.
//

#import "ViewController.h"
#import "XHGraphsView.h"
#import "XHGraphsMainView.h"

@interface ViewController ()<XHGraphsMainViewDelegate>

@property (strong, nonatomic) XHGraphsMainView *xh;//**< <#name#> */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.xh = [[[NSBundle mainBundle] loadNibNamed:@"XHGraphsMainView" owner:self options:nil]lastObject];
    self.xh.frame = CGRectMake(0, 0, 1000, 800);
    self.xh.delegate = self;
    [self.view addSubview:self.xh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)test:(id)sender {
    self.xh.dateArr = [self getArr];
}

#pragma mark - delegate
- (NSArray *)graphsMainViewLeft:(XHGraphsMainView *)graphsMainView {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++) {
        NSDictionary *dic = @{@"time":@"1453978435",
                              @"hasMonitoredNum":@"21",
                              @"programRunNum":@"8",
                              @"SASNum":@"23",
                              @"COPDNum":@"14",
                              @"OSANum":@"2",
                              };
        [arr addObject:dic];
    }
    
    return arr;
}

- (NSArray *)graphsMainViewRight:(XHGraphsMainView *)graphsMainView {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++) {
        NSDictionary *dic = @{@"time":@"1452978435",
                              @"hasMonitoredNum":@"23",
                              @"programRunNum":@"32",
                              @"SASNum":@"33",
                              @"COPDNum":@"22",
                              @"OSANum":@"44",
                              };
        [arr addObject:dic];
    }
    
    return arr;
}

- (NSArray *)getArr {
    
//    { "time":1451978435,      日期
//        "hasMonitoredNum":300,  监测患者总数
//        " programRunNum":500,   方案运行数
//        "SASNum":200,            睡眠呼吸暂停综合 征初筛监测数
//        "COPDNum":260,            慢性阻塞性肺疾病 监护监测数
//        "OSANum":40               夜间低氧血症初筛 监测数
//    }
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++) {
        NSDictionary *dic = @{@"time":@"1452978435",
                              @"hasMonitoredNum":@"23",
                              @"programRunNum":@"32",
                              @"SASNum":@"40",
                              @"COPDNum":@"33",
                              @"OSANum":@"11",
                              };
        [arr addObject:dic];
    }
    
    return arr;
}

@end
