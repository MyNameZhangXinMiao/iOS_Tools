//
//  JJTest2ViewController.m
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/12/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJTest2ViewController.h"

@interface JJTest2ViewController ()

@end

@implementation JJTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    btn.frame = CGRectMake(10, 200, 375, 200);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    return self;
}
@end
