//
//  JJHomeViewController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/18.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJHomeViewController.h"
#import "JJEmptyViewController.h"
#import "JJDarkModeViewController.h"
#import "JJBrowserListController.h"
#import "JJAutoRunViewController.h"  //跑马灯
#import "JJMoreScrollViewController.h"



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

    self.data = @[@"空态图",@"自定义Toast",@"MBProgressHUD",@"自定义转场动画",@"暗黑模式适配",@"图片浏览器",@"跑马灯",@"scrollView嵌套"];
    
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
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
    if ([text isEqualToString:@"空态图"]) {
        JJEmptyViewController *vc = [[JJEmptyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"暗黑模式适配"]) {
        JJDarkModeViewController *vc = [[JJDarkModeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"图片浏览器"]){
        JJBrowserListController *vc = [[JJBrowserListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"跑马灯"]){
        JJAutoRunViewController *vc = [[JJAutoRunViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"scrollView嵌套"]){
        JJMoreScrollViewController *vc = [[JJMoreScrollViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark - getter and setter

- (JJBaseNavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[JJBaseNavigationView alloc] init];
        _navigationView.title = @"首页";
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
