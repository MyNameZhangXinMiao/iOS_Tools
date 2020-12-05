//
//  JJBezierAnimateController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/11/30.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJBezierAnimateController.h"
#import "JJBezierAnimationView.h"
#import "JJCuteView.h"
#import "JJQQBaseView.h"
#import "JJContextRefView.h"


@interface JJBezierAnimateController ()

/// QQ消息动画原理
@property (nonatomic, strong) UISlider *centerSlider;
@property (nonatomic, strong) UISlider *touchSlider;
@property (nonatomic, strong) JJQQBaseView *qqBaseView;



@end

@implementation JJBezierAnimateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = self.typeStr;
    
    if ([self.typeStr isEqualToString:@"折线动画"]) {
        JJBezierAnimationView *bezierView = [[JJBezierAnimationView alloc] init];
        [bezierView setItemValues:@[@"1",@"4",@"3",@"2",@"8",@"6",@"2",@"8",@"5",@"7",@"4",@"6"]];
        [self.view addSubview:bezierView];
        
    }else if ([self.typeStr isEqualToString:@"QQ消息动画原理"]){
        
        _qqBaseView = [[JJQQBaseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view addSubview:self.qqBaseView];
        
        [self.view bringSubviewToFront:self.navigationCustomView];
        
        self.centerSlider.frame = CGRectMake(50, 100, kScreenWidth-100, 50);
        self.touchSlider.frame = CGRectMake(50, 200, kScreenWidth-100, 50);
        [self.view addSubview:self.centerSlider];
        [self.view addSubview:self.touchSlider];
        
    }else if ([self.typeStr isEqualToString:@"果冻动画"]){
        JJCuteView *cuteView = [[JJCuteView alloc] initWithFrame:CGRectMake(0, 100, 320, kScreenHeight-100)];
        cuteView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:cuteView];
    }else if ([self.typeStr isEqualToString:@"QQ消息动画"]){
        
        
        
        
        
    }else if ([self.typeStr isEqualToString:@"CGContextRef"]){//上下文
        
        JJContextRefView *context = [[JJContextRefView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenWidth)];
        context.backgroundColor = [UIColor blueColor];
        [self.view addSubview:context];
    }
    
    
}


//拖动滑杆
- (void)onProgressChanged:(UISlider *)slider{
    CGFloat value = slider.value;
    NSLog(@"progress:%f", value);
    
    switch (slider.tag) {
        case 100:{
            CGFloat r = RADIUS;
            [self.qqBaseView changeCenterCircleRadiusTo:r * value];
            break;
        }
        case 101:{
            CGFloat r = RADIUS;
            [self.qqBaseView changeTouchCircleRadiusTo:r * value];
            break;
        }
        default:
            break;
    }
}

#pragma mark - lazy
- (UISlider *)centerSlider{
    if (!_centerSlider) {
        _centerSlider = [[UISlider alloc] init];
        _centerSlider.tag = 100;
        [_centerSlider addTarget:self action:@selector(onProgressChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _centerSlider;
}

- (UISlider *)touchSlider{
    if (!_touchSlider) {
        _touchSlider = [[UISlider alloc] init];
        _touchSlider.tag = 101;
        [_touchSlider addTarget:self action:@selector(onProgressChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _touchSlider;
}

@end
