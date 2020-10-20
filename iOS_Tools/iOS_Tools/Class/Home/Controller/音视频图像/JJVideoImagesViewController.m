//
//  JJVideoImagesViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/10/20.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJVideoImagesViewController.h"
#import "JJVideoViewController.h"
#import "JJAudioViewController.h"
#import "JJQueueViewController.h"
#import "JJScreenRotationViewController.h"




@interface JJVideoImagesViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) JJTableView *tableView;

@property (nonatomic, strong) NSArray *data;


@end

@implementation JJVideoImagesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"音视频图像";
    
    
    [self setupUI];
}


#pragma mark -
#pragma mark - 初始化界面
- (void)setupUI
{
    self.data = @[@"视频播放",@"AVAudioPlayer音频",@"AVQueuePlayer播放",@"屏幕旋转"];
    
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

    NSString *text = self.data[indexPath.row];
    if ([text isEqualToString:@"视频播放"]){
        JJVideoViewController *vc = [[JJVideoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"AVAudioPlayer音频"]){
        JJAudioViewController *vc = [[JJAudioViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"AVQueuePlayer播放"]){
        JJQueueViewController *vc = [[JJQueueViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"屏幕旋转"]){
        JJScreenRotationViewController *vc = [[JJScreenRotationViewController alloc] init];
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
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

@end
