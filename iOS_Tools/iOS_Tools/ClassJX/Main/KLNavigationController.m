//
//  KLNavigationController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/18.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "KLNavigationController.h"

@interface KLNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation KLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    self.navigationBar.translucent = NO;
//    self.navigationBar.barTintColor = [UIColor blackColor];//主色调 白色
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    textAttrs[NSShadowAttributeName] = nil;
    [self.navigationBar setTitleTextAttributes:textAttrs];
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count > 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.hidesBackButton = YES;
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self navigationBackBtn]];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"kl_navbar_icon_back_gray"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(popAction:)];
        viewController.navigationItem.leftBarButtonItem.width = 44;
    }
}

- (void)popAction:(UIBarButtonItem *)item {
    [self popViewControllerAnimated:YES];
}

@end
