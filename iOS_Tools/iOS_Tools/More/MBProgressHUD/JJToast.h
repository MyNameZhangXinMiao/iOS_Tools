//
//  JJToast.h
//  MBProgress
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

/*
 以下方法创建的MBHUD均显示在指定view上
 */


#import "JJBaseToast.h"

typedef void (^ToastDismissCompletion)(void);

@interface JJToast : JJBaseToast


/**
 只显示文字MBHUD(自动消失)

 @param message 文字  如果文字为空 不显示
 @param view 目标视图
 */
+ (void)showMessage:(NSString *_Nonnull)message toView:(UIView *_Nonnull)view;

/**
 只显示文字MBHUD ,项目自定义导航条可以相应
 其他view需要额外设置,否则不响应
 */
+ (void)showMessageEnableNavigation:(NSString *_Nonnull)message toView:(UIView *_Nonnull)view;


/**
 只显示文字MBHUD(自动消失)

 @param message 文字  如果文字为空 不显示
 @param view 目标视图
 @param completion 回调
 */
+ (void)showMessage:(NSString *_Nonnull)message toView:(UIView *_Nonnull)view completion:(ToastDismissCompletion _Nullable)completion;



/**
 加载,无背景色
 
 @param view 目标视图
 */
+ (void)showLoadingToView:(UIView *_Nonnull)view;


/// 加载,无背景色,可返回
/// @param view 目标视图
+ (void)showLoadingEnableToView:(UIView *_Nonnull)view;


/**
 加载,有背景色
 
 @param view 目标视图
 */
+ (void)showLoadingHasBGColorToView:(UIView *_Nonnull)view;


/// 文字 + 加载图
+ (void)showLoadingWithTitle:(NSString *_Nonnull)title toView:(UIView *)view;


/**
 隐藏指定view上的MBHUD
 */
+ (void)hideHUDForView:(UIView *_Nullable)view;

@end
