//
//  NSString+Extra.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/8/23.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extra)


/// 判断字符串是否为空
/// @param string 需要进行判断的字符串
+ (BOOL)isNull:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
