//
//  KLMessageViewController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "KLMessageViewController.h"
#import "JXCategoryTitleView.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "KLMsgSystemViewController.h"



#define CategoryHeight 50

@interface KLMessageViewController ()
<JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate
>

@property (nonatomic, strong) JXCategoryIndicatorBackgroundView *indicatorView;

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) NSArray *titles;


@end
 
@implementation KLMessageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"3232";
    self.view.backgroundColor = [UIColor whiteColor];
    self.titles = @[@"消息一",@"消息二",@"消息三"];
    
    self.myCategoryView = [[JXCategoryTitleView alloc] init];
    self.myCategoryView.frame = CGRectMake(0, 0, 180, 30);
    self.myCategoryView.layer.masksToBounds = YES;
    self.myCategoryView.layer.cornerRadius = 15;
    self.myCategoryView.layer.borderColor = [UIColor redColor].CGColor;
    self.myCategoryView.layer.borderWidth = 1;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.titleColor = [UIColor redColor];
    self.myCategoryView.titleSelectedColor = [UIColor whiteColor];
    self.myCategoryView.titleLabelMaskEnabled = YES;
    self.myCategoryView.delegate = self;
    self.myCategoryView.titleFont = kFont_Medium(16);
    self.myCategoryView.backgroundColor = [UIColor whiteColor];
//    self.myCategoryView.selectedAnimationEnabled = YES;
//    self.myCategoryView.averageCellSpacingEnabled = NO;
//    self.myCategoryView.titleColorGradientEnabled = YES;
//    self.myCategoryView.titleLabelZoomEnabled = YES;
//    self.myCategoryView.titleLabelZoomScale = 1.2;
    
    self.indicatorView = [[JXCategoryIndicatorBackgroundView alloc] init];
    self.indicatorView.indicatorHeight = 30;
    self.indicatorView.indicatorWidthIncrement = 20;
    self.indicatorView.indicatorColor = [UIColor redColor];
    
    self.myCategoryView.indicators = @[self.indicatorView];
    [self.myCategoryView removeFromSuperview];
    self.navigationItem.titleView = self.myCategoryView;
    
    self.listContainerView = ({
        JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:(JXCategoryListContainerType_ScrollView) delegate:self];
        listContainerView.defaultSelectedIndex = 0;
        listContainerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, kScreenHeight-kTabBarHeight-kNavBarHeight);
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
    KLMsgSystemViewController *vc = [[KLMsgSystemViewController alloc] init];
    if (index == 0) {
        vc.titles = @[@"香蕉", @"苹果", @"荔枝"];
    }else if (index == 1) {
        vc.titles = @[@"冰淇淋", @"可乐"];
    }else{
        vc.titles = @[@"火锅", @"砂锅", @"干锅"];
    }
    return vc;

}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

 
@end

