//
//  JJToast+Window.h
//  MBProgress
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

/*
 以下方法创建的MBHUD均显示在window上
 */

#import "JJToast.h"

@interface JJToast (Window)


/**
 Window上显示文字MBHUD(自动消失)
 
 @param message 文字 如果文字为空 不显示
 */
+ (void)showMessage:(NSString *_Nonnull)message;


/**
 Window上显示文字MBHUD(自动消失),可以交互
 
 @param message 文字 如果文字为空 不显示
 */
+ (void)showMessageInteraction:(NSString *_Nonnull)message;



/**
 Window上显示文字MBHUD(自动消失)

 @param message 文字 如果文字为空 不显示
 @param completion 回调
 */
+ (void)showMessage:(NSString *_Nonnull)message completion:(ToastDismissCompletion _Nullable)completion;

/**
 window上显示 Loading + Text

 @param title title
 */
+ (void)showLoadingWithTitle:(NSString *_Nonnull)title;

/**
 加载,无背景色
 */
+ (void)showLoading;
/**
 加载,有背景色
 */
+ (void)showLoadingHasBGColor;
/**
 隐藏（从window）
 */
+ (void)hideHUD;


@end
