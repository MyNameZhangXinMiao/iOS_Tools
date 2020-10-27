//
//  JJChartDetailViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/10/27.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJChartDetailViewController.h"
#import "XHSpiderView.h"
#import "XHLineChart.h"


@interface JJChartDetailViewController ()

@property (nonatomic, strong) XHLineChart *lineChart;


@end

@implementation JJChartDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = self.titleString;
    
    
    if ([self.titleString isEqualToString:@"折线图"]){

        [self setupChartLineView];
    }else if ([self.titleString isEqualToString:@"蜘蛛图"]){
        [self setupSpiderView];
    }else if ([self.titleString isEqualToString:@"曲线图"]){

        
    }else if ([self.titleString isEqualToString:@"虚线图"]){


    }else if ([self.titleString isEqualToString:@"柱状图"]){

    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (kIs_iPhone_X) {
        NSLog(@"YES");
    } else {
        NSLog(@"NO");
    }
}



- (void)setupSpiderView{
    
    XHSpiderView *spiderView = [[XHSpiderView alloc] initWithFrame:CGRectMake(100.f, 100.f, 200.f, 200.f) radius:80.f];
    spiderView.valueArray = @[@(0.8), @(0.4), @(0.6), @(0.7), @(0.5)];
    spiderView.titleArray = @[@"力量", @"智力", @"敏捷", @"体质", @"耐力"];
    [self.view addSubview:spiderView];
    
}

- (void)setupChartLineView{
    
    // 初始化折线图
    self.lineChart = [[XHLineChart alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.width *3/5)];
    self.lineChart.backgroundColor = [UIColor whiteColor];
    // 设置折线图属性
    self.lineChart.title = @""; // 折线图名称
    NSMutableArray *orderedArray = [[NSMutableArray alloc]init];
    float max = 0;
    for(int i = 0; i < 24; i++){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSString *xValue;
        NSString *yValue;
        if (i<10) {
            xValue = [NSString stringWithFormat:@"0%d:00",i];
        } else {
            xValue = [NSString stringWithFormat:@"%d:00",i];
        }
        yValue = [NSString stringWithFormat:@"%u",arc4random() % 100];
        if ([yValue floatValue]>max) {
            max = [yValue floatValue];
        }
        dict = [@{
                  @"item" : xValue, @"count":yValue
                  } mutableCopy];
        [orderedArray addObject:dict];
    }
    
    self.lineChart.maxValue = max;
    if (max == 0) {
        self.lineChart.maxValue = 5;
    }
    self.lineChart.xScaleMarkLEN = 60;
    self.lineChart.yMarkTitles = @[@"0",[NSString stringWithFormat:@"%.2lf",max/5],[NSString stringWithFormat:@"%.2lf",max*2/5],[NSString stringWithFormat:@"%.2lf",max*3/5],[NSString stringWithFormat:@"%.2lf",max*4/5],[NSString stringWithFormat:@"%.2lf",max]]; // Y轴刻度标签
    
    [self.lineChart setXMarkTitlesAndValues:orderedArray titleKey:@"item" valueKey:@"count"]; // X轴刻度标签及相应的值
    self.lineChart.type = ChartLineTypeDotted;

    //设置完数据等属性后绘图折线图
    [self.lineChart mapping];
    [self.view addSubview:self.lineChart];
    //头顶上的时间标志
    UILabel * unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, 100, 15)];
    unitLabel.text = @"电量(度)";
    unitLabel.textColor = [UIColor lightGrayColor];
    unitLabel.font = [UIFont systemFontOfSize:15.f];
    [self.view addSubview:unitLabel];

}

@end
