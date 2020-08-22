//
//  JJVideoPlayerView.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJVideoPlayerView.h"

@interface JJVideoPlayerView ()<TXVodPlayListener>

@property (nonatomic, strong) UIView *controlView;


@end
@implementation JJVideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.controlView = [[UIView alloc] initWithFrame:frame];

        [self setupUI];
    }
    return self;
}

#pragma mark - 初始化界面
- (void)setupUI{

    
    self.player.config = [self playerConfig];
    [self.player setupVideoWidget:self insertIndex:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
//    tap.delegate = self;
    [self.controlView addGestureRecognizer:tap];
    
    [self addSubview:self.controlView];
    
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.player.isPlaying) {
        [self.player pause];
    }else{
        [self.player resume];

    }
}

- (TXVodPlayConfig *)playerConfig
{
    TXVodPlayConfig *config = [[TXVodPlayConfig alloc] init];
    config.connectRetryCount = 5;
    config.connectRetryInterval = 3;
    config.timeout = 10;
//    config.cacheFolderPath = [self canchPath];
    config.maxCacheItems = 10;
    config.autoRotate = YES;
    config.playerType = PLAYER_FFPLAY;
    config.progressInterval = 0.2;
    return config;
}


- (int)playerURLStr:(NSString *)urlStr
{
    return [self.player startPlay:urlStr];
}

- (BOOL)isPlaying
{
    return self.player.isPlaying;
}

- (int)stop
{
    if (_player) {
        return [_player stopPlay];
    }
    return 0;
}


- (void)resume
{
    if (!self.isPlaying) {
        [self.player resume];
    }
}

- (void)setMute:(BOOL)mute
{
    if (_player) {
        [_player setMute:mute];
    }
}
- (void)destroy
{
    [_player stopPlay];
    [_player removeVideoWidget];
}
/**
 * 点播事件通知
 *
 * @param player 点播对象
 * @param EvtID 参见TXLiveSDKTypeDef.h
 * @param param 参见TXLiveSDKTypeDef.h
 * @see TXVodPlayer
 */
- (void) onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary*)param{
    
}

/**
 * 网络状态通知
 *
 * @param player 点播对象
 * @param param 参见TXLiveSDKTypeDef.h
 * @see TXVodPlayer
 */
- (void) onNetStatus:(TXVodPlayer *)player withParam:(NSDictionary*)param{
    
}

- (TXVodPlayer *)player{
    if (_player == nil) {
        _player = [[TXVodPlayer alloc] init];
        _player.isAutoPlay = YES;
        _player.enableHWAcceleration = YES;
        _player.loop = YES;
        _player.vodDelegate = self;
        [_player setRenderMode:RENDER_MODE_FILL_EDGE];
    }
    return _player;
}

@end
