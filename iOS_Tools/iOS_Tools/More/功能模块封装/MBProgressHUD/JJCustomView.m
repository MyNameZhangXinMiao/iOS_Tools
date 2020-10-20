//
//  JJCustomView.m
//  MBProgress
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JJCustomView.h"

@implementation JJCustomView

- (CGSize)intrinsicContentSize {
    return CGSizeMake(36.f, 36.f);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  重写初始化方法,修改图片大小,将自动调整转换为约束
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}


@end
