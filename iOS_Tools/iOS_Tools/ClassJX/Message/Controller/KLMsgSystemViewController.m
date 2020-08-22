//
//  KLMsgSystemViewController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "KLMsgSystemViewController.h"
#import "JXCategoryTitleView.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "KLMsgDetailViewController.h"


#define CategoryHeight 40

@interface KLMsgSystemViewController ()
<JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate
>

@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation KLMsgSystemViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"3232";
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    self.view.layer.borderWidth = 2;
    self.myCategoryView = [[JXCategoryTitleView alloc] init];
    self.myCategoryView.frame = CGRectMake(0, 0, 180, CategoryHeight);
    self.myCategoryView.layer.masksToBounds = YES;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleColor = [UIColor blackColor];
    self.myCategoryView.titleSelectedColor = [UIColor blueColor];
    self.myCategoryView.delegate = self;
    self.myCategoryView.titleFont = kFont_Medium(16);
    self.myCategoryView.selectedAnimationEnabled = YES;
    self.myCategoryView.averageCellSpacingEnabled = NO;
    self.myCategoryView.titleColorGradientEnabled = YES;
    self.myCategoryView.titleLabelZoomEnabled = YES;
    self.myCategoryView.titleLabelZoomScale = 1.2;
    
    
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = 20;
    self.lineView.lineStyle = JXCategoryIndicatorLineStyle_LengthenOffset;
    self.lineView.indicatorColor = [UIColor blueColor];
    self.lineView.indicatorCornerRadius = 2;
    self.myCategoryView.indicators = @[self.lineView];

    [self.view addSubview:self.myCategoryView];
    
    self.listContainerView = ({
        JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:(JXCategoryListContainerType_ScrollView) delegate:self];
        listContainerView.defaultSelectedIndex = 0;
        listContainerView.frame = CGRectMake(0, CategoryHeight, self.view.bounds.size.width, kScreenHeight-kNavBarHeight-kTabBarHeight-CategoryHeight);
        [self.view addSubview:listContainerView];
        listContainerView;
    });
    self.myCategoryView.listContainer = self.listContainerView;
    
}
 
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.myCategoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    KLMsgDetailViewController *vc = [[KLMsgDetailViewController alloc] init];
    return vc;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}


#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}
@end
