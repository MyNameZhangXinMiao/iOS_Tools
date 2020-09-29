//
//  JJAnimateCodeViewController.m
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJAnimateCodeViewController.h"

@interface JJAnimateCodeViewController ()

@end

@implementation JJAnimateCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 
 //从小变大,再缩小一点点,正常值
 - (void)shakeToShow:(UIView*)aView{
     CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
     animation.duration = 0.6;
     
     NSMutableArray *values = [NSMutableArray array];
     [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
     [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
     [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
     [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
     
     animation.values = values;
     [aView.layer addAnimation:animation forKey:nil];
 }
 
 */

@end
