//
//  KLVideoFollowViewController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/18.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "KLVideoFollowViewController.h"
#import "KLVideoCollectionView.h"


@interface KLVideoFollowViewController ()
<KLVideoCollectionViewDelegate
>

@property (nonatomic, strong) KLVideoCollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KLVideoFollowViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        KLVideoModel *model = [[KLVideoModel alloc] init];
        model.videoUrl = @"https://dh2.v.netease.com/2017/cg/fxtpty.mp4";
        model.imageUrl = @"lufei.jpg";
        [self.dataArray addObject:model];
    }
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.collectionView.attentionList = self.dataArray;
}


- (void)KLVideoCollectionView:(KLVideoCollectionView *)collectionView scrollEndCell:(KLVideoCollectionCell *)cell index:(NSIndexPath *)index{
    
}

- (void)KLVideoCollectionView:(KLVideoCollectionView *)collectionView didEndDisplayingCell:(KLVideoCollectionCell *)cell index:(NSIndexPath *)index{
    
    
    
}














- (KLVideoCollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[KLVideoCollectionView alloc] init];
        _collectionView.delegate = self;
    }
    return _collectionView;
}





#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end

