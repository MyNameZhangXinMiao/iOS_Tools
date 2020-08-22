//
//  KLVideoCollectionCell.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "KLVideoCollectionCell.h"



@interface KLVideoCollectionCell ()

@property (nonatomic, strong) UIImageView *bgImgView;
@end
@implementation KLVideoCollectionCell

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
    [self addSubview:self.bgImgView];
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)viewDidDisAppear
{
    
    
}
- (void)setVideoModel:(KLVideoModel *)videoModel{
    _videoModel = videoModel;
    self.bgImgView.image = [UIImage imageNamed:_videoModel.imageUrl];
}


- (UIImageView *)bgImgView{
    if (_bgImgView == nil) {
        _bgImgView = [[UIImageView alloc] init];
    }
    return _bgImgView;
}


@end
