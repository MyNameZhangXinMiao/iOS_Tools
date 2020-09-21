//
//  JJPlayerConfiguration.m
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/9/21.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJPlayerConfiguration.h"


/** 视频拉伸方式 */
typedef NS_ENUM(NSUInteger, LYVideoGravity) {
    LYVideoGravityResize,           // 非均匀拉伸。两个维度完全填充至整个视图区域
    LYVideoGravityResizeAspect,     // 等比例拉伸，直到一个维度到达区域边界
    LYVideoGravityResizeAspectFill, // 等比例拉伸，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
};

/** 全屏状态下状态栏显示方式 */
typedef NS_ENUM(NSInteger, LYStatusBarHideState) {
    LYStatusBarHideStateFollowControls = 0, // 跟随控制面板显示
    LYStatusBarHideStateNever,              // 从不显示
    LYStatusBarHideStateAlways,             // 一直显示
};


@implementation JJPlayerConfiguration

@end
