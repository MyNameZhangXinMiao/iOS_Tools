//
//  UIView+JJEmptyView.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/8/23.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JJPlaceholderViewType) {
    JJPlaceholderViewTypeNoNetwork,  //无网络
    JJPlaceholderViewTypeNoData,    //无数据
    JJPlaceholderViewTypeNoLocation,   //无定位
    JJPlaceholderViewTypeError      //请求报错
 };

@interface UIView (JJEmptyView)

/// 占位图
@property (nonatomic, strong, readonly, nullable) UIView *jj_placeholderView;

/// 点击按钮时是否隐藏占位图
@property (nonatomic, assign)   BOOL isHidePlaceholderViewCilckButton;




/// 展示View的占位图
/// @param type 占位图类型
/// @param clickBlock 点击按钮回调
- (void)jj_showPlaceholderViewWithType:(JJPlaceholderViewType)type clickBlock:(void(^_Nullable)(NSInteger index))clickBlock;


/// 移除占位图占位图
/// 点击重新加载等按钮 的时候会移除占位图
- (void)jj_removePlaceholderView;

@end

NS_ASSUME_NONNULL_END
