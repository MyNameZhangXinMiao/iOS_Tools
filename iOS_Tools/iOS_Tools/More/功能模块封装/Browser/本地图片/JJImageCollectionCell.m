//
//  JJImageCollectionCell.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/6.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJImageCollectionCell.h"
#import "JJImageModel.h"


@interface JJImageCollectionCell ()


@property (nonatomic, strong) UIImageView *imgView;

@end
@implementation JJImageCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
        
    }
    return self;
}

#pragma mark - 初始化界面
- (void)setupUI{
    
    self.imgView.frame = self.bounds;
    [self.contentView addSubview:self.imgView];
    
    
}


- (void)setImageModel:(JJImageModel *)imageModel{
    _imageModel = imageModel;
        
    self.imgView.image = [UIImage imageNamed:_imageModel.imageName];
}

- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        
    }
    return _imgView;
}

@end
