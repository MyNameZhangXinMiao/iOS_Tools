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
#import "JJGreenView.h"

@interface JJRacViewController ()<UITextFieldDelegate>



@property (nonatomic, strong) id subscriber;

@property (nonatomic, strong) RACSignal *signal;





@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) JJRedView *redView;

@property (nonatomic, strong) UITextField *textField;


@property (nonatomic, strong) JJGreenView *greenView;

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
    
    // [self test5];
//     [self test6];
      [self test7];
   
}

#pragma mark - 初始化界面
- (void)setupUI{
 
    self.redView = [[JJRedView alloc] initWithFrame:CGRectMake(100, 100, 180, 180)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(30, 130, 80, 50);
    self.button.backgroundColor = [UIColor blueColor];
//    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.redView addSubview:self.button];
    
    
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
//    [self test4_selector];
//    [self test4_kvo];
//    [self test4_btn];
//    [self test4_notif];
//    [self test4_textField];
    [self test4_delegate];
}


- (void)test4_selector{
    
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
    
    //用法一
    [[_redView rac_valuesAndChangesForKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(id x) {
        
        NSLog(@"1----:     %@",x);
        
    }];
    //用法二
    [[_redView rac_valuesForKeyPath:@"frame" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"2----:     %@",x);
    }];
    //用法三
    [RACObserve(_redView, frame) subscribeNext:^(id  _Nullable x) {
        NSLog(@"3----:     %@",x);
    }];
     
    //用法二三在程序运行的时候就会监听到,通过log日志就能看出区别
    //写法一是在数值改变的时候再打印结果
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    _redView.frame = CGRectMake(101, 101, 181, 181);
//}

//RAC的基本用法 - 监听点击事件
- (void)test4_btn{
    
    [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        NSLog(@"button----:     %@",x);
        
        NSDictionary *dic = @{@"key":@"value"};

        [[NSNotificationCenter defaultCenter] postNotificationName:@"test4_notif" object:nil userInfo:dic];
    }];
}

//通知
- (void)test4_notif{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"test4_notif" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            
        NSLog(@"Notification------: %@",x);
    }];
    
    /*
     rac_addObserverForName 返回的是RACSigal信号,既然是信号就可以订阅,可以发发布信息
     */
}

//textField
- (void)test4_textField{
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
    self.textField.layer.borderWidth = 1;
    self.textField.placeholder = @"RactiveCocoa";
    [self.view addSubview:self.textField];
    
    //监听文本输入
//    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//
//        NSLog(@"textfield:----  %@",x);
//    }];
//
//    //可根据自己想要监听的事件选择
//    [[_textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            NSLog(@"%@",x);
//    }];
    //添加条件 --  下面表示输入文字长度 > 10 时才会调用subscribeNext
    [[_textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
         
        return value.length > 2;
        
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"输入框内容：%@", x);
    }];
    
}

//代理
- (void)test4_delegate{
    
    self.greenView = [[JJGreenView alloc] initWithFrame:CGRectMake(100, 400, 180, 180)];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.greenView];
    
    [_greenView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"---- :   %@",x);
    }];
    
    /*
     代理作为项目频繁使用的一直协议机制,我们通常需要先定义代理协议,实现代理协议方法,并且需要注意循环引用的问题.
     */
}


//rac-定时器
- (void)test5{
    
    
    //主线程每两秒执行一次
//    __block NSInteger i = 0;
//    [[RACSignal interval:2 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
//        NSLog(@"1-------:%ld,    \n2----:%@",i,x);
//        i++;
//    }];
    
    //创建一个新的线程
//    [[RACSignal interval:1 onScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityHigh name:@"e"]]
//    subscribeNext:^(NSDate * _Nullable x) {
//
//        NSLog(@"%@",[NSThread currentThread]);
//    }];
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"开始了----%@",[NSDate date]);
        [subscriber sendNext:@"ing  +++ "];
        return nil;
    }];
    [[signal delay:3] subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到了-----%@",[NSDate date]);
    }];
    
}

