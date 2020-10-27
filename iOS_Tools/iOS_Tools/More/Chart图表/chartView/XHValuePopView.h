//
//  XHValuePopView.h
//  XHSpiderView
//
//  Created by Leexin on 16/8/16.
//  Copyright © 2016年 Garden.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHValuePopView;
@protocol XHValuePopViewDelegate <NSObject>
@optional
- (void)valuePopViewDidHidden:(XHValuePopView *)popView;

@end

@interface XHValuePopView : UIView

@property (nonatomic, weak) id<XHValuePopViewDelegate> delegate;

- (instancetype)initWithStarePoint:(CGPoint)starePoint;
- (void)showInView:(UIView *)view titleString:(NSString *)string;
- (void)hiddenPopView;

@end
