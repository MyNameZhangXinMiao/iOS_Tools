//
//  JJFunctionGroupViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/10/20.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJFunctionGroupViewController.h"
#import "JJEmptyViewController.h"
#import "JJBrowserListController.h"
#import "JJAutoRunViewController.h"  //跑马灯
#import "JJButtonViewController.h"


@interface JJFunctionGroupViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) JJTableView *tableView;

@property (nonatomic, strong) NSArray *data;


@end

@implementation JJFunctionGroupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"功能模块封装";
    
    
    [self setupUI];
}


#pragma mark -
#pragma mark - 初始化界面
- (void)setupUI
{
    self.data = @[@"空态图",@"图片浏览器",@"跑马灯",@"图文按钮",@"自定义Toast"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(kNavBarHeight);
    }];
    
    
    
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
    
    if (indexPath.row == 0) {
        JJEmptyViewController *vc = [[JJEmptyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        JJBrowserListController *vc = [[JJBrowserListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        JJAutoRunViewController *vc = [[JJAutoRunViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        JJButtonViewController *vc = [[JJButtonViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    

}


#pragma mark - getter and setter

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
