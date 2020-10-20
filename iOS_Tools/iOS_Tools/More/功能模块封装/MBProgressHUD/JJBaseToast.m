//
//  JJBaseToast.m
//  MBProgress
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JJBaseToast.h"


@implementation JJBaseToast

+ (MBProgressHUD *)show:(NSString *)text
                   view:(UIView *)view
           isAutoHidden:(BOOL)autoHidden
     withBezelViewColor:(UIColor *)bezelViewColor{
    
    if (view == nil){
        view = [[UIApplication sharedApplication].delegate window];
    }
    
    [MBProgressHUD hideHUDForView:view animated:YES];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 间距调整
    hud.margin = 15;
    
    // 文字
    hud.label.text = text;
    hud.label.font = kFont(14);
    // 支持多行
    hud.label.numberOfLines = 0;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //设置默认风格
    if (bezelViewColor == nil) {
        
        hud.contentColor = [UIColor whiteColor];
        hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    }else{
        hud.contentColor = [UIColor whiteColor];
        hud.bezelView.backgroundColor = bezelViewColor;
        hud.bezelView.color = bezelViewColor;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    }
    hud.bezelView.layer.masksToBounds = YES;
    hud.bezelView.layer.cornerRadius = 10;
    if (autoHidden) {
        // x秒之后消失
        [hud hideAnimated:YES afterDelay:kHudShowTime];
    }
    return hud;
}


// 计算字符串Size
+ (CGSize)sizeWithString:(NSString*)string font:(UIFont*)font maxSize:(CGSize)maxSize
{
    if(string && [string isKindOfClass:[NSString class]] && string.length)
    {
        CGSize size = [string boundingRectWithSize: maxSize
                                           options: NSStringDrawingUsesLineFragmentOrigin
                                        attributes: @{ NSFontAttributeName: font }
                                           context: nil].size;
        return  size;
    }
    return CGSizeMake(0, 0);
}



 




@end
