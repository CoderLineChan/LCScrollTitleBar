//
//  LCScrollTitleBar.m
//  scrollTitleBarDemo
//
//  Created by 陈连辰 on 16/9/25.
//  Copyright © 2016年 linechan. All rights reserved.
//

#import "LCScrollTitleBar.h"
#import "UIView+LCFrame.h"

#define LCScreenW [UIScreen mainScreen].bounds.size.width
//#define LCTitleBarH 40

#define MinTitleMargin 20
#define MinTitleCount 6

static CGFloat const LCTitleBarH = 40;
static CGFloat const LCNoticeViewMargin = 5;

@interface LCScrollTitleBar ()



/** 滚动视图 */
@property(nonatomic,weak) UIScrollView *titleScrollView;
/** 滚动视图的背景颜色 */
@property(nonatomic,strong) UIColor *titleScrollViewColor;


/** 弹出通知View */
@property(nonatomic,weak) UIView *noticeView;
/** 弹出通知的内容 */
@property(nonatomic,weak) UILabel *noticeLabel;
/** 弹出通知View的颜色 */
@property(nonatomic,weak) UIColor *noticeColor;
/** 弹出通知字体内容的颜色 */
@property(nonatomic,weak) UIColor *noticeTextColor;
/** 是否需要弹出通知 */
@property(nonatomic,assign) BOOL isShowNoticeView;

/** 标题高度 */
@property(nonatomic,assign) CGFloat titleheight;
/** 标题间距 */
@property(nonatomic,assign) CGFloat titleMargin;
/** 标题的总宽度 */
@property(nonatomic,assign) CGFloat totalWidth;
/** 存放标题的数组 */
@property(nonatomic,strong) NSMutableArray *titleWidths;
/** 存放label的数组 */
@property(nonatomic,strong) NSMutableArray *titleLabels;
/** 选中的label */
@property(nonatomic,strong) UILabel *selectLabel;
/** 字体的正常状态颜色 */
@property(nonatomic,strong) UIColor *norColor;
/** 字体的选中状态颜色 */
@property(nonatomic,strong) UIColor *selColor;
/** 字体的大小 */
@property(nonatomic,strong) UIFont *titleFont;


/** 滚动指示条 */
@property(nonatomic,weak) UIView *indicatorLine;
/** 指示条颜色 */
@property(nonatomic,strong) UIColor *indicatorColor;
/** 指示条高度 */
@property(nonatomic,assign) CGFloat indicatorH;
/** 是否需要指示条 */
@property(nonatomic,assign) BOOL isShowIndicatorLine;



@end
@implementation LCScrollTitleBar

#pragma mark - 基本属性的初始化
-(void)setTitleScrollViewColor:(UIColor *)titleScrollViewColor{
    _titleScrollViewColor = titleScrollViewColor;
    if (titleScrollViewColor == nil) {
        _titleScrollViewColor = [UIColor colorWithWhite:1 alpha:0.85];
    }
}
-(void)setNorColor:(UIColor *)norColor{
    _norColor = norColor;
    if (norColor == nil) {
        _norColor = [UIColor grayColor];
    }
}
-(void)setSelColor:(UIColor *)selColor{
    _selColor = selColor;
    if (selColor == nil) {
        _selColor = [UIColor redColor];
    }
}
-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    if (titleFont == nil) {
        _titleFont = [UIFont systemFontOfSize:14];
    }
}
-(void)setIndicatorColor:(UIColor *)indicatorColor{
    _indicatorColor = indicatorColor;
    if (indicatorColor == nil) {
        _indicatorColor = [UIColor redColor];
    }
}
-(void)setIndicatorH:(CGFloat)indicatorH{
    _indicatorH = indicatorH;
    if (indicatorH == 0) {
        _indicatorH = 2;
    }
}
-(void)setNoticeColor:(UIColor *)noticeColor{
    _noticeColor = noticeColor;
    if (noticeColor == nil) {
        _noticeColor = [UIColor colorWithRed:0.3037 green:0.6531 blue:0.9691 alpha:0.94];
    }
}
-(void)setNoticeTextColor:(UIColor *)noticeTextColor{
    _noticeTextColor = noticeTextColor;
    if (noticeTextColor == nil) {
        _noticeTextColor = [UIColor whiteColor];
    }
}

