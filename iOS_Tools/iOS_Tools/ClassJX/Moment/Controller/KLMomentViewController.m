//
//  KLMomentViewController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/20.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "KLMomentViewController.h"
#import "KLZoomHeaderViewController.h"

@interface KLMomentViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <NSString *> *dataSource;

@end

@implementation KLMomentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"头部缩放",@"主页下拉刷新&子页上拉加载",@"子页下拉刷新",@"page嵌套多个子页面",@"顶部轮播banner",@"悬浮SectionHeader位置处理"];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}
#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.dataSource[indexPath.row];
    if ([str isEqualToString:@"头部缩放"]) {
        KLZoomHeaderViewController *vc = [[KLZoomHeaderViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"主页下拉刷新&子页上拉加载"]) {
        
    }else if ([str isEqualToString:@"子页下拉刷新"]) {
        
    }else if ([str isEqualToString:@"page嵌套多个子页面"]) {
        
    }else if ([str isEqualToString:@"顶部轮播banner"]) {
        
    }else if ([str isEqualToString:@"悬浮SectionHeader位置处理"]) {
        
    }
}

@end
