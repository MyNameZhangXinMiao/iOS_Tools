//
//  JJChartViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJChartViewController.h"
#import "JJChartDetailViewController.h"

@interface JJChartViewController ()

@end

@implementation JJChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"Chart图表";
    
    self.data = @[@"折线图",@"蜘蛛图",@"曲线图",@"虚线图",@"柱状图",@"折线阴影图",@"饼图"];
    [self.tableView reloadData];
    
    [self setupUI];
    
}
 

 


#pragma mark -
#pragma mark - 初始化界面
- (void)setupUI
{
    

    
    
    
    
    
}

#pragma mark - tableView delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *text = self.data[indexPath.row];
    JJChartDetailViewController *vc = [[JJChartDetailViewController alloc] init];
    vc.titleString = text;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getter and setter


@end
