//
//  JJImageBrowserCell.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/6.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JJImageModel;

typedef void (^TapImageActionBlock)(void);

@interface JJImageBrowserCell : UICollectionViewCell

@property (nonatomic, strong) JJImageModel *imageModel;

@property(nonatomic ,copy) TapImageActionBlock tapImageActionBlock;


@end

NS_ASSUME_NONNULL_END
