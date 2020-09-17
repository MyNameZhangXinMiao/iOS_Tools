//
//  JJMoreScrollViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/17.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJMoreScrollViewController.h"

@interface JJMoreScrollViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation JJMoreScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

#pragma mark - 初始化界面
- (void)setupUI{
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.leftView];
    [self.scrollView addSubview:self.rightView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 50, kScreenWidth-80, 50) collectionViewLayout:flowLayout];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView.layer.borderWidth = 1;
    _collectionView.layer.borderColor = [UIColor blackColor].CGColor;

    _collectionView.showsHorizontalScrollIndicator = YES;
    _collectionView.bounces = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.rightView addSubview:_collectionView];
    
}


- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor blueColor];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIView *)leftView{
    if (_leftView == nil) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _leftView.backgroundColor = [UIColor redColor];
    }
    return _leftView;
}
- (UIView *)rightView{
    if (_rightView == nil) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        _rightView.backgroundColor = [UIColor whiteColor];
    }
    return _rightView;
}
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeMake(40, 40);
}

@end
