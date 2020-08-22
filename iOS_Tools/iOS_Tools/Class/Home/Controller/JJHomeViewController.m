//
//  JJHomeViewController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/18.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJHomeViewController.h"
#import "JJVideoFollowViewController.h"
#import "JJVideoFocusViewController.h"
#import "JXCategoryTitleView.h"

@interface JJHomeViewController ()
<JXCategoryViewDelegate
>

#define CategoryHeight 50

@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation JJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titles = @[@"关注",@"推荐"];
    self.myCategoryView = ({
        JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] init];
        titleView.frame = CGRectMake(0, kStatusBarHeight, kScreenWidth, CategoryHeight);
        titleView.delegate = self;
        titleView.titleFont = kFont_Medium(16);
        titleView.titles = self.titles;

        titleView.selectedAnimationEnabled = YES;
        titleView.averageCellSpacingEnabled = NO;
        titleView.titleColorGradientEnabled = YES;
        titleView.titleLabelZoomEnabled = YES;
        titleView.titleLabelZoomScale = 1.2;
        /// lineView
        self.lineView = [[JXCategoryIndicatorLineView alloc] init];
        self.lineView.indicatorWidth = 20;
        self.lineView.lineStyle = JXCategoryIndicatorLineStyle_LengthenOffset;
        self.lineView.indicatorColor = [UIColor blueColor];
        self.lineView.indicatorCornerRadius = 2;
        titleView.indicators = @[self.lineView];
        
        titleView;
    });
    [self.view addSubview:self.myCategoryView];

    self.listContainerView = ({
        JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:(JXCategoryListContainerType_ScrollView) delegate:self];
        listContainerView.defaultSelectedIndex = 0;
        listContainerView.frame = CGRectMake(0, CategoryHeight + kStatusBarHeight, self.view.bounds.size.width, kScreenHeight-CategoryHeight-kTabBarHeight-kNavBarHeight);
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
    if (index == 0) {
        JJVideoFocusViewController *vc = [[JJVideoFocusViewController alloc] init];
        return vc;
    }else{
        JJVideoFollowViewController *vc = [[JJVideoFollowViewController alloc] init];
        return vc;
    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}


@end
