//
//  JJTestImage.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/10/12.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJTestImage : UIImage

+ (UIImage *)drawText:(NSString *)text forImage:(UIImage *)image;
+ (UIImage *)drawText1:(NSString *)text1 text2:(NSString *)text2 forImage:(UIImage *)image;

- (UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize;


@end

NS_ASSUME_NONNULL_END
