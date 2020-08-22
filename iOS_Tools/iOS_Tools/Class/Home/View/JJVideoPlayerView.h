//
//  JJVIdeoPlayerView.h
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/19.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TXVodPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJVideoPlayerView : UIView

@property (nonatomic, strong) TXVodPlayer *player;

- (int)playerURLStr:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
