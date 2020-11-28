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

@end

@implementation JJBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"贝塞尔曲线";

    [self drawTest];
    
    
    
    
    

}






- (void)drawTest{
    JJBezierView *bezierView = [[JJBezierView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, 300)];
    [self.view addSubview:bezierView];
   // bezierView.layer.borderWidth = 1;
    
    bezierView.backgroundColor = [UIColor blueColor];
}



@end
