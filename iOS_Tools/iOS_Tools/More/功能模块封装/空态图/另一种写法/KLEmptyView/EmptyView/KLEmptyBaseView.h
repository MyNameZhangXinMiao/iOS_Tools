//
//  KLEmptyBaseView.h
//  KLSocial
//
//  Created by 播呗网络 on 2019/7/9.
//  Copyright © 2019 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KLTapActionBlock)(void);

@interface KLEmptyBaseView : UIView

@property (nonatomic,strong) UIImage *image;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *detailStr;
@property (nonatomic, copy) NSString *btnTitleStr;

@property (nonatomic,strong,readonly) UIView *contentView;
@property (nonatomic,strong,readonly) UIView *customView;

@property (nonatomic, copy) KLTapActionBlock btnActionBlock;        ///<按钮点击事件
@property (nonatomic, copy) KLTapActionBlock tapEmptyViewBlock;     ///<emptyView点击事件



///<初始化配置
- (void)prepare;

///<重置Subviews
- (void)setupSubviews;


/**
 构造方法 - 创建emptyView
 
 @param image         占位图片
 @param titleStr      占位描述
 @param detailStr     详细描述
 @return 返回一个没有点击事件的emptyView
 */
+ (instancetype)emptyViewWithImage:(UIImage *)image
                          titleStr:(NSString *)titleStr
                         detailStr:(NSString *)detailStr;

/**
 构造方法 - 创建emptyView
 
 @param image          占位图片
 @param titleStr       占位描述
 @param detailStr      详细描述
 @param btnTitleStr    按钮的名称
 @return 返回一个emptyView
 */
+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                                titleStr:(NSString *)titleStr
                               detailStr:(NSString *)detailStr
                             btnTitleStr:(NSString *)btnTitleStr;


/**
 构造方法 - 创建emptyView
 
 @param image          占位图片
 @param titleStr       占位描述
 @param detailStr      详细描述
 @param btnTitleStr    按钮的名称
 @param btnClickBlock  按钮点击事件回调
 @return 返回一个emptyView
 */
+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                                titleStr:(NSString *)titleStr
                               detailStr:(NSString *)detailStr
                             btnTitleStr:(NSString *)btnTitleStr
                           btnClickBlock:(KLTapActionBlock)btnClickBlock;




/**
 构造方法 - 创建一个自定义的emptyView
 
 @param customView 自定义view
 @return 返回一个自定义内容的emptyView
 */
+ (instancetype)emptyViewWithCustomView:(UIView *)customView;



@end

NS_ASSUME_NONNULL_END
