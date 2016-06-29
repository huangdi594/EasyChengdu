//
//  XHGraphsView.h
//  LineDemo
//
//  Created by XuHuan on 16/3/7.
//  Copyright © 2016年 XuHuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHGraphsView : UIView

- (void)setColorsArr:(NSArray *)arr;//设置折现颜色 不传入默认颜色
- (void)setDataArr:(NSArray *)arr maxValue:(CGFloat)maxValue;//设置折线数据 最大值

- (void)begin;//开始绘制

@end
