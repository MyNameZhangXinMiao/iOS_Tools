//
//  JJMsgSystemViewController.h
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJBaseViewController.h"
#import "JXCategoryListContainerView.h"



NS_ASSUME_NONNULL_BEGIN

@interface JJMsgSystemViewController : JJBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@end

NS_ASSUME_NONNULL_END
