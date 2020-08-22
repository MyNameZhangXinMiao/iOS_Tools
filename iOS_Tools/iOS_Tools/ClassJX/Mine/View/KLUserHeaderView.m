//
//  KLUserHeaderView.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "KLUserHeaderView.h"


@interface KLUserHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, assign) CGRect imageViewFrame;

@end
@implementation KLUserHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei.jpg"]];
        self.imageView.clipsToBounds = YES;
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];

        self.imageViewFrame = self.imageView.frame;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 30, 200, 30)];
        label.font = [UIFont systemFontOfSize:20];
        label.text = @"Monkey·D·路飞";
        label.textColor = [UIColor redColor];
        [self addSubview:label];
    }
    return self;
}

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    CGRect frame = self.imageViewFrame;
    frame.size.height -= contentOffsetY;
    frame.origin.y = contentOffsetY;
    self.imageView.frame = frame;
}


@end
