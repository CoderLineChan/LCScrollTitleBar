//
//  ViewController.m
//  LCScrollTitleBarDemo
//
//  Created by 陈连辰 on 16/9/25.
//  Copyright © 2016年 linechan. All rights reserved.
//


#import "ViewController.h"
#import "LCScrollTitleBar.h"


#import "HotViewController.h"
#import "ReaderViewController.h"
#import "ScienceViewController.h"
#import "SocietyViewController.h"
#import "TopViewController.h"
#import "VideoViewController.h"



#define LCScreeW [UIScreen mainScreen].bounds.size.width
#define LCScreeH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LCScrollTitleBarDelegate>

/** 存放子控制器view */
@property(nonatomic,weak)UICollectionView *collection;
/** 标题栏 */
@property(nonatomic,strong)LCScrollTitleBar *scrollTitleBar;

/** 记录scrollView滚动的页码 */
@property(nonatomic,assign)NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self setupAllChildViewController];
    
    
    [self setCollectionView];
    
    [self setTitleScrollView];
    
    
    
    
}
-(void)setTitleScrollView{
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
    LCScrollTitleBar *scrollTitleBar = [[LCScrollTitleBar alloc] init];
    scrollTitleBar.frame = CGRectMake(0, 64, LCScreeW, 40);
    _scrollTitleBar = scrollTitleBar;
    scrollTitleBar.delegate = self;
    
    
    
    [scrollTitleBar setUpScrollTitleBar:titles];
    [self.view addSubview:scrollTitleBar];
}

/**
 *  添加collectionView
 */
-(void)setCollectionView{
    
    UICollectionViewFlowLayout *vfl = [[UICollectionViewFlowLayout alloc] init];
    vfl.minimumLineSpacing = 0;
    vfl.minimumInteritemSpacing = 0;
    vfl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    vfl.itemSize = [UIScreen mainScreen].bounds.size;
    
    
    
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:vfl];
    collectionV.backgroundColor = [UIColor blueColor];
    collectionV.pagingEnabled = YES;
    [collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"LCCollectionID"];
    
    collectionV.dataSource = self;
    collectionV.delegate = self;
    
    _collection = collectionV;
    [self.view addSubview:collectionV];
    
    
}

- (void)scrollTitleBar:(LCScrollTitleBar *)titleBar didClickIndex:(NSInteger)index{
        CGFloat offsetX = index * LCScreeW;
        self.collection.contentOffset = CGPointMake(offsetX, 0);
}

#pragma mark - collectionView 代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childViewControllers.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LCCollectionID" forIndexPath:indexPath];
    UITableViewController *vc = self.childViewControllers[indexPath.row];
    vc.view.frame = [UIScreen mainScreen].bounds;
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    vc.tableView.contentInset = UIEdgeInsetsMake(104, 0, 0, 0);
    vc.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(104, 0, 0, 0);
    
    [cell.contentView addSubview:vc.view];
    
    

    return cell;
    
}
#pragma mark - 监听内容页面的滚动
/**
 *  滚动完成后调用
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / LCScreeW;
    // 滚动一页 再进行刷新
    if (_index == index) return;
    [self.scrollTitleBar titleBarScrollIndex:index];
    _index = index;
}



















- (void)setupAllChildViewController
{
    TopViewController *topVc = [[TopViewController alloc] init];
    topVc.title = @"头条";
    [self addChildViewController:topVc];
    
    HotViewController *hotVc = [[HotViewController alloc] init];
    hotVc.title = @"热点热点热点";
    [self addChildViewController:hotVc];
    
    VideoViewController *videoVc = [[VideoViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    SocietyViewController *societyVc = [[SocietyViewController alloc] init];
    societyVc.title = @"社";
    [self addChildViewController:societyVc];
    
    ReaderViewController *readerVc = [[ReaderViewController alloc] init];
    readerVc.title = @"阅读";
    [self addChildViewController:readerVc];

    ScienceViewController *scienceVc = [[ScienceViewController alloc] init];
    scienceVc.title = @"科";
    [self addChildViewController:scienceVc];
    
//    ScienceViewController *scienceVc2 = [[ScienceViewController alloc] init];
//    scienceVc2.title = @"微商";
//    [self addChildViewController:scienceVc2];
}



@end
