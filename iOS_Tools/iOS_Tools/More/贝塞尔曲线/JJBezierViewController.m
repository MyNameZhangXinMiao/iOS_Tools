//
//  JJBezierViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/11/25.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJBezierViewController.h"
#import "JJBezierView.h"


@interface JJBezierViewController ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *testView;

@end

@implementation JJBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"贝塞尔曲线";

//    [self drawTest];
    self.bgView.backgroundColor = [UIColor blueColor];
    self.bgView.frame = CGRectMake(0, 100, kScreenWidth, kScreenWidth);
    [self.view addSubview:self.bgView];
    self.bgView.layer.borderWidth = 1;
   
//    self.testView.backgroundColor = [UIColor orangeColor];
//    self.testView.frame = CGRectMake(100, 100, 200, 200);
//    [self.bgView addSubview:self.testView];

    //    [self test1];
//    [self test2];
//    [self test3];
    [self test4];



}


//折线
- (void)test1{
    
    // 创建一个路径对象
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(100, 100)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(200,200)];
    [linePath addLineToPoint:CGPointMake(230,130)];
     
    // 设置路径画布
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.bounds = CGRectMake(0, 0, 300, 300);
    lineLayer.position = CGPointMake(kScreenWidth/2, kScreenWidth/2);
    lineLayer.lineWidth = 3.0;
    lineLayer.strokeColor = [UIColor redColor].CGColor; //   边线颜色
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil;   //  默认是black
    
    [self.bgView.layer addSublayer:lineLayer];
}


- (void)test2{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 100)];
    [path addLineToPoint:CGPointMake(150, 50)];
    [path addLineToPoint:CGPointMake(250, 100)];
    [path addLineToPoint:CGPointMake(250, 200)];
    [path addLineToPoint:CGPointMake(100, 200)];
    [path closePath]; // 最后一根线条,可以直接调此方法
        
    // 设置路径画布
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.bounds = CGRectMake(0, 0, 300, 300);
    lineLayer.position = CGPointMake(kScreenWidth/2, kScreenWidth/2);
    lineLayer.lineWidth = 3.0;
    lineLayer.strokeColor = [UIColor redColor].CGColor; //   边线颜色
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = [UIColor yellowColor].CGColor;   //  默认是black
    
    [self.bgView.layer addSublayer:lineLayer];
    
}

//圆弧
- (void)test3{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:100 startAngle:1.25 * M_PI endAngle:1.75 * M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(200, 200)];
    [path closePath];
   
    // 设置路径画布
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.bounds = CGRectMake(0, 0, 300, 300);
    lineLayer.position = CGPointMake(kScreenWidth/2, kScreenWidth/2);
    lineLayer.lineWidth = 3.0;
    lineLayer.strokeColor = [UIColor redColor].CGColor; //   边线颜色
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = [UIColor yellowColor].CGColor;   //  默认是black
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.lineJoin = kCALineJoinRound; //线条拐角
    [self.bgView.layer addSublayer:lineLayer];
    
}

- (void)test4{
      
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.testView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(25, 25)];
    
    // 设置路径画布
    CAShapeLayer *lineLayer =  [[CAShapeLayer alloc] init];
    lineLayer.frame = self.testView.bounds;
    lineLayer.path = path.CGPath;
    
    [self.testView.layer addSublayer:lineLayer];
    self.testView.layer.mask = lineLayer;
    
}


- (void)drawTest{
    JJBezierView *bezierView = [[JJBezierView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, 300)];
    [self.view addSubview:bezierView];
   // bezierView.layer.borderWidth = 1;
    
    bezierView.backgroundColor = [UIColor blueColor];
}




- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

- (UIView *)testView{
    if (_testView == nil) {
        _testView = [[UIView alloc] init];
        _testView.backgroundColor = [UIColor clearColor];
    }
    return _testView;
}


@end
