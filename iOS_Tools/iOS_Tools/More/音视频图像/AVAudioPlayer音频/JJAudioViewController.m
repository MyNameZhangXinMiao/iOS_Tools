//
//  JJAudioViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJAudioViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>


@interface JJAudioViewController ()


@property (nonatomic, strong) AVAudioPlayer *mp3Player;

@end

@implementation JJAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"AVAudioPlayer音频";
    
    [self setupUI];
    //后台播放音乐，设置音频的会话类型。必须真机演示
//    AVAudioSession *ausioSession = [AVAudioSession sharedInstance];
//    [ausioSession setCategory:AVAudioSessionCategoryPlayback error:NULL];
    
    
    /*
     //准备播放 可以判断player创建成功之后调用，调用[player play]则可以节省播放之前的间隔时间。
    - (BOOL)prepareToPlay;
    //异步播放
    - (BOOL)play;
    //在某个时间点播放
    - (BOOL)playAtTime:(NSTimeInterval)time NS_AVAILABLE(10_7, 4_0);
    //暂停播放，但仍然可以播放
    - (void)pause;
    //停止播放，不再准备播放了
    - (void)stop;
    //更新音频测量值，注意如果要更新音频测量值必须设置meteringEnabled为YES，通过音频测量值可以即时获得音频分贝等信息
    - (void)updateMeters;
    //返回给定通道的分贝峰值功率
    - (float)peakPowerForChannel:(NSUInteger)channelNumber;
    //获得指定声道的分贝峰值，注意如果要获得分贝峰值必须在此之前调用updateMeters方法
    - (float)averagePowerForChannel:(NSUInteger)channelNumber;
     
     
     playing //播放器是否正在播放 获取通过isPlaying
     numberOfChannels //该音频的声道次数，只读
     duration //该音频播放时长
     url //音频文件路径, 只读
     data //音频数据，只读
     pan NS_AVAILABLE(10_7, 4_0) //立体声设置 设为 －1.0 则左边播放 设为 0.0 则中央播放 设为 1.0 则右边播放
     enableRate NS_AVAILABLE(10_8, 5_0);  //是否允许改变播放速率
     rate NS_AVAILABLE(10_8, 5_0); //播放速率 0.5 (半速播放) ～ 2.0(倍速播放) 注1.0 是正常速度
     currentTime //该音频的播放点
     deviceCurrentTime //输出设备播放音频的时间，注意如果播放中被暂停此时间也会继续累加
     numberOfLoops  //循环次数，如果要单曲循环，设置为负数
     volume //播放器的音频增益，值：0.0～1.0
     channelAssignments //获得或设置播放声道
     
     
     //音频播放完成
     - (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
     //音频解码发生错误
     - (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
     //如果音频被中断，比如有电话呼入，该方法就会被回调，该方法可以保存当前播放信息，以便恢复继续播放的进度
     - (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
     
     
     */
    
}

- (void)backButtonAction{
    
    
}


#pragma mark - 初始化界面
- (void)setupUI{
    NSError *playerError;
    _mp3Player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Users/Charles/Downloads/阴天.mp3"] error:&playerError];
    
    NSLog(@"-----%f",_mp3Player.duration) ;
    
    if (_mp3Player == nil){
        NSLog(@"ERror creating player: %@", [playerError description]);
    }else{
        [_mp3Player play];
    }
    
}

@end
