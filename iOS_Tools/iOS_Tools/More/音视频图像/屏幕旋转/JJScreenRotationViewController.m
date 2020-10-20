//
//  JJScreenRotationViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/10/20.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJScreenRotationViewController.h"


typedef NS_ENUM(NSUInteger, ScreenRotationType){
    ScreenRotationTypeNormal,   ///普通写法
    ScreenRotationTypeperfect,   ///视频动画完美用法
};


@interface JJScreenRotationViewController ()

@property (nonatomic, strong) UIImageView   *playView;

@property (nonatomic, assign)   ScreenRotationType rotationType;
@end

@implementation JJScreenRotationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"屏幕旋转";
    
    self.rotationType = ScreenRotationTypeNormal;
    [self setupUI];
    
    
}

#pragma mark - 初始化界面
- (void)setupUI{
    
     ///1.监听屏幕旋转通知
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateScreenViews:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.playView.frame = CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenWidth *1.2);

    [self.view addSubview:self.playView];
    
}


///
- (void)rotateScreenViews:(NSObject *)sender{
    
    if (self.rotationType == ScreenRotationTypeNormal) {
        UIDevice* device = [sender valueForKey:@"object"];
        if (device.orientation == UIDeviceOrientationPortrait ) {
            self.playView.frame = CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenWidth *1.2);
        }
        if (device.orientation == UIDeviceOrientationLandscapeLeft ) {
            self.playView.frame = CGRectMake(kNavBarHeight, kNavBarHeight, kScreenWidth/1.2, kScreenWidth);
        }
        if (device.orientation == UIDeviceOrientationLandscapeRight ) {
            self.playView.frame = CGRectMake(kNavBarHeight, kNavBarHeight, kScreenWidth/1.2, kScreenWidth);
        }
        
        
        return;
    }
    
    
    if (self.rotationType == ScreenRotationTypeperfect) {

        
        
        
        return;
    }
    

    
}

/*--------------------  自动旋转  -----------------------*/








/*--------------------  手动旋转  -----------------------*/











/*-----------------  视图旋转不做介绍  --------------------*/



- (UIImageView *)playView{
    if (_playView == nil) {
        _playView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhouxuanhe"]];
    }
    return _playView;
}



@end
