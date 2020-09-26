//
//  JJPlayerView.m
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/9/21.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "JJPlayer.h"


///播放器的播放状态
typedef NS_ENUM(NSUInteger,JJPlayerState){
    JJPlayerStateUnknown = 0, // 未知
    JJPlayerStatePause,       //暂停播放
    JJPlayerStatePlaying,     //播放中
    JJPlayerStateBuffering,   //缓冲中
    JJPlayerStateFailed,      //暂停失败
};

typedef NS_ENUM(NSUInteger, JJPanDirection) {
    JJPanDirectionHorizontalMoved,  /// 横向移动
    JJPanDirectionVerticalMoved,    /// 纵向移动
};

@implementation JJPlayerConfigure

+ (instancetype)defaultConfigure{
    JJPlayerConfigure *configure = [[JJPlayerConfigure alloc] init];
    
    configure.backPlay        = YES;
    configure.repeatPlay      = NO;
    configure.isLandscape     = NO;
    configure.autoRotate      = YES;
    configure.mute            = NO;
    configure.smallGestureControl  = NO;
    configure.fullGestureControl   = YES;
    configure.toolBarDisappearTime = 8;
    configure.videoFillMode        = VideoFillModeResize;
    configure.topToolBarHiddenType = TopToolBarHiddenNever;
    configure.fullGestureControl   = YES;

    configure.progressBackgroundColor = [UIColor colorWithRed:0.54118 green:0.51373 blue:0.50980 alpha:1.00000];
    configure.progressPlayFinishColor = [UIColor greenColor];
    configure.progressBufferColor     = [UIColor colorWithRed:0.84118 green:0.81373 blue:0.80980 alpha:1.00000];
    configure.strokeColor             = [UIColor whiteColor];
    
    return configure;
}


@end


@interface JJPlayerView ()<JJPlayerMaskViewDelegate,UIGestureRecognizerDelegate>


/// 播放器
@property (nonatomic, strong)   AVPlayer         *player;
/// 播放器item
@property (nonatomic, strong)   AVPlayerItem     *playerItem;
/// 播放器layer
@property (nonatomic, strong)   AVPlayerLayer    *playerLayer;
/// 控件的原始frame
@property (nonatomic, assign)   CGRect           customFrame;
/// 父类控件
@property (nonatomic, strong)   UIView           *fatherView;
/// 视图拉伸模式
@property (nonatomic, copy)     NSString         *fillMode;
/// 是否处于全屏状态
@property (nonatomic, assign)   BOOL             isFullScreen;
/// 工具条是否隐藏
@property (nonatomic, assign)   BOOL             isDisappear;
/// 用户播放标记
@property (nonatomic, assign)   BOOL           isUserPlay;
/// 点击最大化标记
@property (nonatomic, assign)   BOOL          isUserTapMaxButton;
/// 是否播放完毕
@property (nonatomic, assign)  BOOL              isFinish;
/// 用来保存快进的总时长
@property (nonatomic, assign)   CGFloat sumTime;
/// 播放器配置信息
@property (nonatomic, strong) JJPlayerConfigure *playerConfigure;
/// 视频播放控制面板(遮罩)
@property (nonatomic, strong) JJPlayerMaskView *playerMaskView;
/// 滑动方向
@property (nonatomic, assign)   JJPanDirection panDirection;
/// 是否在调节音量
@property (nonatomic, assign)   BOOL isVolume;
/// 是否在拖拽
@property (nonatomic, assign)   BOOL isDragged;
/// 缓冲
@property (nonatomic, assign)   BOOL isBuffering;
/// 音量滑杆
@property (nonatomic, strong) UISlider *volumeViewSlider;
/// 进度条定时器(最好不要用NSTimer)
@property (nonatomic, strong) NSTimer *sliderTimer;
/// 点击屏幕定时器
@property (nonatomic, strong) NSTimer *tapTimer;
/// 播放器的播放状态
@property (nonatomic, assign) JJPlayerState playerState;


/// 返回按钮回调
@property (nonatomic, copy) void(^BackBlock) (UIButton *backButton);
/// 播放完成回调
@property (nonatomic, copy) void(^EndBlock) (void);

