//
//  XHSpiderView.h
//  pathDome
//
//  Created by Leexin on 16/8/12.
//  Copyright © 2016年 garden. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, XHSpiderPointPosition) { // 顶点位置
    XHSpiderPointPositionTopMid = 0, // 上中
    XHSpiderPointPositionTopRight, // 上右
    XHSpiderPointPositionBottomRight, // 下右
    XHSpiderPointPositionBottomLeft, // 下左
    XHSpiderPointPositionTopLeft, // 上左
};

@interface XHSpiderView : UIView

@property (nonatomic, strong) NSArray *valueArray;
@property (nonatomic, strong) NSArray *titleArray;

- (instancetype)initWithFrame:(CGRect)frame radius:(CGFloat)radius;

@end
