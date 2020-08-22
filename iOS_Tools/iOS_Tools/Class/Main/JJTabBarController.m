//
//  JJTabBarController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/18.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJTabBarController.h"
#import "JJNavigationController.h"
#import "JJHomeViewController.h"
#import "JJClubViewController.h"
#import "JJMineViewController.h"
#import "JJMessageViewController.h"
#import "JJMomentViewController.h"


@interface JJTabBarController ()

@end

@implementation JJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewController:[[JJHomeViewController alloc] init] title:@"发现" normalImage:@"kl_tabbar_icon_home_normal" selectImage:@"kl_tabbar_icon_home_selected"];
    
    [self addChildViewController:[[JJClubViewController alloc] init] title:@"俱乐部" normalImage:@"kl_tabbar_icon_group_normal" selectImage:@"kl_tabbar_icon_group_selected"];
    
    [self addChildViewController:[[JJMessageViewController alloc] init] title:@"消息" normalImage:@"kl_tabbar_icon_msg_normal" selectImage:@"kl_tabbar_icon_msg_selected"];
    
    [self addChildViewController:[[JJMomentViewController alloc] init] title:@"广场" normalImage:@"kl_tabbar_icon_moment_normal" selectImage:@"kl_tabbar_icon_moment_selected"];
    
    [self addChildViewController:[[JJMineViewController alloc] init] title:@"我的" normalImage:@"kl_tabbar_icon_mine_normal" selectImage:@"kl_tabbar_icon_mine_selected"];
    
}

- (void)addChildViewController:(UIViewController *)childController
                         title:(NSString *)title
                   normalImage:(NSString *)normalImage
                   selectImage:(NSString *)selectImage{
    
    JJNavigationController *navi = [[JJNavigationController alloc] initWithRootViewController:childController];
    childController.title = title;
    navi.tabBarItem.title = title;
    navi.tabBarItem.image = [[UIImage imageNamed:normalImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    navi.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0x9fa1a9"]} forState:(UIControlStateNormal)];
    [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0x6448ff"]} forState:(UIControlStateSelected)];
    [self addChildViewController:navi];
}

@end
