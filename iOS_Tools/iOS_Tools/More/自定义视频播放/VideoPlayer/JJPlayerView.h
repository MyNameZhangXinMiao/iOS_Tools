//
//  JJPlayerView.h
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/9/21.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JJPlayerControls;
@interface JJPlayerView : UIView

- (instancetype)initWithFrame:(CGRect)frame configuration:(JJPlayerControls *)configuration;


@property (nonatomic, strong) JJPlayerControls *playerControls;


/// 重置配置
- (void)reloadPlayer;

/// 播放
- (void)play;

/// 暂停
- (void)pause;



@end

NS_ASSUME_NONNULL_END
