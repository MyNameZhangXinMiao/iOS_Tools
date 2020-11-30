//
//  JJBezierAnimateController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/11/30.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJBezierAnimateController.h"
#import "JJBezierAnimationView.h"
#import "JJCuteView.h"



@interface JJBezierAnimateController ()

@end

@implementation JJBezierAnimateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = self.typeStr;
    
    if ([self.typeStr isEqualToString:@"折线动画"]) {
        JJBezierAnimationView *bezierView = [[JJBezierAnimationView alloc] init];
        [bezierView setItemValues:@[@"1",@"4",@"3",@"2",@"8",@"6",@"2",@"8",@"5",@"7",@"4",@"6"]];
        [self.view addSubview:bezierView];
        
    }else if ([self.typeStr isEqualToString:@"QQ消息动画"]){
        
        
    }else if ([self.typeStr isEqualToString:@"果冻动画"]){
        
        JJCuteView *cuteView = [[JJCuteView alloc] initWithFrame:CGRectMake(0, 100, 320, 568)];
        cuteView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:cuteView];
        
    }else if ([self.typeStr isEqualToString:@"贝塞尔曲线"]){
        
    }
    
    
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
