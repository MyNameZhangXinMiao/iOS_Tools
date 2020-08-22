//
//  KLVideoCollectionView.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "KLVideoCollectionView.h"
#import "KLVideoCollectionCell.h"


@interface KLVideoCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak)   KLVideoCollectionCell *currentCell;

@end
@implementation KLVideoCollectionView

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
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


- (void)setAttentionList:(NSArray<KLVideoModel *> *)attentionList
{
    if (!CGPointEqualToPoint(self.collectionView.contentOffset, CGPointZero)) {
        [self.collectionView setContentOffset:CGPointZero];
    };
    _attentionList = attentionList;
    [self.collectionView reloadData];
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.attentionList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KLVideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KLVideoCollectionCell" forIndexPath:indexPath];
    cell.videoModel = self.attentionList[indexPath.item];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didselected) {
        self.didselected(self.attentionList[indexPath.item]);
    }
}


#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollEndUpdateVideo];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollEndUpdateVideo];
}
- (void)scrollEndUpdateVideo
{
    CGFloat offsetY = self.collectionView.contentOffset.y;
    NSInteger index = ceilf(offsetY / self.collectionView.bounds.size.height);
    if (index >= [self.collectionView numberOfItemsInSection:0]) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    KLVideoCollectionCell *cell = (KLVideoCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    if ([_delegate respondsToSelector:@selector(KLVideoCollectionView:scrollEndCell:index:)]) {
        [_delegate KLVideoCollectionView:self scrollEndCell:cell index:indexPath];
    }
    _currentCell = cell;
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(KLVideoCollectionView:didEndDisplayingCell:index:)]) {
        [_delegate KLVideoCollectionView:self didEndDisplayingCell:(KLVideoCollectionCell *)cell index:indexPath];
    }
    
    [((KLVideoCollectionCell*)cell) viewDidDisAppear];
}




- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight-50-kTabBarHeight-kNavBarHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        [_collectionView registerClass:[KLVideoCollectionCell class] forCellWithReuseIdentifier:@"KLVideoCollectionCell"];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}



@end

