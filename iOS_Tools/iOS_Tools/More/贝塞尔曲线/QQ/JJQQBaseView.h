//
//  JJQQBaseView.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/12/1.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Circle.h"

NS_ASSUME_NONNULL_BEGIN

#define RADIUS 40.0


@interface JJQQBaseView : UIView

@property(nonatomic,strong) Circle *centerCircle;
@property(nonatomic,strong) Circle *touchCircle;

@property (nonatomic, assign) BOOL isFill;

//改变半径
- (void)changeCenterCircleRadiusTo:(CGFloat)radius;
- (void)changeTouchCircleRadiusTo:(CGFloat)radius;



@end

NS_ASSUME_NONNULL_END
