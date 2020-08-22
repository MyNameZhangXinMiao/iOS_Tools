//
//  KLEmptyStateView.h
//  KLSocial
//
//  Created by 播呗网络 on 2019/7/9.
//  Copyright © 2019 播呗网络. All rights reserved.
//


#import "KLEmptyViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,KLEmptyStateViewStyle) {
    KLEmptyStateViewStyleNoData,            ///< 无数据
    KLEmptyStateViewStyleNetworkFail,       ///< 无网络
    KLEmptyStateViewStyleLocationFail,      ///< 定位失败
};

@interface KLEmptyStateView : KLEmptyView



- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;


///< 构造方法
+ (KLEmptyStateView *)createEmptyViewWithStyle:(KLEmptyStateViewStyle)style;

///< 改变EmptyView类型
- (void)changeEmptyViewStyle:(KLEmptyStateViewStyle)style;

- (void)clickBtnActionCompleteHandle:(void(^)(void))completeHandle;
- (void)tapViewActionCompleteHandle:(void(^)(void))completeHandle;

@end

NS_ASSUME_NONNULL_END
