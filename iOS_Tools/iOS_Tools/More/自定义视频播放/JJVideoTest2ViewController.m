//
//  JJVideoTest2ViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/27.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJVideoTest2ViewController.h"
#import "JJVideoTableViewCell.h"
#import "JJPlayer.h"

@interface JJVideoTest2ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) JJTableView *tableView;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation JJVideoTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"视频在Cell上播放";
    
    [self setupUI];
}


#pragma mark - 初始化界面
- (void)setupUI
{
    
    // 1. 获取plist文件的地址
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"JJVideoData" ofType:@"plist"];
    //  2. 加载Plist字典集合
    NSArray *arrPlist = [NSArray arrayWithContentsOfFile:filePath];
    //  3. 遍历字典集合，创建模型对象，添加到一个可变数组中
    NSArray *userArray = [JJVideoModel mj_objectArrayWithKeyValuesArray:arrPlist];
    self.datas = [NSArray arrayWithArray:userArray];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(kNavBarHeight);
        make.bottom.equalTo(self.view).mas_offset(-kBottomSafeHeight);
    }];
   
    //设置自动计算行号模式
      self.tableView.rowHeight = UITableViewAutomaticDimension;
      //设置预估行高
      self.tableView.estimatedRowHeight = 200;
    
}





#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JJVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJVideoTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.datas.count > indexPath.row) {
        JJVideoModel *model = self.datas[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

   
}


#pragma mark - getter and setter

- (JJTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[JJTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_tableView registerClass:[JJVideoTableViewCell class] forCellReuseIdentifier:@"JJVideoTableViewCell"];
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
