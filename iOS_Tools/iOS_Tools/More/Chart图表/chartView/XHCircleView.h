//
//  XHCircleView.h
//  XHChartView
//
//  Created by zhouxuanhe on 2019/6/17.
//  Copyright © 2019 xuanhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHCircleView : UIView

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) UIColor *borderColor;

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius;


@end

NS_ASSUME_NONNULL_END
