//
//  JJVideoFollowViewController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/18.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJVideoFollowViewController.h"
#import "JJVideoCollectionView.h"


@interface JJVideoFollowViewController ()
<JJVideoCollectionViewDelegate
>

@property (nonatomic, strong) JJVideoCollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JJVideoFollowViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        JJVideoModel *model = [[JJVideoModel alloc] init];
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


- (void)JJVideoCollectionView:(JJVideoCollectionView *)collectionView scrollEndCell:(JJVideoCollectionCell *)cell index:(NSIndexPath *)index{
    
}

- (void)JJVideoCollectionView:(JJVideoCollectionView *)collectionView didEndDisplayingCell:(JJVideoCollectionCell *)cell index:(NSIndexPath *)index{
    
    
    
}














- (JJVideoCollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[JJVideoCollectionView alloc] init];
        _collectionView.delegate = self;
    }
    return _collectionView;
}





#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end