@end

@implementation JJPlayerView

- (instancetype)initWithFrame:(CGRect)frame configuration:(JJPlayerConfigure *)configure{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark -
#pragma mark - 初始化界面
- (void)setupUI
{
    //默认初始值
    _isFullScreen = NO;
    _isDisappear = NO;
    _isUserTapMaxButton = NO;
    _isFinish = NO;
    _isUserPlay = YES;
    
    //开启
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    /// 监听横竖屏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    /// 进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationWillResignActiveNotification object:nil];
    /// 进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayground:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    // 添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    // 添加打断播放的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interruptionComing:) name:AVAudioSessionInterruptionNotification object:nil];
    // 添加插拔耳机的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChanged:) name:AVAudioSessionRouteChangeNotification object:nil];
    // 添加观察者监控播放器状态
    [self addObserver:self forKeyPath:@"playStatus" options:NSKeyValueObservingOptionNew context:nil];
       // 添加观察者监控进度
//       __weak typeof(self) weakSelf = self;
//       _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//           __strong typeof(self) strongSelf = weakSelf;
//
//           if (strongSelf.currentPlayTimeCallBack) {
//               float currentPlayTime = (double)strongSelf.currentItem.currentTime.value / strongSelf.currentItem.currentTime.timescale;
//               strongSelf.currentPlayTimeCallBack(strongSelf.player, currentPlayTime);
//           }
//       }];
    
    // 创建播放器
    self.backgroundColor = [UIColor blackColor];
    // 获取系统音量
    [self configureVolume];
    // 遮罩
    [self addSubview:self.maskView];
    
}

#pragma mark - public

#pragma mark - 更新配置
- (void)updatePlayerModifyConfigure:(void (^)(JJPlayerConfigure * _Nonnull))playerConfigureBlock{
    if (playerConfigureBlock) {
        playerConfigureBlock(self.playerConfigure);
    }
    
    switch (self.playerConfigure.videoFillMode) {
        case VideoFillModeResize:
            //拉伸视频内容达到边框占满,不按原来比例展示
            _fillMode = AVLayerVideoGravityResize;
            break;
        case VideoFillModeResizeAspect:
            //按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑
            _fillMode = AVLayerVideoGravityResizeAspect;
            break;
        case VideoFillModeResizeAspectFill:
            //按原比例拉伸视频，直到两边屏幕都占满，但视频内容有部分会被剪切
            _fillMode = AVLayerVideoGravityResizeAspectFill;
            break;
    }
    
    self.playerMaskView.progressBackGroundColor = self.playerConfigure.progressBackgroundColor;
    self.playerMaskView.progressBufferColor = self.playerConfigure.progressBufferColor;
    
    
    
    
}







#pragma mark - 获取系统音量
- (void)configureVolume{
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    _volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeViewSlider = (UISlider *)view;
            break;
        }
    }
}






/// 重置配置
- (void)reloadPlayer{
    
}

/// 播放
- (void)play{
    
}

/// 暂停
- (void)pause{
    
}





#pragma mark - 通知

// 播放完成通知
- (void)playbackFinished:(NSNotification *)notification
{
    AVPlayerItem *playerItem = (AVPlayerItem *)notification.object;
    
}

// 插拔耳机通知
- (void)routeChanged:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    int changeReason = [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    // 旧输出不可用
    if (changeReason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription = dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription = [routeDescription.outputs firstObject];
        // 原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            [self pause];
        }
    }
}

// 来电、闹铃打断播放通知
- (void)interruptionComing:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    AVAudioSessionInterruptionType type = [userInfo[AVAudioSessionInterruptionTypeKey] intValue];
    if (type == AVAudioSessionInterruptionTypeBegan) {
        [self pause];
    }
}

/** 屏幕翻转监听事件 */
- (void)orientationChanged:(NSNotification *)notification {
    
    }

/** 应用进入后台 */
- (void)appDidEnterBackground:(NSNotification *)notify {
     
}

/** 应用进入前台 */
- (void)appDidEnterPlayground:(NSNotification *)notify {
    
}



@end
