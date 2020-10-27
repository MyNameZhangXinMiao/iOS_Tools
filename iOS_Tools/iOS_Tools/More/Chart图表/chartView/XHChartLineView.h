//
//  XHChartLineView.h
//  XHChartView
//
//  Created by zhouxuanhe on 2019/6/17.
//  Copyright © 2019 xuanhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHAxisView.h"
typedef NS_ENUM(NSUInteger,ChartLineType){
    ChartLineTypeSolid = 0,    //实线折线
    ChartLineTypeShadow ,      //阴影
    ChartLineTypeDotted        //虚线
};


@interface XHChartLineView : XHAxisView

@property (nonatomic, strong) NSArray *valueArray;
@property (nonatomic, assign) ChartLineType type;

@property (nonatomic, assign) CGFloat maxValue;

/**
 *  绘图
 */
- (void)mapping;

/**
 *  更新折线图数据
 */
- (void)reloadDatas;

@end
