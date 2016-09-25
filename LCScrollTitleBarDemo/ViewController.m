//
//  ViewController.m
//  LCScrollTitleBarDemo
//
//  Created by 陈连辰 on 16/9/25.
//  Copyright © 2016年 linechan. All rights reserved.
//

#import "ViewController.h"
#import "ViewController.h"
#import "LCScrollTitleBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSArray *arr = @[@"全部全全部",@"视频",@"图片图片图片",@"文字",@"音频",@"文字",@"音频",@"文字",@"音频"];
    NSArray *arr = @[@"全部",@"视频视频",@"图片",@"文字",@"音频",@"音频",@"音频",@"音频"];
    
    //    LCTitleView *view = [[LCTitleView alloc] initWithTitleNames:arr];
    //    LCTitleView *view1 = [LCTitleView titleViewWithNames:arr];
    LCScrollTitleBar *scrollTitleBar = [[LCScrollTitleBar alloc] init];
    scrollTitleBar.frame = CGRectMake(0, 0, 300, 60);
    [scrollTitleBar setUpScrollTitleBar:arr];
    [self.view addSubview:scrollTitleBar];
    
    
}


@end
