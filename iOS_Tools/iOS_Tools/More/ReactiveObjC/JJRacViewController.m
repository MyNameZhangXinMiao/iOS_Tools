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



@property (nonatomic, strong) id subscriber;

@property (nonatomic, strong) RACSignal *signal;

@end

@implementation JJRacViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"ReactiveObjC";
    
    //    [self test1];
    //    [self test2];
        [self test3];
    //    [self test2];
    //    [self test2];
    //    [self test2];
    //    [self test2];
    //    [self test2];

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



//RACDisposable
- (void)test2{
    
    //创建信号的时候可以返回一个RACDisposable
    

    //1创建信号量
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"test2- 创建信号量");
        //3发布信息
        [subscriber sendNext:@"test2 - 这是发送的一条消息"];
        self.subscriber = subscriber;
                
        NSLog(@"test2 - 那什么时候调用呢");
        return [RACDisposable disposableWithBlock:^{
            //订阅者没有强引用的时候就会调用这么block
            NSLog(@"test2 - RACDisposable");
        }];
    }];
    
    //2订阅信号量
    RACDisposable * disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"test2 - %@",x);
    }];
    
    //主动触发取消订阅,
    [disposable dispose];

    //就算实在强引用订阅者的情况下,主动调用dispose也会调用block
}


//RACSubject  RACReplaySubject
- (void)test3{
    
    //之前提过RACSignal是不具备发送信号的能力的,但是RACSubject这个类就可以做到订阅发送一体化
    
    //之前提到过的RAC三部曲,在RACSuject中同样适用
    
    //1. 创建信号
    RACSubject *subject = [RACSubject subject];
    
    //2. 订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"3--- %@",x);
    }];
    
    //3. 发送数据
    [subject sendNext:@"3-- 发送数据"];
    
    
    
    
    
    
    
    
}





































- (void)dealloc{
    NSLog(@"dealloc");
}

@end
