//
//  Circle.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/12/1.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "Circle.h"

@implementation Circle


+ (instancetype)initWithcenterPoint:(CGPoint)center radius:(float)radius {
    Circle *circle = [[Circle alloc] init];
    
    circle.radius = radius;
    circle.orignRadius = radius;
    circle.centerPoint = center;
    
    circle.color = [UIColor blackColor];
    
    return circle;
}
+ (instancetype)initWithcenterPoint:(CGPoint)center radius:(float)radius color:(UIColor *)color {
    Circle *circle = [Circle initWithcenterPoint:center radius:radius];
    
    circle.color = color;
    
    return circle;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"point:(%f, %f) radius:%f  color:%@", self.centerPoint.x, self.centerPoint.y, self.radius, self.color];
}

@end
