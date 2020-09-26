//
//  JJPlayerView.m
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/9/21.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "JJPlayerMaskView.h"



///播放器的播放状态
typedef NS_ENUM(NSUInteger,JJPlayerState){
    JJPlayerStateUnknown = 0, // 未知
    JJPlayerStatePause,       //暂停播放
    JJPlayerStatePlaying,     //播放中
    JJPlayerStateBuffering,   //缓冲中
    JJPlayerStateFailed,      //暂停失败
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


@interface JJPlayerView ()


/// 播放器
@property (nonatomic, strong) AVPlayer *player;
/// 播放器item
@property (nonatomic, strong) AVPlayerItem *playerItem;
/// 播放器layer
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/// 是否播放完毕
@property (nonatomic, assign) BOOL isFinish;
/// 是否处于全屏状态
@property (nonatomic, assign) BOOL isFullScreen;
/// 播放器配置信息
@property (nonatomic, strong) JJPlayerConfigure *playerConfigure;
/// 视频播放控制面板(遮罩)
@property (nonatomic, strong) JJPlayerMaskView *playerMaskView;
/// 非全屏状态下播放器 superview
@property (nonatomic, strong) UIView *originalSuperview;
/// 非全屏状态下播放器 frame
@property (nonatomic, assign) CGRect originalRect;
/// 时间监听器
@property (nonatomic, strong) id timeObserve;
/// 播放器的播放状态
@property (nonatomic, assign) JJPlayerState playerState;
/// 是否结束播放
@property (nonatomic, assign) BOOL playDidEnd;



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
