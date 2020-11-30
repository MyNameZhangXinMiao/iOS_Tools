//
//  JJBeizerListViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/11/30.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJBeizerListViewController.h"
#import "JJBezierViewController.h"
#import "JJBezierAnimateController.h"


@interface JJBeizerListViewController ()

@end

@implementation JJBeizerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"贝塞尔曲线";
    
    self.data = @[@"贝塞尔曲线",@"折线动画",@"果冻动画",@"QQ消息动画"];
    [self.tableView reloadData];
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *text = self.data[indexPath.row];
    if ([text isEqualToString:@"贝塞尔曲线"]){
        JJBezierViewController *vc = [[JJBezierViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"折线动画"]){
        JJBezierAnimateController *vc = [[JJBezierAnimateController alloc] init];
        vc.typeStr = text;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"果冻动画"]){
        JJBezierAnimateController *vc = [[JJBezierAnimateController alloc] init];
        vc.typeStr = text;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"QQ消息动画"]){
        
        
        
        
    }


    
}


@end