#pragma mark - 懒加载视图控件
/**
 *  弹出通知View
 */
- (UIView *)noticeView {
    if (!_noticeView) {
        UIView *view = [[UIView alloc] init];
        _noticeView = view;
        _noticeView.alpha = 0.0;
        _noticeView.backgroundColor = [UIColor blueColor];
        [self addSubview:_noticeView];
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = _noticeView.bounds;
        [_noticeView addSubview:label];
        
        
    }
//    if (self.isShowNoticeView) {
//        return _noticeView;
//    }
//    return nil;

    return _noticeView;
}
/**
 *  存放每个标题的字体宽度
 */
- (NSMutableArray *)titleWidths {
    if (!_titleWidths) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}
/**
 *  存放标题
 */
- (NSMutableArray *)titleLabels {
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}
/**
 *  滚动指示条
 */
- (UIView *)indicatorLine {
    if (!_indicatorLine) {
        UIView *indicatorLine = [[UIView alloc] init];
        _indicatorLine = indicatorLine;
        indicatorLine.backgroundColor = _indicatorColor;
        [self.titleScrollView addSubview:_indicatorLine];
    }
    return _indicatorLine;
}
/**
 *  滚动视图
 */
- (UIScrollView *)titleScrollView {
    if (_titleScrollView == nil) {
        UIScrollView *titleScrollView = [[UIScrollView alloc] init];
        titleScrollView.backgroundColor = self.titleScrollViewColor;
        [self addSubview:titleScrollView];
        _titleScrollView = titleScrollView;
    }
    return _titleScrollView;
}

-(void)setTitleColor:(UIColor *)color selectColor:(UIColor *)selColor titleFont:(UIFont *)titleFont{
    self.norColor = color;
    self.selColor = selColor;
    self.titleFont = titleFont;
}

-(void)setIndicatorColor:(UIColor *)color indicatorHeight:(CGFloat)Height{
    self.indicatorColor = color;
    self.indicatorH = Height;
}

#pragma mark - 初始化操作
-(void)setUpScrollTitleBar:(NSArray *)titleName{
    [self setTitleNames:titleName];
}

+ (instancetype)titleViewWithNames:(NSArray *)titleName{
    return [[self alloc] initWithTitleNames:titleName];
}

+ (instancetype)titleView{
    return [[self alloc] init];
}

-(instancetype)initWithTitleNames:(NSArray *)titleName{
    if (self = [super init]) {
        self.titleNames = titleName;
    }
    return self;
}
-(instancetype)init{
    if (self = [super init]) {
        [self initTitle];
    }
    return self;
}

/**
 初始化基本属性
 */
