//
//  JJEmptyViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/8/23.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJEmptyViewController.h"
#import "UIView+JJEmptyView.h"

@interface JJEmptyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JJTableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation JJEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationCustomView.title = @"空态图";
    self.navigationCustomView.hidden = NO;

    [self getData];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(kNavBarHeight);
    }];
    
    
    
    for (int i = 0; i < 4; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10 * (i+1) + ((kScreenWidth - 50)/4) * i, kScreenHeight-100, (kScreenWidth - 50)/4, 40)];
        [self.view addSubview:button];
        button.tag = i;
        button.backgroundColor = [UIColor orangeColor];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [button setTitle:@"填充数据" forState:UIControlStateNormal];
        }else if (i == 1){
            [button setTitle:@"无网络" forState:UIControlStateNormal];
        }else if (i == 2){
            [button setTitle:@"无位置" forState:UIControlStateNormal];
        }else if (i == 3){
            [button setTitle:@"无数据" forState:UIControlStateNormal];
        }
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}



- (void)buttonClicked:(UIButton *)button{
    
    NSInteger i = button.tag;
    @weakify(self);
    if (i == 0) {
        [self.tableView jj_showPlaceholderViewWithType:(JJPlaceholderViewTypeNoNetwork) clickBlock:^(NSInteger index) {
            @strongify(self);
            [self getData];
            [self.tableView reloadData];
        }];
    }else if (i == 1){
        [self.tableView jj_showPlaceholderViewWithType:(JJPlaceholderViewTypeNoNetwork) clickBlock:^(NSInteger index) {
            @strongify(self);
            [self getData];
            [self.tableView reloadData];
        }];
        
        
        self.dataArray = [NSArray array];
        [self.tableView reloadData];
        
    }else if (i == 2){
        [self.tableView jj_showPlaceholderViewWithType:JJPlaceholderViewTypeNoLocation clickBlock:^(NSInteger index) {
            @strongify(self);
            [self getData];
            [self.tableView reloadData];
        }];
        
        
        self.dataArray = [NSArray array];
        [self.tableView reloadData];
        
        
    }else if (i == 3){
        
        [self.tableView jj_showPlaceholderViewWithType:JJPlaceholderViewTypeNoData clickBlock:^(NSInteger index) {
            @strongify(self);
            [self getData];
            [self.tableView reloadData];
        }];
        
        
        self.dataArray = [NSArray array];
        [self.tableView reloadData];
    }
}

- (void)getData{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 30;  i++) {
        [arr addObject:@"text"];
    }
    self.dataArray = [NSArray arrayWithArray:arr];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"数据-- %ld",indexPath.row];
    return cell;
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
    }
    return _tableView;
}

@end
