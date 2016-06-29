//
//  XHGraphsMainView.h
//  LineDemo
//
//  Created by XuHuan on 16/3/7.
//  Copyright © 2016年 XuHuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHGraphsMainView;
@protocol XHGraphsMainViewDelegate <NSObject>
//左滑
- (NSArray *)graphsMainViewLeft:(XHGraphsMainView *)graphsMainView;
//又滑
- (NSArray *)graphsMainViewRight:(XHGraphsMainView *)graphsMainView;

@end

@interface XHGraphsMainView : UIView

@property (weak, nonatomic) id<XHGraphsMainViewDelegate> delegate;
@property (strong, nonatomic) NSArray *dateArr;//**<  */


@end
