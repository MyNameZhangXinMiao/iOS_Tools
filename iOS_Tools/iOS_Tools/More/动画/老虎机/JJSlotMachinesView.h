//
//  JJSlotMachinesView.h
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JJSlotMachinesView;
@protocol JJSlotMachinesViewDelegate <NSObject>


@optional
//将要开始滚动
- (void)jj_slotMachinesViewWillStartSliding:(JJSlotMachinesView *)slotMachine;
//滚动结束
- (void)jj_slotMachinesViewDidEndSliding:(JJSlotMachinesView *)slotMachine;

@end


@protocol JJSlotMachinesViewDataSource <NSObject>

@required
- (NSUInteger)numberOfSlotsInSlotMachine:(JJSlotMachinesView *)slotMachine;
- (NSArray *)iconsForSlotsInSlotMachine:(JJSlotMachinesView *)slotMachine;

@end



@interface JJSlotMachinesView : UIView

@property(nonatomic,weak)  id<JJSlotMachinesViewDelegate > delegate;
@property(nonatomic,weak)  id<JJSlotMachinesViewDataSource > dataSource;


@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic, strong) NSArray *slotResults;
@property (nonatomic) CGFloat singleUnitDuration;


- (void)startSliding;


@end

NS_ASSUME_NONNULL_END
