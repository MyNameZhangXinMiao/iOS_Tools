//
//  JJRacViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2021/3/11.
//  Copyright © 2021 播呗网络. All rights reserved.
//

#import "JJRacViewController.h"
#import "ReactiveObjC.h"

@interface JJRacViewController ()

@end

@implementation JJRacViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"ReactiveObjC";
    
    [self test1];
    
}


//RACSignal说明
- (void)test1{
    //如果项目中没有使用swift的话,直接导入ReactiveObjC,然后导入头文件ReactiveObjC.h即可.
    //RACSignal顾名思义就是信号类,
    //1.创建信号量
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"创建信号量");
     
        //发布信息
        [subscriber sendNext:@"发送数据咯"];
        
        NSLog(@"发送完成");
        return nil;
    }];
    
    //订阅信号量
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    
    
}







@end
