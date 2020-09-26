//
//  UIImage+JJPlayer.m
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/9/26.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "UIImage+JJPlayer.h"

@implementation UIImage (JJPlayer)

+ (UIImage *)imageWithName:(NSString *)name{
    int scale = (int)UIScreen.mainScreen.scale;
    scale = MIN(MAX(scale, 2), 3);
    NSString *imageName = [NSString stringWithFormat:@"%@@%dx", name, scale];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"JJPlayer" ofType:@"bundle"]];
    NSString *path   = [bundle pathForResource:imageName ofType:@"png"];
    return [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
