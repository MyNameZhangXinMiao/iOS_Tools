//
//  JJButtonViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJButtonViewController.h"
#import "JJButton.h"


@interface JJButtonViewController ()

@end

@implementation JJButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"图文按钮";

    
    /**
     使用方法:   1.引入头文件,2.创建button,3.设置imageRect和titleRect.
     */
    
    JJButton *jj = [JJButton buttonWithType:UIButtonTypeCustom];
    //    JJButton *jj = [[JJButton alloc]init];
    jj.frame = CGRectMake(kScreenWidth * 0.5 - 80, 250, 160, 80);
    [jj setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [jj setTitle:@"搜索按钮" forState:UIControlStateNormal];
    jj.titleLabel.font = [UIFont systemFontOfSize:13];
    [jj setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [jj setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    jj.imageRect = CGRectMake(10, 10, 20, 20);
    jj.titleRect = CGRectMake(35, 10, 120, 20);
    [self.view addSubview:jj];
    //jj.backgroundColor = [UIColor colorWithRed:255/255.0 green:242/255.0 blue:210/255.0 alpha:1];
    
    
    
    
}


@end
