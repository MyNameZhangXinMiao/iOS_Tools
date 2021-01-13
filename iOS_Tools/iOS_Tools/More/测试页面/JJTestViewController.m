//
//  JJTestViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/10/12.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJTestViewController.h"
#import "JJTestImage.h"
#import "JJTest2ViewController.h"

@interface JJTestViewController ()
<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;

@end

@implementation JJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"测试";
    
    
    
//    self.imgView1.frame = CGRectMake(100, 100, 18, 18);
//    self.imgView2.frame = CGRectMake(100, 250, 18, 18);
//
//    [self.view addSubview:self.imgView1];
//    [self.view addSubview:self.imgView2];
//
//    UIImage *img1 = [JJTestImage drawText1:@"8" text2:@"9"];
//    self.imgView1.image = img1;
//    UIImage *img2 = [JJTestImage drawText1:@"3" text2:@"2" forImage:[UIImage imageNamed:@"messagelist_number_icon"]];
//    self.imgView2.image = img2;
    
    self.view.backgroundColor = [UIColor redColor];
    
    /*
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
        imageView1.image = [UIImage imageNamed:@"zbj_dan_animation_1"];
        [self.view addSubview:imageView1];
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
        imageView2.image = [UIImage imageNamed:@"zbj_dan_animation_1"];
        [self.view addSubview:imageView2];
//
//        TestView *view = [TestView new];
//        view.frame = self.view.bounds;
//        view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
//        [self.view addSubview:view];
     
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
        imageView.image = [UIImage imageNamed:@"light"];
        [self.view addSubview:imageView];
        
        
//        UIView *roundView = [[UIView alloc]initWithFrame: CGRectMake(50, 50, 100, 100)];
//        roundView.backgroundColor = [UIColor redColor];
//        _viewwww = roundView;
        imageView.maskView = imageView1;
    

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0,0)];
    [path addLineToPoint:CGPointMake(kScreenWidth, kScreenWidth)];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation1.path = path.CGPath;
    animation1.repeatCount = 20;
    animation1.duration = 3;
    [imageView.layer addAnimation:animation1 forKey:nil];
     */
 
//    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 170)];
//    lb.text = @"闪动加载请 \n去问问群翁无群翁";
//    lb.numberOfLines = 2;
//    lb.textColor = [UIColor lightGrayColor];
//    lb.font = [UIFont boldSystemFontOfSize:40];
//    [self.view addSubview:lb];

    UIImageView *imgV2= [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 170)];
    imgV2.image = [UIImage imageNamed:@"zbj_dan_animation_2"];
    [self.view addSubview:imgV2] ;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
    imgV.image = [UIImage imageNamed:@"zbj_dan_animation_2"];
    [self.view addSubview:imgV];

//    CAGradientLayer *colorLayer = [CAGradientLayer layer];
//    colorLayer.frame = CGRectMake(0, 0, 320, 320);
//    colorLayer.position = imgV.center;
//    [self.view.layer addSublayer:colorLayer];
    
    UIImageView *imgV3 = [[UIImageView alloc] initWithFrame:CGRectMake(-50, 50, 320, 170)];
    imgV3.image = [UIImage imageNamed:@"light"];
    [self.view addSubview:imgV3];
    imgV3.maskView = imgV;

//    __block int i = 0;
//    [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        i++;
//        imgV3.frame = CGRectMake(0, 100+i*3, 320, 170);
//        imgV3.maskView = imgV;
//
//    }];
//
    
    

//    colorLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor clearColor].CGColor];
//    colorLayer.locations = @[@(-0.2),@(- 0.1),@(0)];
//    colorLayer.startPoint = CGPointMake(0, 0);
//    colorLayer.endPoint = CGPointMake(1, 1);
//    colorLayer.mask = imgV.layer;
//
//
//    [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        CABasicAnimation *fadeA = [CABasicAnimation animationWithKeyPath:@"locations"];
//        fadeA.fromValue = @[@(-0.2),@(-0.1),@(0)] ;
//        fadeA.toValue = @[@(1.0),@(1.1),@(1.2)] ;
//
//        // fadeA.fromValue = @[@(0),@(0.1),@(-0.2)] ;
//        // fadeA.toValue = @[@(1.2),@(1.1),@(1.0)] ;
//
//        fadeA.duration = 2 ;
//        [colorLayer addAnimation:fadeA forKey:nil];
//    }];
    
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, (kScreenHeight-200)/2, 200, 200)];
    header.backgroundColor = [UIColor whiteColor];
    
//    [self.view addSubview:header];
    
   // [self shakeToShow:header];
    
    
    
    
 
    UIImage *img1 = [JJTestImage drawText1:@"8" text2:@"9"];
    self.imgView1.image = img1;
    UIImage *img2 = [JJTestImage drawText1:@"3" text2:@"2" forImage:[UIImage imageNamed:@"messagelist_number_icon"]];
    self.imgView2.image = img2;
    
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClcik) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn];
}

 
- (void)btnClcik{
    JJTest2ViewController *vc = [[JJTest2ViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)shakeToShow:(UIView*)aView{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 1.5;// 动画时间
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    // 这三个数字，我只研究了前两个，所以最后一个数字我还是按照它原来写1.0；前两个是控制view的大小的；
    animation.delegate = self;

    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    animation.values = values;
    
    [aView.layer addAnimation:animation forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
 
    NSLog(@"1212");
    NSLog(@"1212");
}

- (UIImageView *)imgView1{
    if (_imgView1 == nil) {
        _imgView1 = [[UIImageView alloc] init];
    }
    return _imgView1;
}

- (UIImageView *)imgView2{
    if (_imgView2 == nil) {
        _imgView2 = [[UIImageView alloc] init];
    }
    return _imgView2;
}


@end
