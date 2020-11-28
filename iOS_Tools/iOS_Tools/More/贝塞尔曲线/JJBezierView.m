//
//  JJBezierView.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/11/25.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJBezierView.h"


@interface JJBezierView ()


@end
@implementation JJBezierView
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

/*
 //线段
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(30, 30)];
    [path addLineToPoint:CGPointMake(200, 80)];
    [path addLineToPoint:CGPointMake(150, 150)];

    path.lineWidth = 10.0;
    path.lineCapStyle = kCGLineCapSquare; //终点处理
    path.lineJoinStyle = kCGLineJoinRound; //线条拐角
    
    [path stroke];
    
}

*/

//多边形
/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 100)];
    [path addLineToPoint:CGPointMake(150, 50)];
    [path addLineToPoint:CGPointMake(250, 100)];
    [path addLineToPoint:CGPointMake(250, 200)];
    [path addLineToPoint:CGPointMake(100, 200)];
    [path closePath]; // 最后一根线条,可以直接调此方法
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //终点处理
    path.lineJoinStyle = kCGLineJoinRound; //线条拐角
    
    [path stroke];  //不填充
    // [path fill];  //填充
}

*/

//矩形
/*
- (void)drawRect:(CGRect)rect {
   [super drawRect:rect];
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 150, 80)];
    
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //终点处理
    path.lineJoinStyle = kCGLineJoinRound; //线条拐角
    
    [path stroke];
}
 */

//圆形
//- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//
//    UIColor *color = [UIColor redColor];
//    [color set];
//
//    UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 150, 80)];
//    path.lineWidth = 5.0;
//
//    [path stroke];
//}


//圆弧
/*
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *color = [UIColor redColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:100 startAngle:1.25 * M_PI endAngle:1.75 * M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(200, 200)];
    [path closePath];
    
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //终点处理
    path.lineJoinStyle = kCGLineJoinRound; //线条拐角
    [path stroke];
}
*/

//二次曲线
/*
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *color = [UIColor redColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(100, 200)];
    [path addQuadCurveToPoint:CGPointMake(250, 200) controlPoint:CGPointMake(50, 40)];
   
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path stroke];
}

*/

// 三次曲线
/*
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *color = [UIColor redColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 150)];
    [path addCurveToPoint:CGPointMake(260, 150) controlPoint1:CGPointMake(140, 0) controlPoint2:CGPointMake(140, 400)];

    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path stroke];
}

 */

//带内切角的矩形
/*
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 200, 150) cornerRadius:20];
    
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    [path stroke];
}
 */


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 200, 150) byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    [path stroke];
}

@end
