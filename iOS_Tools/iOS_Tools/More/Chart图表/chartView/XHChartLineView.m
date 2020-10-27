//
//  XHChartLineView.m
//  XHChartView
//
//  Created by zhouxuanhe on 2019/6/17.
//  Copyright © 2019 xuanhe. All rights reserved.
//

#import "XHChartLineView.h"
#import "XHCircleView.h"

@interface XHChartLineView() {
    
    NSMutableArray *pointArray;
}

@end

@implementation XHChartLineView

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
}

- (void)setValueArray:(NSArray *)valueArray {
    _valueArray = valueArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.yAxis_L = frame.size.height;
        self.xAxis_L = frame.size.width;
        
    }
    return self;
}

- (void)mapping {
    
    [super mapping];
    
    [self drawChartLine];
    if (self.type == ChartLineTypeShadow) {
        [self drawGradient];
    }
    
    [self setupCircleViews];
}


- (void)reloadDatas {
    
    [self clearView];
    
    [self mapping];
    
}

#pragma mark 画折线图
- (void)drawChartLine {
    
    if (pointArray) {
        [pointArray removeAllObjects];
    }
    else {
        pointArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    UIBezierPath *pAxisPath = [[UIBezierPath alloc] init];
    
    for (int i = 0; i < self.valueArray.count; i ++) {
        if ([self.valueArray[i] floatValue]!=-1) {
            CGFloat point_X = self.xScaleMarkLEN * i + self.startPoint.x;
            //         CGFloat point_X = self.xScaleMarkLEN * i;
            CGFloat value = [self.valueArray[i] floatValue];
            CGFloat percent = value / self.maxValue;
            CGFloat point_Y = self.yAxis_L * (1 - percent) + self.startPoint.y;
            
            CGPoint point = CGPointMake(point_X, point_Y);
            
            // 记录各点的坐标方便后边添加渐变阴影 和 点击层视图 等
            [pointArray addObject:[NSValue valueWithCGPoint:point]];
            
            if (i == 0) {
                [pAxisPath moveToPoint:point];
            }
            else {
                [pAxisPath addLineToPoint:point];
            }
            CGSize size=[[NSString stringWithFormat:@"%.2f",value] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:9.f]}];
            
            UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, 10)];
            textLabel.font = [UIFont systemFontOfSize:9.f];
            textLabel.text = [NSString stringWithFormat:@"%.2f",value];
            textLabel.center = CGPointMake(point_X, point_Y - 12);
            [self addSubview:textLabel];
        }
    }
    
    CAShapeLayer *pAxisLayer = [CAShapeLayer layer];
    pAxisLayer.lineWidth = 1;
    pAxisLayer.strokeColor = [UIColor colorWithRed:54/255.0 green:221/255.0 blue:235/255.0 alpha:1].CGColor;
    pAxisLayer.fillColor = [UIColor clearColor].CGColor;
    pAxisLayer.path = pAxisPath.CGPath;
    [self.layer addSublayer:pAxisLayer];
    
    CABasicAnimation *anmi = [CABasicAnimation animation];
    anmi.keyPath = @"strokeEnd";
    anmi.fromValue = [NSNumber numberWithFloat:0];
    anmi.toValue = [NSNumber numberWithFloat:1.0f];
    anmi.duration = 5;
    anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi.autoreverses = NO;
    [pAxisLayer addAnimation:anmi forKey:@"stroke"];
    
}

#pragma mark 渐变阴影
- (void)drawGradient {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:54/255.0 green:221/255.0 blue:235/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor];
    
    gradientLayer.locations=@[@0.0,@1.0];
    gradientLayer.startPoint = CGPointMake(0.0,0.0);
    gradientLayer.endPoint = CGPointMake(0.0,1);
    
    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
    [gradientPath moveToPoint:CGPointMake(self.startPoint.x, self.yAxis_L + self.startPoint.y)];
    
    for (int i = 0; i < pointArray.count; i ++) {
        [gradientPath addLineToPoint:[pointArray[i] CGPointValue]];
    }
    
    CGPoint endPoint = [[pointArray lastObject] CGPointValue];
    endPoint = CGPointMake(endPoint.x, self.yAxis_L + self.startPoint.y);
    [gradientPath addLineToPoint:endPoint];
    //遮罩层
    CAShapeLayer *shadeLayer = [CAShapeLayer layer];
    shadeLayer.path = gradientPath.CGPath;
    gradientLayer.mask = shadeLayer;
    [self.layer addSublayer:gradientLayer];
    
    
  
    gradientLayer.cornerRadius = 5;
    gradientLayer.masksToBounds = YES;
    gradientLayer.locations = @[@(0.5f)];
    CALayer *baseLayer = [CALayer layer];
    [baseLayer addSublayer:gradientLayer];
    [baseLayer setMask:shadeLayer];
    [self.layer addSublayer:baseLayer];
    
}

#pragma mark 折线上的圆环
- (void)setupCircleViews {
    
    for (int i = 0; i < pointArray.count; i ++) {
        
        XHCircleView *circleView = [[XHCircleView alloc] initWithCenter:[pointArray[i] CGPointValue] radius:4];
        circleView.borderColor = [UIColor colorWithRed:54/255.0 green:221/255.0 blue:235/255.0 alpha:1];
        circleView.borderWidth = 1.0;
        [self addSubview:circleView];
    }
}

#pragma mark- 清空视图
- (void)clearView {
    [self removeSubviews];
    [self removeSublayers];
}

#pragma mark 移除 点击图层 、圆环 、数值标签
- (void)removeSubviews {
    
    NSArray *subViews = [NSArray arrayWithArray:self.subviews];
    
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
}

#pragma mark 移除折线
- (void)removeSublayers {
    NSArray * subLayers = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer * layer in subLayers) {
        [layer removeFromSuperlayer];
    }
}

@end
