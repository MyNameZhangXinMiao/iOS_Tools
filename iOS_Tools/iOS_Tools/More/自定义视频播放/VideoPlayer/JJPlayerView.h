//
//  JJPlayerView.h
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/9/21.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,VideoFillMode){
    VideoFillModeResize = 0,       ///<拉伸占满整个播放器，不按原比例拉伸
    VideoFillModeResizeAspect,     ///<按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑
    VideoFillModeResizeAspectFill, ///<按照原比例拉伸占满整个播放器，但视频内容超出部分会被剪切
};
typedef NS_ENUM(NSUInteger, TopToolBarHiddenType) {
    TopToolBarHiddenNever = 0, ///<小屏和全屏都不隐藏
    TopToolBarHiddenAlways,    ///<小屏和全屏都隐藏
    TopToolBarHiddenSmall,     ///<小屏隐藏，全屏不隐藏
};


typedef void(^BackButtonBlock)(UIButton *button);
typedef void(^EndBolck)(void);

@interface JJPlayerConfigure : NSObject

/// 后台返回是否自动播放,默认Yes,会跟随用户,如果是播放状态进入后台，返回会继续播放
@property (nonatomic, assign)   BOOL backPlay;
/// 是否自动播放,默认NO
@property (nonatomic, assign)   BOOL repeatPlay;
/// 当前页面是否支持全屏,默认NO
@property (nonatomic, assign)   BOOL isLandscape;
/// 是否自动旋转,默认YES
@property (nonatomic, assign)   BOOL autoRotate;
/// 静音,默认NO
@property (nonatomic, assign)   BOOL mute;
/// 小屏幕手势控制,默认NO
@property (nonatomic, assign)   BOOL smallGestureControl;
/// 全屏幕手势控制,默认YES
@property (nonatomic, assign)   BOOL fullGestureControl;
/// 工具条消失时间,默认8s,必须大于0
@property (nonatomic, assign)   NSUInteger toolBarDisappearTime;
/// 视频填充方式,默认全屏填充
@property (nonatomic, assign)   VideoFillMode videoFillMode;
/// 顶部工具条隐藏方式,默认不隐藏
@property (nonatomic, assign)   TopToolBarHiddenType topToolBarHiddenType;

/// ----------   Color
/// 进度条背景颜色
@property (nonatomic, strong) UIColor *progressBackgroundColor;
/// 缓冲条背景颜色
@property (nonatomic, strong) UIColor *progressBufferColor;
/// 进度条播放完成颜色
@property (nonatomic, strong) UIColor *progressPlayFinishColor;
/// 动画转子背景颜色
@property (nonatomic, strong) UIColor *strokeColor;


/// 初始化方法
+ (instancetype)defaultConfigure;












@end

@interface JJPlayerView : UIView

- (instancetype)initWithFrame:(CGRect)frame configuration:(JJPlayerConfigure *)configure;


/// 是否是全屏
@property (nonatomic, assign, readonly) BOOL          isFullScreen;
/// 网络视频地址
@property (nonatomic, strong) NSURL                   *url;
/// 本地视频地址
@property (nonatomic, strong) NSString                *filePath;


/// 更新配置,只需要设置改变的配置即可
/// @param playerConfigureBlock 配置信息
- (void)updatePlayerModifyConfigure:(void(^)(JJPlayerConfigure *configure))playerConfigureBlock;

/// 更新配置,直接传值配置对象
/// @param configure 配置信息
- (void)updatePlayerAllConfigure:(JJPlayerConfigure *)configure;


/// 播放
- (void)play;
/// 暂停
- (void)pause;

/// 返回按钮回调方法,只有小屏会调用，全屏点击默认回到小屏
- (void)backButtonAction:(BackButtonBlock)backBlock;
/// 播放完成回调
- (void)endPlay:(EndBolck)end;
/// 销毁播放器
- (void)destoryPlayer;

@end

NS_ASSUME_NONNULL_END
