//
//  JJLocalImageViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/6.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJLocalImageViewController.h"
#import "JJImageCollectionCell.h"
#import "JJImageBrowser.h"
#import "JJImageModel.h"


@interface JJLocalImageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) JJBaseNavigationView *navigationView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation JJLocalImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    

    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        JJImageModel *model = [[JJImageModel alloc] init];
        model.imageName = [NSString stringWithFormat:@"local_%d",i];
        [arr addObject:model];
    }
    self.datas = [NSArray arrayWithArray:arr];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kNavBarHeight);
    }];
    
    [self setupUI];
    
    
}


- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+10, kScreenWidth, 400) collectionViewLayout:layout];
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //确定item的大小
    layout.itemSize = CGSizeMake((KScreenWidth - 16 * 4) / 3, (KScreenWidth - 16 * 4) / 3);
    //确定横向间距
    layout.minimumLineSpacing = 10;
    //确定纵向间距
    layout.minimumInteritemSpacing = 0;
    //确定距离上左下右的距离
    layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    //头尾部高度
    layout.headerReferenceSize = CGSizeMake(0, 10);
    layout.footerReferenceSize = CGSizeMake(0, 10);
    
    //确定滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];

    [self.collectionView registerClass:[JJImageCollectionCell class] forCellWithReuseIdentifier:@"JJImageCollectionCell"];
    
}



#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JJImageCollectionCell" forIndexPath:indexPath];
    
    cell.imageModel = self.datas[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JJImageBrowser *vc = [[JJImageBrowser alloc] initWithPresentVC:self withData:self.datas];
    [vc showWith:indexPath.item];
}


- (JJBaseNavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[JJBaseNavigationView alloc] init];
        _navigationView.title = @"本地图片";
        @weakify(self);
        _navigationView.backBtnActionCallBack = ^{
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navigationView;
}
@end
