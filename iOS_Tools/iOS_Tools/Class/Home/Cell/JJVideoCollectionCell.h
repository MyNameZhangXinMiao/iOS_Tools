//
//  JJVideoCollectionCell.h
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JJVideoCollectionCell : UICollectionViewCell


@property (nonatomic, strong) JJVideoModel *videoModel;

- (void)viewDidDisAppear;

@end

NS_ASSUME_NONNULL_END
