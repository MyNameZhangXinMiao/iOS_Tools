//
//  JJAutoRunView.h
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/7.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JJAutoRunView;


typedef NS_ENUM(NSInteger, RunDirectionType) {
    LeftType = 0,
    RightType = 1,
};

@protocol JJAutoRunViewDelegate <NSObject>

@optional
- (void)operateLabel:(JJAutoRunView *)autoLabel animationDidStopFinished:(BOOL)finished;

@end

@interface JJAutoRunView : UIView


@property (nonatomic, weak) id <JJAutoRunViewDelegate> delegate;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) RunDirectionType directionType;

- (void)addContentView: (UIView *)view;
- (void)startAnimation;
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
