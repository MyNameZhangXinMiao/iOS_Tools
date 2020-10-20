//
//  JJAutoRunViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/7.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJAutoRunViewController.h"
#import "JJAutoRunView.h"

@interface JJAutoRunViewController ()<JJAutoRunViewDelegate>

@end

@implementation JJAutoRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createAutoRunView];
}

//MARK:- CreateAutoRunView
- (void)createAutoRunView {
    JJAutoRunView *runView = [[JJAutoRunView alloc] initWithFrame:CGRectMake(0, 100, KScreenWidth, 50)];
    runView.delegate = self;
    runView.directionType = LeftType;
    [self.view addSubview:runView];
    [runView addContentView:[self createLabelWithText:@"繁华声 遁入空门 折煞了梦偏冷 辗转一生 情债又几 如你默认 生死枯等 枯等一圈 又一圈的 浮图塔 断了几层 断了谁的痛直奔 一盏残灯 倾塌的山门 容我再等 历史转身 等酒香醇 等你弹 一曲古筝" textColor:[self                                                                                                                                                              randomColor] labelFont:[UIFont systemFontOfSize:14]]];
    [runView startAnimation];
}

- (UILabel *)createLabelWithText: (NSString *)text textColor:(UIColor *)textColor labelFont:(UIFont *)font {
    NSString *string = [NSString stringWithFormat:@"%@", text];
    CGFloat width = [string widthWithFont:font height:30];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
    label.font = font;
    label.text = string;
    label.textColor = textColor;
    return label;
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:[self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1];
}

- (CGFloat)randomValue {
    return arc4random()%255 / 255.0f;
}

@end
