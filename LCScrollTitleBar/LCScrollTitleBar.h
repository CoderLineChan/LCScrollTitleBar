//
//  LCScrollTitleBar.h
//  scrollTitleBarDemo
//
//  Created by 陈连辰 on 16/9/25.
//  Copyright © 2016年 linechan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCScrollTitleBar;

@protocol LCScrollTitleBarDelegate <NSObject>

- (void)scrollTitleBar:(LCScrollTitleBar *)titleBar didClickIndex:(NSInteger)index;

@end

@interface LCScrollTitleBar : UIView
/** 代理 */
@property(nonatomic,weak)id<LCScrollTitleBarDelegate> delegate;



/**
 设置全部标题
 
 **** 注意 ****    设置标题 需要在最后面设置    **** 注意 ****
 */
@property(nonatomic,strong)NSArray *titleNames;




/**
 设置字体的颜色 及 字体大小

 @param color     正常状态颜色 - 默认灰色
 @param selColor  选中状态颜色 - 默认红色
 @param titleFont 字体大小    - 默认 14
 */
- (void)setTitleColor:(UIColor *)color selectColor:(UIColor *)selColor titleFont:(UIFont *)titleFont;

/**
 设置指示器(底下的线)

 @param color  指示器的颜色 - 默认红色
 @param Height 指示器的高度 - 默认 1
 */
- (void)setIndicatorColor:(UIColor *)color indicatorHeight:(CGFloat)Height;


/**
 设置标题
 
 @param titleName 传入的所有标题名字
 
 **** 注意 **** 设置标题 需要在确定Frame 以及 在设置相关属性之后    **** 注意 ****
 */
- (void)setUpScrollTitleBar:(NSArray *)titleName;

/**
 *  改变按钮的选中
 */
- (void)titleBarScrollIndex:(NSInteger)index;

@end
