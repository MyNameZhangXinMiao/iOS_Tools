//
//  MagicAnimate.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/6.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "MagicAnimate.h"


@interface MagicAnimate ()<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *startView;

@property (nonatomic, strong) UIView *endView;

@property (nonatomic, strong) UIView *scaleView;

@end

@implementation MagicAnimate



- (instancetype)initWithStartView:(UIView *)startView scaleView:(UIView *)scaleView endView:(UIView *)endView{
    self = [super init];
    if (self) {
        self.startView = startView;
        self.scaleView = scaleView;
        self.endView = endView;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL presentation = toVC.presentingViewController == fromVC;
    
    if (!presentation && (self.presentedView == [transitionContext viewForKey:UITransitionContextFromViewControllerKey])) {
        self.presentedView.hidden = YES;
    }
    
    UIView *containerView = transitionContext.containerView;
    
    
    
    
    
    
    
    
    
    
}



@end