//RAC-RACMulticastConnection
- (void)test6{
    
    //在项目中我们一般都会涉及网络请求,在使用RAC进行网络请求的时候:
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"网络请求");
        
        [subscriber sendNext:@"得到网络请求数据"];
        return nil;
    }];

    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"1 --- %@",x);
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2 --- %@",x);
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"3 --- %@",x);
    }];
    
    /*
     2021-04-28 16:39:23.735706+0800 iOS_Tools[5607:119926] 网络请求
     2021-04-28 16:39:23.735872+0800 iOS_Tools[5607:119926] 1 --- 得到网络请求数据
     2021-04-28 16:39:23.736080+0800 iOS_Tools[5607:119926] 网络请求
     2021-04-28 16:39:23.736193+0800 iOS_Tools[5607:119926] 2 --- 得到网络请求数据
     2021-04-28 16:39:23.736337+0800 iOS_Tools[5607:119926] 网络请求
     2021-04-28 16:39:23.736463+0800 iOS_Tools[5607:119926] 3 --- 得到网络请求数据
     
     从结果看,请求了3次,但是实际开发中,我们不可能请求3次的.我们请求一次就够了,
     这个时候我们可以RACMulticastConnection这个类了,这其实是一个连接类,
     连接类的意思就是当一个信号被多次订阅,他可以帮我们避免多次创建信号中的block.
     
     基本用法如下:
     */
    
    [self test6_RACMulticastConnection];
}

- (void)test6_RACMulticastConnection{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"我又请求接口了");
        
        [subscriber sendNext:@"我又得到请求数据了"];
        return nil;
    }];
    
    RACMulticastConnection *connect = [signal publish];
    
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"1 --- %@",x);
    }];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2 --- %@",x);
    }];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"3 --- %@",x);
    }];
    [connect connect];
}

//RAC - RACCommand

- (void)test7{
//    [self test7_RACCommand];
//    [self test7_switchToLatest];
    [self test7_demo];
}
//RAC - RACCommand
- (void)test7_RACCommand{
    //command翻译过来就是命令,RACCommand
    /*
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return nil;
    }];
    
    [command execute:@"开始飞起来"];
    
     崩溃了
     崩溃日志:Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'nil signal returned from signal block for value: 开始飞起来'
     
     log中明确的告诉我们,返回的信号不能为空,既然如此我们就放回
     */
    
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"---  %@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"大佬大佬放过我"];
            return nil;
        }];
    }];
    
    //必须写在 execute 方法上面
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据--  哈哈 ---  %@",x);// <RACDynamicSignal: 0x60000326f940> name:
        
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"这里会是什么呢? - %@",x);
            //一波三折终于拿到了值,现在我们看看execute这个方法里面到底做客什么
        }];
    }];

    RACSignal *signal = [command execute:@"开始飞起来"];
    
    [signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"接收数据 ---  %@",x);
    }];
    
    
    
}

//除了上面的双层订阅,我们还可以用这个switchToLatest
- (void)test7_switchToLatest{
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"大佬大佬放过我"];
            return nil;
        }];
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据 ---  %@",x);
    }];
    
    [command execute:@"开始飞起来"];
    
    /*
     其中swiftchToLatest表示最新发送的信号.
     
     */
}

//验证swiftchToLatest发送的是不是最新的信号
- (void)test7_demo{
    
    //1.先创建5个RACSubject,其中第一个为信号中的信号(也就是发送的数据是信号)
    RACSubject *signalOfSignal = [RACSubject subject];
    RACSubject *signal1 = [RACSubject subject];
    RACSubject *signal2 = [RACSubject subject];
    RACSubject *signal3 = [RACSubject subject];
    RACSubject *signal4 = [RACSubject subject];

    //👇👇👇👇👇👇
    //2.然后就订阅信号中的信号(因为我们约定了发送的是信号,所以接收到的也是信号,既然是信号就可以订阅)
//    [signalOfSignal subscribeNext:^(id  _Nullable x) {
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"%@",x);
//        }];
//    }];
//
//    //3.发送数据
//    [signalOfSignal sendNext:signal1];
//    [signal1 sendNext:@"1"];
    
    /*
     现在我们看一下log吧
     2021-04-29 17:27:25.481110+0800 iOS_Tools[24973:535931] 1
    */
    
  //  👇👇👇👇👇👇
//    //现在我们再switchToLatest订阅
//    [signalOfSignal.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//    [signalOfSignal sendNext:signal1];
//    [signal1 sendNext:@"2"];
//
//    /*
//     log:2021-04-29 17:30:01.644538+0800 iOS_Tools[25002:538233] 2
//     */
    
    //下面我们开始测试发送多个信号,看拿到的是不是最后一个信号
    
    [signalOfSignal.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];

    [signalOfSignal sendNext:signal1];
    [signalOfSignal sendNext:signal2];
    [signalOfSignal sendNext:signal3];
    [signalOfSignal sendNext:signal4];
    
    [signal1 sendNext:@"1"];
    [signal2 sendNext:@"2"];
    [signal3 sendNext:@"3"];
    [signal4 sendNext:@"4"];
    
    /*
     log:2021-04-29 17:55:33.854705+0800 iOS_Tools[25218:551012] 4
     */
}











- (void)dealloc{
    NSLog(@"Ractive - dealloc");
}

@end
