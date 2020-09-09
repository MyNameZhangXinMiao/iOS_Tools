//
//  JJToast.m
//  MBProgress
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JJToast.h"
#import "JJCustomView.h"


@implementation JJToast


///  只显示文字HUD(自动消失)
+ (void)showMessage:(NSString *_Nonnull)message toView:(UIView *)view{
    
    if ([NSString isNil:message]){
        return;
    }
    
    NSRange range;
    
    NSMutableString *mutStr = [NSMutableString string];
    NSMutableString *subStr = [NSMutableString string];
    
    for(int i = 0; i<message.length; i += range.length){
        
        range = [message rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *charStr = [message substringWithRange:range];
        
        [subStr appendString:charStr];
        
        CGFloat width = [self sizeWithString:subStr font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(300, 68)].width;
        if (width < 215) {
            [mutStr appendString:charStr];
        }else{
            [mutStr appendString:@"\n"];
            [mutStr appendString:charStr];
            subStr = [NSMutableString string];
            [subStr appendString:charStr];
        }
    }
    
    NSString *text = mutStr.copy;
    MBProgressHUD *hud = [self show:text view:view isAutoHidden:YES withBezelViewColor:[UIColor colorWithWhite:0 alpha:0.8]];
    hud.mode = MBProgressHUDModeText;
    
}

/// 文字HUD,可以返回
+ (void)showMessageEnableNavigation:(NSString *_Nonnull)message toView:(UIView *_Nonnull)view{
    
    if ([NSString isNil:message]){
        return;
    }
    
    NSRange range;
    
    NSMutableString *mutStr = [NSMutableString string];
    NSMutableString *subStr = [NSMutableString string];
    
    for(int i = 0; i<message.length; i += range.length){
        
        range = [message rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *charStr = [message substringWithRange:range];
        
        [subStr appendString:charStr];
        
        CGFloat width = [self sizeWithString:subStr font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(300, 68)].width;
        if (width < 215) {
            [mutStr appendString:charStr];
        }else{
            [mutStr appendString:@"\n"];
            [mutStr appendString:charStr];
            subStr = [NSMutableString string];
            [subStr appendString:charStr];
        }
    }
    
    NSString *text = mutStr.copy;
    MBProgressHUD *hud = [self show:text view:view isAutoHidden:YES withBezelViewColor:[UIColor colorWithWhite:0 alpha:0.8]];
    hud.mode = MBProgressHUDModeText;
    
}


/// 成功提示(自动消失，带默认成功图)
+ (void)showSuccess:(NSString *_Nonnull)success toView:(UIView *)view{
    
    MBProgressHUD *hud = [self show:success view:view isAutoHidden:YES withBezelViewColor:nil];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(90, 90);
    hud.customView = [[JJCustomView alloc] initWithImage:[UIImage imageNamed:@"success"]];
}

+ (void)showMessage:(NSString *_Nonnull)message toView:(UIView *_Nonnull)view completion:(ToastDismissCompletion _Nullable)completion{
    [self showMessage:message toView:view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kHudShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}


/// 错误提示(自动消失，带默认成功图)
+ (void)showError:(NSString *_Nonnull)error toView:(UIView *)view{
    
    MBProgressHUD *hud = [self show:error view:view isAutoHidden:YES withBezelViewColor:nil];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(90, 90);
    hud.customView = [[JJCustomView alloc] initWithImage:[UIImage imageNamed:@"error"]];
}

/// 自定义图片+文字
+ (void)showImage:(nonnull UIImage *)image
            title:(NSString *_Nonnull)title
           toView:(UIView *)view{
    
    MBProgressHUD *hud = [self show:title view:view isAutoHidden:YES withBezelViewColor:nil];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(90, 90);
    JJCustomView *imgView = [[JJCustomView alloc] initWithImage:image];
    hud.customView = imgView;
    
}

//动画
+ (void)showAnimationWithImageNames:(NSArray<NSString *> *_Nonnull)imageNames
                              title:(NSString *_Nonnull)title
                             toView:(UIView *_Nonnull)view{
    MBProgressHUD *hud = [self show:title view:view isAutoHidden:YES withBezelViewColor:nil];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(90, 90);
    JJCustomView *imagesView = [[JJCustomView alloc] init];
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    
    for (NSString *imageName in imageNames) {
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    imagesView.animationDuration = 0.3;
    
    imagesView.animationImages = imageArray;
    // 开始播放
    [imagesView startAnimating];
    hud.customView = imagesView;
}


///< 自定义透明加载图
+ (void)showLoadingToView:(UIView *)view{
    
    MBProgressHUD *hud = [self show:nil view:view isAutoHidden:NO withBezelViewColor:[UIColor clearColor]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(90, 90);
    JJCustomView *imagesView = [[JJCustomView alloc] init];
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 31; i < 79; i++) {
        NSString *imageName= [NSString stringWithFormat:@"JJ_app_loading_released_%03d",i];
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    imagesView.animationDuration = 0.75;
    
    imagesView.animationImages = imageArray;
    // 开始播放
    [imagesView startAnimating];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.customView = imagesView;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
}

/// 加载,无背景色,可返回
+ (void)showLoadingEnableToView:(UIView *_Nonnull)view{
    
    MBProgressHUD *hud = [self show:nil view:view isAutoHidden:NO withBezelViewColor:[UIColor clearColor]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(90, 90);
    JJCustomView *imagesView = [[JJCustomView alloc] init];
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 31; i < 79; i++) {
        NSString *imageName= [NSString stringWithFormat:@"JJ_app_loading_released_%03d",i];
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    imagesView.animationDuration = 0.75;
    
    imagesView.animationImages = imageArray;
    // 开始播放
    [imagesView startAnimating];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.customView = imagesView;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
}


///< 自定义带背景加载图
+ (void)showLoadingHasBGColorToView:(UIView *_Nonnull)view{
    
    MBProgressHUD *hud = [self show:nil view:view isAutoHidden:NO withBezelViewColor:nil];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(90, 90);
    JJCustomView *imagesView = [[JJCustomView alloc] init];
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 31; i < 79; i++) {
        NSString *imageName= [NSString stringWithFormat:@"JJ_app_loading_released_white_%03d",i];
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    imagesView.animationDuration = 0.75;
    
    imagesView.animationImages = imageArray;
    // 开始播放
    [imagesView startAnimating];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.customView = imagesView;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    
}


/// 文字 + 加载图
+ (void)showLoadingWithTitle:(NSString *_Nonnull)title toView:(UIView *)view{
    
    MBProgressHUD *hud = [self show:title view:view isAutoHidden:NO withBezelViewColor:nil];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.minSize = CGSizeMake(90, 90);
    
}

///< 隐藏HUD
+ (void)hideHUDForView:(UIView *)view {
    if (view == nil){
        view = [[UIApplication sharedApplication].delegate window];
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}


@end
