//
//  KLEmptyBaseView.m
//  KLSocial
//
//  Created by 播呗网络 on 2019/7/9.
//  Copyright © 2019 播呗网络. All rights reserved.
//

#import "KLEmptyBaseView.h"

@implementation KLEmptyBaseView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
        [self prepare];
    }
    return self;
}

- (void)initialize{
    
}

- (void)prepare{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIView *superView = self.superview;
    
    if (superView && [superView isKindOfClass:[UIView class]]) {
        self.frame = CGRectMake(0, 0, CGRectGetWidth(superView.bounds), CGRectGetHeight(superView.bounds));
    }
    
    [self setupSubviews];
}

- (void)setupSubviews{
    
}


- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview && ![newSuperview isKindOfClass:[UIView class]]) return;

    if (newSuperview) {
        self.frame = CGRectMake(0, 0, CGRectGetWidth(newSuperview.bounds), CGRectGetHeight(newSuperview.bounds));
    }
}


- (void)tapEmptyView:(UITapGestureRecognizer *)tap{
    if (_tapEmptyViewBlock) {
        _tapEmptyViewBlock();
    }
}


- (void)creatEmptyViewWithImage:(UIImage *)image
                       titleStr:(NSString *)titleStr
                      detailStr:(NSString *)detailStr
                    btnTitleStr:(NSString *)btnTitleStr
                  btnClickBlock:(KLTapActionBlock)btnClickBlock{
    
    _image = image;
    _titleStr = titleStr;
    _detailStr = detailStr;
    _btnTitleStr = btnTitleStr;
    _btnActionBlock = btnClickBlock;
    
        //内容物背景视图
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEmptyView:)];
    [self addGestureRecognizer:tap];
}



+ (instancetype)emptyViewWithImage:(UIImage *)image
                          titleStr:(NSString *)titleStr
                         detailStr:(NSString *)detailStr{
    KLEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:image titleStr:titleStr detailStr:detailStr btnTitleStr:nil btnClickBlock:nil];
    return emptyView;
}

+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                                titleStr:(NSString *)titleStr
                               detailStr:(NSString *)detailStr
                             btnTitleStr:(NSString *)btnTitleStr{
    KLEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:image titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr btnClickBlock:nil];
    return emptyView;
}


+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                                titleStr:(NSString *)titleStr
                               detailStr:(NSString *)detailStr
                             btnTitleStr:(NSString *)btnTitleStr
                           btnClickBlock:(KLTapActionBlock)btnClickBlock{
    KLEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithImage:image titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr btnClickBlock:btnClickBlock];
    return emptyView;
}


/**
 构造方法 - 创建一个自定义的emptyView
 
 @param customView 自定义view
 @return 返回一个自定义内容的emptyView
 */
+ (instancetype)emptyViewWithCustomView:(UIView *)customView{
    KLEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView creatEmptyViewWithCustomView:customView];
    return emptyView;
}

- (void)creatEmptyViewWithCustomView:(UIView *)customView{
    //内容物背景视图
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
    }
    
    if (!_customView) {
        [_contentView addSubview:customView];
    }
    _customView = customView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEmptyView:)];
    [self addGestureRecognizer:tap];
}



#pragma mark - setter

- (void)setImage:(UIImage *)image{
    _image = image;
    [self setNeedsLayout];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self setNeedsLayout];
}
- (void)setDetailStr:(NSString *)detailStr{
    _detailStr = detailStr;
    [self setNeedsLayout];
}
- (void)setBtnTitleStr:(NSString *)btnTitleStr{
    _btnTitleStr = btnTitleStr;
    [self setNeedsLayout];
}

@end
