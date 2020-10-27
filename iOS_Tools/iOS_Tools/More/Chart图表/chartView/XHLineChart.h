//
//  XHLineChart.h
//  XHChartView
//
//  Created by zhouxuanhe on 2019/6/17.
//  Copyright © 2019 xuanhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHChartLineView.h"

@interface XHLineChart : UIView

/**
 *  表名
 */
@property (nonatomic, strong) NSString *title;

/**
 *  Y轴刻度标签title
 */
@property (nonatomic, strong) NSArray *yMarkTitles;

/**
 *  Y轴最大值
 */
@property (nonatomic, assign) CGFloat maxValue;

/**
 *  X轴刻度标签的长度（单位长度）
 */
@property (nonatomic, assign) CGFloat xScaleMarkLEN;


/**
 *  类型
 */
@property (nonatomic, assign) ChartLineType type;

/**
 *  设置折线图显示的数据和对应X坐标轴刻度标签
 *
 *  @param xMarkTitlesAndValues 折线图显示的数据和X坐标轴刻度标签
 *  @param titleKey             标签（如:9月1日）
 *  @param valueKey             数据 (如:80)
 */
- (void)setXMarkTitlesAndValues:(NSArray *)xMarkTitlesAndValues titleKey:(NSString *)titleKey valueKey:(NSString *)valueKey;

- (void)mapping;


- (void)reloadDatas;

@end
