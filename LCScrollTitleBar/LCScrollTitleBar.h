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

- (void)titleView:(LCScrollTitleBar *)titleView didClickBtnIndex:(NSInteger)index;

@end

@interface LCScrollTitleBar : UIView
/** 代理 */
@property(nonatomic,weak)id<LCScrollTitleBarDelegate> delegate;

/** 传入的标题名 */
@property(nonatomic,strong)NSArray *titleNames;


/**
 *  设置滚动标题
 */
- (void)setUpScrollTitleBar:(NSArray *)titleName;
+ (instancetype)titleView;

//- (instancetype)initWithTitleNames:(NSArray *)titleName;

//+ (instancetype)titleViewWithNames:(NSArray *)titleName;


/**
 *  改变按钮的选中
 */
- (void)titleBarScrollIndex:(NSInteger)index;

@end
