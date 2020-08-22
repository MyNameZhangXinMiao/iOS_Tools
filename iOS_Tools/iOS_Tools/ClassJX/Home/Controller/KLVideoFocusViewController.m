//
//  KLVideoFocusViewController.m
//  Douyin_oc
//
//  Created by 播呗网络 on 2020/7/18.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "KLVideoFocusViewController.h"

@interface KLVideoFocusViewController ()

//@property (nonatomic, strong) KLVideoPlayerView *playView;

@end

@implementation KLVideoFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];

//    self.playView = [[KLVideoPlayerView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight/2)];
//    [self.view addSubview:self.playView];
//    self.playView.backgroundColor = [UIColor whiteColor];
//    [self.playView playerURLStr:@"https://dh2.v.netease.com/2017/cg/fxtpty.mp4"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIView *)listView {
    return self.view;
}

@end
