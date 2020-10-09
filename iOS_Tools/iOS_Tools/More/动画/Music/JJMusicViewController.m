//
//  JJMusicViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJMusicViewController.h"

@interface JJMusicViewController ()

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIImageView *playImgView;;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign)   BOOL isAnimation;


@end

@implementation JJMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"音乐动画";
    
    // 创建定时器，不停刷新动画
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(imgRotation)];
    
    // 加入到主循环中
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    [self setupUI];
    
}

#pragma mark - 初始化界面
- (void)setupUI
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.frame = CGRectMake(100, kScreenHeight-200, 50, 30);
    [self.view addSubview:btn];
    
    self.bgImgView.frame = CGRectMake((kScreenWidth-207)/2, 200, 207, 222);
    [self.view addSubview:self.bgImgView];
    
    self.imgView.frame = CGRectMake(12, 14, 150, 150);
    [self.bgImgView addSubview:self.imgView];
    
    self.playImgView.frame = CGRectMake(10, 2, 100, 22);
    [self.bgImgView addSubview:self.playImgView];
    
}
// 视图旋转
- (void)imgRotation {
    if (self.isAnimation) {
        self.imgView.transform = CGAffineTransformRotate(self.imgView.transform, M_PI_4 / 60);
    }else{
        self.playImgView.transform = CGAffineTransformIdentity;
    }
}
- (void)buttonClickAction:(UIButton *)button{
    
    button.selected = !button.selected;
    
    if (button.selected) {
        /*
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.removedOnCompletion = NO;
        // 设定动画选项
        animation.duration    = 2.0; // 持续时间
        animation.repeatCount = HUGE_VALF; // 重复次数,这里设置为最大，达到不停旋转的效果
        // 设定旋转角度
        animation.fromValue   = [NSNumber numberWithFloat:0.0]; // 起始角度
        animation.toValue     = [NSNumber numberWithFloat:M_PI*2.5];  // 终止角度
        // 添加动画
        [self.imgView.layer addAnimation:animation forKey:@"imageView-layer"];
        
        */
        self.isAnimation = YES;
        // 设置定点
        [self setAnchorPoint:CGPointMake(7.0/100, 7.0/22) forView:self.playImgView];
        // 旋转-30°
        [UIView animateWithDuration:0.25 animations:^{
            self.playImgView.transform = CGAffineTransformMakeRotation(M_PI_2 / 4);
        }completion:^(BOOL finished) {
            if (!finished) {
                self.playImgView.transform = CGAffineTransformMakeRotation(M_PI_2 / 4);
            }
        }];
        
    } else {
        self.isAnimation = NO;

        // 设置定点
        [self setAnchorPoint:CGPointMake(7.0/100, 7.0/22) forView:self.playImgView];
        
        // 恢复
        [UIView animateWithDuration:0.25 animations:^{
            self.playImgView.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            if (!finished) {
                self.playImgView.transform = CGAffineTransformIdentity;
            }
        }];
        
        [self.imgView.layer removeAllAnimations];
    }
}
// 通过固定layer的anchorPoint来实现定点旋转
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"music1"];
    }
    return _imgView;
}

- (UIImageView *)bgImgView{
    if (_bgImgView == nil) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.image = [UIImage imageNamed:@"music3"];
    }
    return _bgImgView;
}

- (UIImageView *)playImgView{
    if (_playImgView == nil) {
        _playImgView = [[UIImageView alloc] init];
        _playImgView.image = [UIImage imageNamed:@"music2"];
    }
    return _playImgView;
}

- (void)dealloc{
    
    
    
}

@end


