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

@interface JJVideoTest2ViewController ()<UITableViewDelegate,UITableViewDataSource,JJVideoTableViewCellDelegate>

@property (nonatomic, strong) JJTableView *tableView;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) JJPlayerView *playerView;

@property (nonatomic, strong) JJVideoTableViewCell *lastCell;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation JJVideoTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"视频在Cell上播放";
    
    [self setupUI];
    [self setupVideoPlayerView];
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

- (void)setupVideoPlayerView{
    
//    JJPlayerView *playerView = [[JJPlayerView alloc] initWithFrame:CGRectMake(0, 66, kScreenWidth, 300)];
//    _playerView = playerView;
//    _playerView.title = @"哎哟哎,搞笑节奏走起来!!!!";
    
//    [_playerView updatePlayerModifyConfigure:^(JJPlayerConfigure * _Nonnull configure) {
//        configure.backPlay = NO;
//        configure.strokeColor = [UIColor redColor];
//        configure.topToolBarHiddenType = TopToolBarHiddenNever;
//    }];
    
//    [self.view addSubview:_playerView];

    
    //视频地址
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"video1" ofType:@"mp4"];
//    NSString *urlString = @"https://dh2.v.netease.com/2017/cg/fxtpty.mp4";
    
//    NSString *urlString = @"http://120.24.184.1/cdm/media/k2/videos/1.mp4";
//    _playerView.url = [NSURL URLWithString:urlString];
//    _playerView.url = [NSURL fileURLWithPath:path];

//    [_playerView play];
}



#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JJVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJVideoTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if (self.datas.count > indexPath.row) {
        JJVideoModel *model = self.datas[indexPath.row];
        cell.model = model;
    }
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (self.indexPath == indexPath) {
//        return;
//    }
//    self.indexPath = indexPath;
//    JJVideoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//    if (self.datas.count > indexPath.row) {
//        [self.playerView destoryPlayer];
//        [self.playerView removeFromSuperview];
//        self.playerView = nil;
//
//        [cell addSubview:self.playerView];
//        JJVideoModel *model = self.datas[indexPath.row];
//        NSRange range = [model.videoName rangeOfString:@"."];
//        NSString *name = [model.videoName substringToIndex:range.location];
//        NSString *type = [model.videoName substringFromIndex:range.location+1];
//        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
//        _playerView.url = [NSURL fileURLWithPath:path];
//        _playerView.title = model.title;
//        [_playerView play];
//    }
//}

//cell离开tableView时调用
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.indexPath == indexPath || self.lastCell == cell) {
        //因为复用，同一个cell可能会走多次
        [self.playerView destoryPlayer];
        [self.playerView removeFromSuperview];
        self.playerView = nil;
        self.indexPath = nil;
    }
}

#pragma mark - JJVideoTableViewCellDelegate

- (void)jj_videoTableViewCellDidPlayButtonInCell:(JJVideoTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if (self.indexPath == indexPath) {
        return;
    }
    self.indexPath = indexPath;
    
    if (self.datas.count > indexPath.row) {
        [self.playerView destoryPlayer];
        [self.playerView removeFromSuperview];
        self.playerView = nil;
        
        [cell addSubview:self.playerView];
        JJVideoModel *model = self.datas[indexPath.row];
        NSRange range = [model.videoName rangeOfString:@"."];
        NSString *name = [model.videoName substringToIndex:range.location];
        NSString *type = [model.videoName substringFromIndex:range.location+1];
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
        _playerView.url = [NSURL fileURLWithPath:path];
        _playerView.title = model.title;
        [_playerView play];
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

- (JJPlayerView *)playerView{
    if (_playerView == nil) {
        _playerView = [[JJPlayerView alloc] initWithFrame:CGRectMake(0, 66, kScreenWidth, 300)];
        [_playerView updatePlayerModifyConfigure:^(JJPlayerConfigure * _Nonnull configure) {
            configure.backPlay = NO;
            configure.strokeColor = [UIColor redColor];
            configure.topToolBarHiddenType = TopToolBarHiddenNever;
            configure.repeatPlay = YES;
        }];
    }
    return _playerView;
}

@end
