//
//  JJImageBrowser.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/6.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class JJImageModel;
@interface JJImageBrowser : JJBaseViewController

- (instancetype)initWithPresentVC:(UIViewController *)presentVC withData:(NSArray <JJImageModel *>*)images;


- (void)showWith:(NSInteger)index;



@end

NS_ASSUME_NONNULL_END
