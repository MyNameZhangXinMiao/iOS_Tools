//
//  JJHomeViewController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/18.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJHomeViewController.h"
#import "JJTestViewController.h"
#import "JJDarkModeViewController.h"
#import "JJMoreScrollViewController.h"
#import "JJChartViewController.h"
#import "JJKVOViewController.h"
#import "JJChartViewController.h"
#import "JJApplePayViewController.h"
#import "JJAnimateViewController.h"
#import "JJFunctionGroupViewController.h"  //音视频图像
#import "JJVideoImagesViewController.h"  //功能模块封装
#import "JJBezierViewController.h"   //贝塞尔曲线


@interface JJHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JJBaseNavigationView *navigationView;

@property (nonatomic, strong) JJTableView *tableView;

@property (nonatomic, strong) NSArray *data;
@end

@implementation JJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    self.data = @[@"测试",@"MBProgressHUD",@"自定义转场动画",@"暗黑模式适配",@"scrollView嵌套",@"KVO",@"Chart图表",@"内购",@"动画",@"音视频图像",@"功能模块封装",@"贝塞尔曲线"];
    
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-kTabBarHeight);
        make.top.equalTo(self.view).mas_offset(kNavBarHeight);
    }];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kNavBarHeight);
    }];
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *text = self.data[indexPath.row];
    if ([text isEqualToString:@"测试"]){
        JJTestViewController *vc = [[JJTestViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"暗黑模式适配"]) {
        JJDarkModeViewController *vc = [[JJDarkModeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"scrollView嵌套"]){
        JJMoreScrollViewController *vc = [[JJMoreScrollViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"Chart图表"]){
        JJChartViewController *vc = [[JJChartViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"KVO"]){
        JJKVOViewController *vc = [[JJKVOViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"Chart图表"]){
        JJChartViewController *vc = [[JJChartViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"内购"]){
        JJApplePayViewController *vc = [[JJApplePayViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"动画"]){
        JJAnimateViewController *vc = [[JJAnimateViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"音视频图像"]){
        JJVideoImagesViewController *vc = [[JJVideoImagesViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"功能模块封装"]){
        JJFunctionGroupViewController *vc = [[JJFunctionGroupViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"贝塞尔曲线"]){
        JJBezierViewController *vc = [[JJBezierViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


#pragma mark - getter and setter

- (JJBaseNavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[JJBaseNavigationView alloc] init];
        _navigationView.title = @"首页";
        _navigationView.backBtn.hidden = YES;
    }
    return _navigationView;
}

- (JJTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[JJTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        //_tableView.showsVerticalScrollIndicator = NO;
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        } else {
            self.tableView.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
    }
    return _tableView;
}


@end
