//
//  JJBezierView.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/11/25.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJBezierView.h"


@implementation JJBezierView
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(200, 80)];
    [path addLineToPoint:CGPointMake(150, 150)];

    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //终点处理
    path.lineJoinStyle = kCGLineJoinRound; //线条拐角
    
    [path stroke];
    
    

    
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}
 

@end
