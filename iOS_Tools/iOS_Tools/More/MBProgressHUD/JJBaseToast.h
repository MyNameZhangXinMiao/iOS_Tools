//
//  JJBaseToast.h
//  MBProgress
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MBProgressHUD.h"

#define kHudShowTime                1.5   ///< 显示时间


///文字显示位置
typedef NS_ENUM(NSUInteger, JJMBHUDPostion) {
    JJMBHUDPostionCenter = 0, ///< 中间
    JJMBHUDPostionTop,     ///<上面
    JJMBHUDPostionBottom,  ///<下面
};


@interface JJBaseToast : MBProgressHUD

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 展示HUD基础方法

 @param text 文字
 @param view 目标视图
 @param autoHidden 是否自动隐藏
 @param bezelViewColor 背景色
 @return MBHUD
 */
+ (MBProgressHUD *)show:(NSString *)text
                   view:(UIView *)view
           isAutoHidden:(BOOL)autoHidden
     withBezelViewColor:(UIColor *)bezelViewColor;




+ (CGSize)sizeWithString:(NSString*)string font:(UIFont*)font maxSize:(CGSize)maxSize;


@end
