//
//  JJGreenView.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2021/4/27.
//  Copyright © 2021 播呗网络. All rights reserved.
//

#import "JJGreenView.h"


@interface JJGreenView ()


@property (nonatomic, strong) UIButton *button;


@end
@implementation JJGreenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(30, 30, 80, 50);
        self.button.backgroundColor = [UIColor blueColor];
        [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        
    }
    return self;
}


- (void)buttonClick:(UIButton *)button{
    
    [_btnClickSignal sendNext:@"我可以代替代理方法呀"];
    
}

- (RACSubject *)btnClickSignal{
    if (!_btnClickSignal) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}



@end
