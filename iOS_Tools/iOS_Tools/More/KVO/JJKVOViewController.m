//
//  JJKVOViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJKVOViewController.h"

@interface JJKVOViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation JJKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"KVO";
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(kNavBarHeight);
        make.bottom.equalTo(self.view).mas_offset(-kBottomSafeHeight);
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    
    //这样设置背景色都是不对的
    //  self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
//     self.navigationController.view.backgroundColor = [UIColor blueColor];
   // self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    // [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor redColor]] forBarMetrics:(UIBarMetricsDefault)];
    
    // 添加监听者  四个属性参数:
    /**
     observer：就是要添加的监听者对象，，当监听的属性发生改变时就会去通知该对象，该对象必须实现- observeValueForKeyPath:ofObject:change:context:方法，要不然当监听的属性的改变通知发出来，却发现没有相应的接收方法时，程序会抛出异常。
     
     keyPath：就是要被监听的属性，这里和KVC的规则一样。但是这个值不能传nil，要不然会报错。通常我们在用的时候会传一个与属性同名的字符串，但是这样可能会因为拼写错误，导致监听不成功，一个推荐的做法是，用这种方式NSStringFromSelector(@selector(propertyName))，其实就是是将属性的getter方法转换成了字符串，这样做的好处就是，如果你写错了属性名，xcode会用警告提醒你
     
     context：添加监听方法的最后一个参数，是一个可选的参数，可以传任何数据，这个参数最后会被传到监听者的响应方法中，可以用来区分不同通知，也可以用来传值。如果你要用context来区分不同的通知，一个推荐的做法是声明一个静态变量，其保持它自己的地址，这个变量没有什么意义，但是却能起到区分的作用，如下
     static void *PersonAccountBalanceContext = &PersonAccountBalanceContext;
     static void *PersonAccountInterestRateContext = &PersonAccountInterestRateContext;
     */
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
 }

- (void)willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    NSLog(@"video-%@",parent);
    
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
    NSLog(@"video-%@",parent);
    if(!parent){
        NSLog(@"页面pop成功了");
        [self removeViewObserver];
    }
}



#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"cell-%ld",(long)indexPath.row];
    
    return cell;
}

#pragma mark --------------------------------------------------
#pragma mark - 监听的属性发生变化时的回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"keyPath--:%@",keyPath);
//    NSLog(@"object--:%@",object);
//    NSLog(@"change--:%@",change);
    
    CGFloat offsetY = [change[@"new"] CGPointValue].y;

    if (offsetY > 0) {
        self.navigationController.navigationBar.alpha = 1-offsetY/100.0;
    }

    
}
#pragma mark --------------------------------------------------
#pragma mark - 私有方法
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)removeViewObserver{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark -懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end









