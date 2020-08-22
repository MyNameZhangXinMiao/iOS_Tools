//
//  KLEmptyView.h
//  KLSocial
//
//  Created by 播呗网络 on 2019/7/9.
//  Copyright © 2019 播呗网络. All rights reserved.
//

#import "KLEmptyBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLEmptyView : KLEmptyBaseView

/**
 是否自动显隐EmptyView default = YES
 */
@property (nonatomic,assign) BOOL autoShowEmptyView;

/**
 占位图是否完全覆盖俯视图 default = NO
 YES: 占位图的backgroundColor:白色  可设置
 */
@property (nonatomic,assign) BOOL emptyViewIsCompleteCoverSuperView;

/**
 每个子控件之间的间距 default is 20.f
 */
@property (nonatomic, assign) CGFloat  subViewsMargin;

/**
 内容物-垂直方向偏移 (此属性与contentViewY 互斥，只有一个会有效)
 */
@property (nonatomic, assign) CGFloat  contentViewOffset;

/**
 // TODO:暂时有问题 会修改x = 0
 内容物-Y坐标 (此属性与contentViewOffset 互斥，只有一个会有效)
 */
@property (nonatomic, assign) CGFloat  contentViewY;


/**
 是否忽略scrollView的contentInset
 */
@property (nonatomic, assign) BOOL ignoreContentInset;


#pragma mark - Image
/**
 图片可设置固定大小 (default=图片实际大小)
 */
@property (nonatomic, assign) CGSize   imageSize;


#pragma mark - titleLabel
/**
 标题字体, 大小default is 16.f
 */
@property (nonatomic, strong) UIFont   *titleLabFont;
/**
 标题文字颜色
 */
@property (nonatomic, strong) UIColor  *titleLabTextColor;


#pragma mark - detailLabel

/**
 详细描述字体，大小default is 14.f
 */
@property (nonatomic, strong) UIFont   *detailLabFont;
/**
 详细描述最大行数， default is 2
 */
@property (nonatomic, assign) NSInteger detailLabMaxLines;
/**
 详细描述文字颜色
 */
@property (nonatomic, strong) UIColor  *detailLabTextColor;


#pragma mark - detailLabel Button 
/**
 按钮字体, 大小default is 14.f
 */
@property (nonatomic, strong) UIFont  *actionBtnFont;
/**
 按钮的高度, default is 40.f
 */
@property (nonatomic, assign) CGFloat  actionBtnHeight;
/**
 按钮的宽度, default is 0.f, (此属性和actionBtnHorizontalMargin只有一个有效，都>0时，此属性优先级大)
 */
@property (nonatomic, assign) CGFloat  actionBtnWidth;
/**
 按钮的水平方向内边距, default is 30.f, (此属性和actionBtnWidth只有一个有效，都>0时，此属性优先级小)
 */
@property (nonatomic, assign) CGFloat  actionBtnHorizontalMargin;
/**
 按钮的圆角大小, default is 0
 */
@property (nonatomic, assign) CGFloat  actionBtnCornerRadius;
/**
 按钮边框border的宽度, default is 0
 */
@property (nonatomic, assign) CGFloat  actionBtnBorderWidth;
/**
 按钮边框颜色
 */
@property (nonatomic, strong) UIColor  *actionBtnBorderColor;
/**
 按钮文字颜色
 */
@property (nonatomic, strong) UIColor  *actionBtnTitleColor;
/**
 按钮背景颜色
 */
@property (nonatomic, strong) UIColor  *actionBtnBackGroundColor;




@end

NS_ASSUME_NONNULL_END
