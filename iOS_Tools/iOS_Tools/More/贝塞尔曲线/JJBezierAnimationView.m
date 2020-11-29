//
//  JJBezierAnimationView.m
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/11/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJBezierAnimationView.h"

@interface JJBezierAnimationView()


@end

@implementation JJBezierAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
         
    }
    return self;
}

- (void)setItemValues:(NSArray *)items{
    
    UIBezierPath *pAxisPath = [UIBezierPath bezierPath];
    CGFloat margin = 50;
    CGFloat w = 30;
    CGFloat h = 20;
    for (int i = 0; i < items.count; i ++) {
        NSString *str = items[i];
        CGFloat value = [str floatValue];
        CGPoint point = CGPointMake(margin + i * w, h * value+100);
        if (i == 0) {
            [pAxisPath moveToPoint:point];
        } else {
            [pAxisPath addLineToPoint:point];
        }
    }
    
    CAShapeLayer *pAxisLayer = [CAShapeLayer layer];
    pAxisLayer.lineWidth = 3;
    pAxisLayer.strokeColor = [UIColor redColor].CGColor;
    pAxisLayer.fillColor = [UIColor clearColor].CGColor;
    pAxisLayer.path = pAxisPath.CGPath;
    [self.layer addSublayer:pAxisLayer];
    
    CABasicAnimation *anmi = [CABasicAnimation animation];
    anmi.keyPath = @"strokeEnd";
    anmi.fromValue = [NSNumber numberWithFloat:0];
    anmi.toValue = [NSNumber numberWithFloat:1.0f];
    anmi.duration = 5;
    anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi.autoreverses = NO;
    [pAxisLayer addAnimation:anmi forKey:@"stroke"];
    
        
}



@end
