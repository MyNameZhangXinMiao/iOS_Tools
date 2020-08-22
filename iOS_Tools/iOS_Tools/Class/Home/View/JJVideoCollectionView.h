//
//  JJVideoCollectionView.h
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJVideoModel.h"


NS_ASSUME_NONNULL_BEGIN
@class JJVideoCollectionCell;
@class JJVideoCollectionView;
@protocol JJVideoCollectionViewDelegate <NSObject>

- (void)JJVideoCollectionView:(JJVideoCollectionView *)collectionView
         didEndDisplayingCell:(JJVideoCollectionCell*)cell
                        index:(NSIndexPath *)index;
- (void)JJVideoCollectionView:(JJVideoCollectionView *)collectionView
                scrollEndCell:(JJVideoCollectionCell*)cell
                        index:(NSIndexPath *)index;

@end

//if ([self.delegate respondsToSelector:@selector(JJVideoCollectionView)]) {
//    [self.delegate JJVideoCollectionView];
//}
@interface JJVideoCollectionView : UIView

@property (nonatomic, weak)  id<JJVideoCollectionViewDelegate > delegate;

@property (nonatomic, strong) NSArray <JJVideoModel*>*attentionList;

@property (nonatomic, copy) void(^didselected)(JJVideoModel* model);

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
