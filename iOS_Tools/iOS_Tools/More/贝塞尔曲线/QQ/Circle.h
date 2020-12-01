//
//  Circle.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/12/1.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Circle : NSObject

@property (nonatomic) float radius;
@property (nonatomic) CGPoint centerPoint;

@property (nonatomic) UIColor *color;

//记录一下原始的圆的大小
@property (nonatomic) float orignRadius;

+ (instancetype)initWithcenterPoint:(CGPoint)center radius:(float)radius;
+ (instancetype)initWithcenterPoint:(CGPoint)center radius:(float)radius color:(UIColor *)color;



@end

NS_ASSUME_NONNULL_END
