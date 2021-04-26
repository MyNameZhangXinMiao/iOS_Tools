//
//  JJRacViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2021/3/11.
//  Copyright © 2021 播呗网络. All rights reserved.
//

#import "JJRacViewController.h"
#import "ReactiveObjC.h"
#import "JJRedView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface JJRacViewController ()



@property (nonatomic, strong) id subscriber;

@property (nonatomic, strong) RACSignal *signal;





@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) JJRedView *redView;




@end

@implementation JJRacViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"ReactiveObjC";
    
    [self setupUI];
    // [self test1];
    // [self test2];
    // [self test3];
    // [self test4];
     [self test4_kvo];
    // [self test2];
    // [self test2];
    // [self test2];

}

#pragma mark - 初始化界面
- (void)setupUI{
 
    self.redView = [[JJRedView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
//    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.button.frame = CGRectMake(30, 30, 80, 50);
//    self.button.backgroundColor = [UIColor blueColor];
//    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.redView addSubview:self.button];
    
    
}




//RACSignal说明
- (void)test1{
    //如果项目中没有使用swift的话,直接导入ReactiveObjC,然后导入头文件ReactiveObjC.h即可.
    //RACSignal顾名思义就是信号类,(RACSignal *signal)本身不具备发送信号的能力,
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

//RAC的基本用法 - 事件处理
- (void)test4{
    
    
    [[self.redView rac_signalForSelector:@selector(buttonClick:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"--- %@",x);
    }];
    
    /*
     如果我们在VC中处理子视图redView的点击事件,通常我们会想到代理/block/通知等,
     相对于RAC就比较麻烦了,RAC可以简单的实现这个功能.
     通过rac_signalForSelector
        
     rac_signalForSelector 返回的是信号,内部创建RACSubject
     
     */
}

//RAC的基本用法 - KVO
- (void)test4_kvo{
    //通常我们使用KVO需要'addObservser'并且还要再'observeValueForKeyPath...'这个方法中去监听
    //如果一个界面监听多个还需要判断,结尾还必须释放掉
    
    //RAC中,我们如果需要监听某个属性,👇👇👇👇👇
    //并且针对每个属性都会产生不同的信号,我们只需要监听所产生的的信号再进行处理即可
//    [_redView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//
//    }];
    
    [[_redView rac_valuesAndChangesForKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(id x) {
        
        NSLog(@"----:     %@",x);
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _redView.frame = CGRectMake(101, 101, 151, 151);
}
































- (void)dealloc{
    NSLog(@"dealloc");
}

@end
