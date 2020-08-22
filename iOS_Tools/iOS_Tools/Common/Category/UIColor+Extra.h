//
//  UIColor+Extra.h
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/18.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extra)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;





@end

NS_ASSUME_NONNULL_END
