//
//  KLVideoCollectionCell.h
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLVideoCollectionCell : UICollectionViewCell


@property (nonatomic, strong) KLVideoModel *videoModel;

- (void)viewDidDisAppear;

@end

NS_ASSUME_NONNULL_END
