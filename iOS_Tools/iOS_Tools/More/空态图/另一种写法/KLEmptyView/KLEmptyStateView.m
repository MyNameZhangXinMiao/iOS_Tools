//
//  KLEmptyStateView.m
//  KLSocial
//
//  Created by 播呗网络 on 2019/7/9.
//  Copyright © 2019 播呗网络. All rights reserved.
//


#import "KLEmptyStateView.h"


@interface KLEmptyViewDataModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *btnTitle;

@end

@implementation KLEmptyViewDataModel

@end

@implementation KLEmptyStateView

- (void)prepare{
    [super prepare];
    
    self.contentViewOffset = -100;
    self.imageSize = CGSizeMake(128, 128);
    
    self.actionBtnCornerRadius = 10;
    self.actionBtnBackGroundColor = [UIColor clearColor];
    self.actionBtnWidth = 128;
    self.actionBtnBorderWidth = 1;
    self.actionBtnBorderColor = [UIColor colorWithHexString:@"0x9FA1A9"];
    self.actionBtnTitleColor = [UIColor colorWithHexString:@"0x9FA1A9"];
}


+ (KLEmptyStateView *)createEmptyViewWithStyle:(KLEmptyStateViewStyle)style
{
    KLEmptyViewDataModel *model = [self createModelWithStyle:style];

    KLEmptyStateView *view = [self emptyActionViewWithImage:[UIImage imageNamed:model.imageName] titleStr:model.title detailStr:model.detail btnTitleStr:model.btnTitle];
    return view;
}


- (void)changeEmptyViewStyle:(KLEmptyStateViewStyle)style{
    KLEmptyViewDataModel *model = [KLEmptyStateView createModelWithStyle:style];
    self.image = [UIImage imageNamed:model.imageName];
    self.titleStr = model.title;
    self.detailStr = model.detail;
    self.btnTitleStr = model.btnTitle;
}


- (void)clickBtnActionCompleteHandle:(void(^)(void))completeHandle{
    self.btnActionBlock = completeHandle;
}


- (void)tapViewActionCompleteHandle:(void(^)(void))completeHandle{
    self.tapEmptyViewBlock = completeHandle;
}


#pragma mark - Private Method

+ (KLEmptyViewDataModel *)createModelWithStyle:(KLEmptyStateViewStyle)style{
    KLEmptyViewDataModel *model = [[KLEmptyViewDataModel alloc] init];
    if (style == KLEmptyStateViewStyleNetworkFail) {
        model.imageName = @"kl_null_network";
        model.title = @"网络好像出问题了喔~";
        model.detail = @"";
        model.btnTitle = @"刷新";
        
    }else if(style == KLEmptyStateViewStyleNoData){
        model.imageName = @"kl_null_data";
        model.title = @"暂无数据~";
        model.detail = @"";
        model.btnTitle = @"";
        
    }else if (style == KLEmptyStateViewStyleLocationFail){
        model.imageName = @"kl_null_location";
        model.title = @"还未开启定位~";
        model.detail = @"";
        model.btnTitle = @"开启定位";
    }else{
        model.imageName = @"kl_null_network";
        model.title = @"";
        model.detail = @"";
        model.btnTitle = @"";
    }
    return model;
}

- (void)dealloc{
    NSLog(@"KL_EmtpyView - dealloc");
}
@end
