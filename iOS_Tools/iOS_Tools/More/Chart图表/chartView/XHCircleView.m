//
//  XHCircleView.m
//  XHChartView
//
//  Created by zhouxuanhe on 2019/6/17.
//  Copyright © 2019 xuanhe. All rights reserved.
//

#import "XHCircleView.h"

@implementation XHCircleView

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius {
    
    self = [super init];
    
    if (self) {
        self.frame = CGRectMake(center.x - radius, center.y - radius, radius * 2.0, radius * 2.0);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}



@end
