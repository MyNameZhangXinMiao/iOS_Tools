//
//  KLVideoCollectionView.h
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLVideoModel.h"


NS_ASSUME_NONNULL_BEGIN
@class KLVideoCollectionCell;
@class KLVideoCollectionView;
@protocol KLVideoCollectionViewDelegate <NSObject>

- (void)KLVideoCollectionView:(KLVideoCollectionView *)collectionView
         didEndDisplayingCell:(KLVideoCollectionCell*)cell
                        index:(NSIndexPath *)index;
- (void)KLVideoCollectionView:(KLVideoCollectionView *)collectionView
                scrollEndCell:(KLVideoCollectionCell*)cell
                        index:(NSIndexPath *)index;

@end

//if ([self.delegate respondsToSelector:@selector(KLVideoCollectionView)]) {
//    [self.delegate KLVideoCollectionView];
//}
@interface KLVideoCollectionView : UIView

@property (nonatomic, weak)  id<KLVideoCollectionViewDelegate > delegate;

@property (nonatomic, strong) NSArray <KLVideoModel*>*attentionList;

@property (nonatomic, copy) void(^didselected)(KLVideoModel* model);

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