- (void)initTitle{
    self.titleheight = LCTitleBarH;
    self.isShowNoticeView = NO;
    self.indicatorH = 1;
    self.isShowIndicatorLine = YES;
    self.indicatorColor = nil;
    self.titleFont = [UIFont systemFontOfSize:14];
    self.norColor = [UIColor grayColor];
    self.selColor = [UIColor redColor];
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

/**
 * 初始化操作
 */
-(void)setTitleNames:(NSArray *)titleNames{
    _titleNames = titleNames;
    [self setTitleWidth:titleNames];
    self.noticeView.frame = CGRectMake(0, 0, LCScreenW, LCTitleBarH - 10);
    self.titleScrollView.frame = CGRectMake(0, 0, self.lc_width, LCTitleBarH);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    CGFloat labX = 0;
    CGFloat labY = 0;
    CGFloat labW = 0;
    CGFloat labH = LCTitleBarH;
    for (int i = 0; i < titleNames.count; i++) {
        UILabel *label = [[UILabel alloc] init];;
        label.tag = i;
        [label setText:titleNames[i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:self.titleFont];
        [label setTextColor:self.norColor];
        label.userInteractionEnabled = YES;
        labW = [_titleWidths[i] integerValue] + _titleMargin * 2;
        label.frame = CGRectMake(labX, labY, labW, labH);
        labX = labX + labW;
        [self.titleLabels addObject:label];
        [_titleScrollView addSubview:label];
        if (i == 0) {
            self.indicatorLine.frame = CGRectMake(_titleMargin, _titleheight - _indicatorH, self.lc_width, _indicatorH);
            self.indicatorLine.lc_width = [self.titleWidths[i] integerValue];
            self.indicatorLine.lc_centerX = label.lc_centerX;
            [self selectLabel:label];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
    }
    UILabel *lastLabel = self.titleLabels.lastObject;
    _titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), labH);
    
}



#pragma mark - 标题的点击事件
/**
 *  监听标题的点击
 */
-(void)titleClick:(UITapGestureRecognizer *)tap{
    UILabel *label = (UILabel *)tap.view;
        if ([self.delegate respondsToSelector:@selector(scrollTitleBar:didClickIndex:)]) {
            [self.delegate scrollTitleBar:self didClickIndex:label.tag];
        }
    if (label == self.selectLabel){
        [self showNoticeView:nil];
        // 如果连续点击两次相同的按钮 发送通知执行刷新操作
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
    }
    [self selectLabel:label];
}
/**
 *  改变label的选中 和 颜色
 */
-(void)titleBarScrollIndex:(NSInteger)index{
    UILabel *label = self.titleLabels[index];
    [self selectLabel:label];
}
/**
 *  改变label的颜色
 */
-(void)selectLabel:(UILabel *)label{
    if (label != self.selectLabel) {
        label.textColor = self.selColor;
        self.selectLabel.textColor = self.norColor;
        self.selectLabel = label;
        CGFloat textWidth = [_titleWidths[label.tag] integerValue];
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorLine.lc_width = textWidth;
            self.indicatorLine.lc_centerX = label.lc_centerX;
        }];
    }
}
#pragma mark - 计算标题
/**
 计算标题的间距,  文字的宽度,  文字的总长度
 */
- (void)setTitleWidth:(NSArray *)titleNames{
    CGFloat totalWidth = 0;
    for (NSString *title in titleNames) {
        CGFloat textWidth = [self calculateTitleSize:title withMaxSize:CGSizeMake(MAXFLOAT, 0) withTextFont:self.titleFont].width;
        totalWidth += textWidth;
        [self.titleWidths addObject:@(textWidth)];
    }
    _totalWidth = totalWidth;
    CGFloat titleMargin = (self.lc_width - totalWidth) / (titleNames.count + 1);
    CGFloat totalWidthScale = self.lc_width / LCScreenW;
    if (totalWidth > self.lc_width) {
        _titleMargin = MinTitleMargin;
    }else{
        if (titleNames.count <= MinTitleCount) {
            _titleMargin = (self.lc_width / titleNames.count - _totalWidth * totalWidthScale / titleNames.count) / 2;
        }else{
            _titleMargin = titleMargin > MinTitleMargin ? titleMargin : MinTitleMargin;
        }
    }
}
/**
 *  计算文字的 尺寸
 */
-(CGSize)calculateTitleSize:(NSString *)title withMaxSize:(CGSize)maxSize withTextFont:(UIFont *)font{
    return [title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
#pragma mark - 接收通知 显示提示信息
// 弹出通知
-(void)showNoticeView:(NSNotification *)note{
    // 开始提示前 先把之前的位移以及 延迟操作 取消
    self.noticeView.lc_y = 5;
    self.noticeView.alpha = 0;
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    
    NSString *title = note.object;
    self.noticeLabel.text = title;
    self.noticeView.alpha = 1;
    [UIView animateWithDuration:0.6 animations:^{
        self.noticeView.lc_y = 45;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(cancel) withObject:self afterDelay:1.5];
    }];
}
// 延迟操作
-(void)cancel{
    [UIView animateWithDuration:0.25 animations:^{
        self.noticeView.lc_y = 5;
        self.noticeView.alpha = 0;
    }];
}
#pragma mark - 固定视图的高度
-(void)layoutSubviews{
    [super layoutSubviews];
    self.lc_height = LCTitleBarH;
}



@end
