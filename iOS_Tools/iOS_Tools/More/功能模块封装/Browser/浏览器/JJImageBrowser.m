//
//  JJImageBrowser.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/6.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJImageBrowser.h"
#import "JJImageModel.h"
#import "JJImageBrowserCell.h"
#import "JJPhotoBrowserFlowLayout.h"


#define minimumSpacing 10
@interface JJImageBrowser ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray  <JJImageModel *> *images;

@property (nonatomic, weak)   UIViewController *presentVC;

@property (nonatomic, assign)   NSInteger currentIndex;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;


@end


@implementation JJImageBrowser

- (instancetype)initWithPresentVC:(UIViewController *)presentVC withData:(NSArray <JJImageModel *>*)images{
    self = [super init];
    if (self) {
        self.currentIndex = 0;
        self.presentVC = presentVC;
        self.images = images;
    }
    return self;
}

- (void)showWith:(NSInteger)index{
    self.currentIndex = index;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.edgesForExtendedLayout = YES;
    [self.presentVC presentViewController:self animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    [self setupUI];
    [self setupPage];
    
    if (self.currentIndex > 0) {
        
        [self.collectionView setContentOffset:CGPointMake((self.view.bounds.size.width + minimumSpacing) * self.currentIndex, 0) animated:YES];
    }
}


- (void)setupUI {
    JJPhotoBrowserFlowLayout *layout = [[JJPhotoBrowserFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //确定item的大小
    layout.itemSize = self.view.bounds.size;
    //确定横向间距
    layout.minimumLineSpacing = minimumSpacing;
    //确定纵向间距
    layout.minimumInteritemSpacing = 0;
    //确定距离上左下右的距离
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //头尾部高度
    layout.headerReferenceSize = CGSizeMake(0, 0);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    //确定滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.view addSubview:self.collectionView];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
//    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor blackColor];

    [self.collectionView registerClass:[JJImageBrowserCell class] forCellWithReuseIdentifier:@"JJImageBrowserCell"];
    
}

- (void)setupPage{
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - kTabBarHeight, self.view.bounds.size.width, 20)];
    
    _pageControl.numberOfPages = self.images.count;
    _pageControl.pageIndicatorTintColor = [UIColor redColor]; // 设置非选中页的圆点颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor]; // 设置选中页的圆点颜色
    
    [self.view addSubview:self.pageControl];
    self.pageControl.currentPage = self.currentIndex;

}


#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJImageBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JJImageBrowserCell" forIndexPath:indexPath];
    
    cell.imageModel = self.images[indexPath.row];
    @weakify(self);
    cell.tapImageActionBlock = ^{
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat w = scrollView.contentOffset.x;
    
    int index = w/self.view.bounds.size.width;
    
    self.pageControl.currentPage = index;
    
}

//- (CGPoint)collectionView:(UICollectionView *)collectionView targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
//
//}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
}


@end
