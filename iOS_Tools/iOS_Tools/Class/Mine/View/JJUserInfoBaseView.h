//
//  JJUserInfoBaseView.h
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"



NS_ASSUME_NONNULL_BEGIN

@interface JJUserInfoBaseView : UIView<JXPagerViewListViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSString *> *dataSource;

@end

NS_ASSUME_NONNULL_END
