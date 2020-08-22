//
//  NSString+Extra.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/8/23.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "NSString+Extra.h"

@implementation NSString (Extra)


+ (BOOL)isNull:(NSString *)string{
    if (string == nil ||
        string == NULL ||
        [string isKindOfClass:[NSNull class]] ||
        [string isKindOfClass:[NSNull class]] ||
        [string isEqualToString:@""] ||
        [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
        return YES;
    }
    return NO;
}
@end
