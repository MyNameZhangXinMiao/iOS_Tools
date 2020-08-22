//
//  UIView+JJEmptyView.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/8/23.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "UIView+JJEmptyView.h"
#import <objc/runtime.h>


@interface UIView ()

/// 记录scrollView最初的scrollEnabled
@property (nonatomic, assign)   BOOL jj_scrollEnabled;


@end
@implementation UIView (JJEmptyView)

static void *placeholderViewKey = &placeholderViewKey;
static void *isHidePlaceholderViewCilckButton = &isHidePlaceholderViewCilckButton;
static void *jj_scrollEnabled = &jj_scrollEnabled;

- (UIView *)jj_placeholderView{
    return objc_getAssociatedObject(self, &placeholderViewKey);
}

- (void)setJj_placeholderView:(UIView *)jj_placeholderView{
    objc_setAssociatedObject(self, &placeholderViewKey, jj_placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)jj_scrollEnabled{
    return [objc_getAssociatedObject(self, &jj_scrollEnabled) boolValue];
}

- (void)setJj_scrollEnabled:(BOOL)jj_scrollEnabled{
    objc_setAssociatedObject(self, &jj_scrollEnabled, @(jj_scrollEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isHidePlaceholderViewCilckButton{
    return [objc_getAssociatedObject(self, &isHidePlaceholderViewCilckButton) boolValue];
}

- (void)setIsHidePlaceholderViewCilckButton:(BOOL)isHidePlaceholderViewCilckButton{
    objc_setAssociatedObject(self, &isHidePlaceholderViewCilckButton, @(isHidePlaceholderViewCilckButton), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 展示占位图
- (void)jj_showPlaceholderViewWithType:(JJPlaceholderViewType)type clickBlock:(void(^)(NSInteger index))clickBlock{
    //如果是UIScrollView及其子类,占位图展示期间禁止滚动
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        //先记录选来的scrollEnabled
        self.jj_scrollEnabled = scrollView.scrollEnabled;
        //在将scrollView滚动关闭
        scrollView.scrollEnabled = NO;
    }
    
    if (!self.isHidePlaceholderViewCilckButton) {
        if (self.jj_placeholderView) {
            [self.jj_placeholderView removeFromSuperview];
            self.jj_placeholderView = nil;
        }
    }

    self.jj_placeholderView = [[UIView alloc] init];
    [self addSubview:self.jj_placeholderView];
    self.jj_placeholderView.backgroundColor = [UIColor whiteColor];
    [self.jj_placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(self);
    }];
    //------- 图标 -------//
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.jj_placeholderView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.superview);
        make.centerY.mas_equalTo(imageView.superview).mas_offset(-80);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    //------- 描述 -------//
    UILabel *descLabel = [[UILabel alloc] init];
    [self.jj_placeholderView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(descLabel.superview);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(15);
    }];
    
    //------- button -------//
    UIButton *rightButton = [[UIButton alloc] init];
    [self.jj_placeholderView addSubview:rightButton];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"重新加载" forState:UIControlStateNormal];
    rightButton.layer.borderWidth = 1;
    rightButton.layer.borderColor = [UIColor blackColor].CGColor;
    @weakify(self);
    [rightButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(self);
        // 执行block回调
        if (clickBlock) {
            clickBlock(1);
        }
        // 从父视图移除
        [self.jj_placeholderView removeFromSuperview];
        self.jj_placeholderView = nil;
        // 复原UIScrollView的scrollEnabled
        if ([self isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)self;
            scrollView.scrollEnabled = self.jj_scrollEnabled;
        }
    }];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(rightButton.superview);
        make.top.mas_equalTo(descLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(120);
    }];
    
    UIButton *leftButton = [[UIButton alloc] init];
    [self.jj_placeholderView addSubview:leftButton];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    leftButton.layer.borderWidth = 1;
    leftButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    switch (type) {
        case JJPlaceholderViewTypeNoNetwork:
        {
            imageView.image = [UIImage imageNamed:@"kong_network"];
            descLabel.text = @"网络异常";
        }
            break;
        case JJPlaceholderViewTypeNoData:
        {
            imageView.image = [UIImage imageNamed:@"kong_no_content"];
            descLabel.text = @"没有数据请重试";
        }
            break;
        case JJPlaceholderViewTypeError:
        {
            imageView.image = [UIImage imageNamed:@"kong_server"];
            descLabel.text = @"请求失败";
        }
            break;
        case JJPlaceholderViewTypeNoLocation:
        {
            [rightButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(rightButton.superview).mas_offset(65);
            }];
            
            [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(rightButton.superview).mas_offset(-65);
                make.top.mas_equalTo(descLabel.mas_bottom).mas_offset(20);
                make.size.mas_equalTo(CGSizeMake(120, 30));
            }];
            
            imageView.image = [UIImage imageNamed:@"kong_positioning"];
            descLabel.text = @"没有地理位置";
            [rightButton setTitle:@"重新获取位置" forState:UIControlStateNormal];

        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
    
}

- (void)jj_removePlaceholderView{
    
}


@end
