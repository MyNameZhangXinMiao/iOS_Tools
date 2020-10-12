//
//  JJTestViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/10/12.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJTestViewController.h"
#import "JJTestImage.h"

@interface JJTestViewController ()

@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;

@end

@implementation JJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"测试";
    
    
    
    self.imgView1.frame = CGRectMake(100, 100, 18, 18);
    self.imgView2.frame = CGRectMake(100, 250, 18, 18);

    [self.view addSubview:self.imgView1];
    [self.view addSubview:self.imgView2];
    
    UIImage *img1 = [JJTestImage drawText:@"1" forImage:[UIImage imageNamed:@"messagelist_number_icon"]];
    self.imgView1.image = img1;
    UIImage *img2 = [JJTestImage drawText1:@"3" text2:@"2" forImage:[UIImage imageNamed:@"messagelist_number_icon"]];
    self.imgView2.image = img2;

}

 



- (UIImageView *)imgView1{
    if (_imgView1 == nil) {
        _imgView1 = [[UIImageView alloc] init];
    }
    return _imgView1;
}

- (UIImageView *)imgView2{
    if (_imgView2 == nil) {
        _imgView2 = [[UIImageView alloc] init];
    }
    return _imgView2;
}


@end
