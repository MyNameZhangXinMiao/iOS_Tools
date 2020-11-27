//
//  JJBrowserListController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/6.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJBrowserListController.h"
#import "JJLocalImageViewController.h"


@interface JJBrowserListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JJBaseNavigationView *navigationView;

@property (nonatomic, strong) JJTableView *tableView;

@property (nonatomic, strong) NSArray *data;



@end

@implementation JJBrowserListController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    self.data = @[@"本地图片"];
    
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
    if ([text isEqualToString:@"本地图片"]) {
        JJLocalImageViewController *vc = [[JJLocalImageViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"暗黑模式适配"]) {
        JJLocalImageViewController *vc = [[JJLocalImageViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - getter and setter

- (JJBaseNavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[JJBaseNavigationView alloc] init];
        _navigationView.title = @"图片浏览器";
        @weakify(self);
        _navigationView.backBtnActionCallBack = ^{
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        };
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
    }
    return _tableView;
}


@end
