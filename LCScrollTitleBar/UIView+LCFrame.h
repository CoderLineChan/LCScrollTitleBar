//
//  UIView+LCFrame.h
//  各种分类
//
//  Created by 陈连辰 on 16/8/10.
//  Copyright © 2016年 linechen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCFrame)

@property (nonatomic, assign) CGSize lc_size;
@property (nonatomic, assign) CGFloat lc_x;
@property (nonatomic, assign) CGFloat lc_y;
@property (nonatomic, assign) CGFloat lc_width;
@property (nonatomic, assign) CGFloat lc_height;
@property (nonatomic, assign) CGFloat lc_centerX;
@property (nonatomic, assign) CGFloat lc_centerY;

/** 控件最右边线的位置(最大的X值) */
@property (nonatomic, assign) CGFloat lc_right;
/** 控件最左边线的位置(控件的X值) */
@property (nonatomic, assign) CGFloat lc_left;
/** 控件最顶部线的位置(控件的Y值) */
@property (nonatomic, assign) CGFloat lc_top;
/** 控件最底部线的位置(最大的Y值) */
@property (nonatomic, assign) CGFloat lc_bottom;



@end
