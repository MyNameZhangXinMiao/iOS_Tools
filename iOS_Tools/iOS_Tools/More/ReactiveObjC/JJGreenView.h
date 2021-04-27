//
//  JJGreenView.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2021/4/27.
//  Copyright © 2021 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JJGreenView : UIView

@property (nonatomic, strong) RACSubject *btnClickSignal;

@end

NS_ASSUME_NONNULL_END
