//
//  JJRedView.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2021/4/26.
//  Copyright © 2021 播呗网络. All rights reserved.
//

#import "JJRedView.h"


@interface JJRedView ()

@property (nonatomic, strong) UIButton *button;

@end
@implementation JJRedView

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
    
    NSLog(@"JJRedView ------- 点击事件");
    
    
}









@end
