//
//  JJMineViewController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJMineViewController.h"
#import <JXPagingView/JXPagerView.h>
#import "JXCategoryTitleView.h"
#import "JXCategoryView.h"
#import "JJUserHeaderView.h"
#import "JJUserInfoBaseView.h"

static const CGFloat JJTableHeaderViewHeight = 200;
static const CGFloat JJheightForHeaderInSection = 50;

@interface JJMineViewController ()
<JXPagerViewDelegate,
JXCategoryViewDelegate
>

@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) JJUserHeaderView *userHeaderView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

@implementation JJMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人中心";
    self.fd_prefersNavigationBarHidden = YES;
    _titles = @[@"能力", @"爱好", @"队友"];

    self.navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    self.navigationView.backgroundColor = [UIColor whiteColor];
    self.navigationView.alpha = 0;
    _userHeaderView = [[JJUserHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JJTableHeaderViewHeight)];

    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JJheightForHeaderInSection)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    lineView.indicatorWidth = 30;
    self.categoryView.indicators = @[lineView];

    _pagingView = [[JXPagerView alloc] initWithDelegate:self];
    self.pagingView.pinSectionHeaderVerticalOffset = kNavBarHeight;
    [self.view addSubview:self.pagingView];

    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagingView.listContainerView;

    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
    [self.view addSubview:self.navigationView];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pagingView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight);
    
}

#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JJTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JJheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    JJUserInfoBaseView *list = [[JJUserInfoBaseView alloc] init];
    if (index == 0) {
        list.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮"].mutableCopy;
    }else if (index == 1) {
        list.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;
    }else if (index == 2) {
        list.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾"].mutableCopy;
    }
    return list;
}

- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView{
    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
    CGFloat h = scrollView.contentOffset.y;
    if (h < 20) {
        self.navigationView.alpha = 0;
    }else if (h > JJTableHeaderViewHeight){
        self.navigationView.alpha = 1;
    }else{
        self.navigationView.alpha = (h - 30)/(112-30);
    }
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

@end



