//
//  JJImageBrowserCell.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/6.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJImageBrowserCell.h"
#import "JJImageModel.h"



@interface JJImageBrowserCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGSize fitSize;

@property (nonatomic, assign) CGRect fitFrame;


@end
@implementation JJImageBrowserCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

#pragma mark - 初始化界面
- (void)setupUI{
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.bounds;
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 2;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
    
    self.imgView.clipsToBounds = YES;
    self.imgView.frame = self.bounds;
    [self.scrollView addSubview:self.imgView];
    
    [self setupTap];
}


- (void)setImageModel:(JJImageModel *)imageModel{
    _imageModel = imageModel;
    
    UIImage *image = [UIImage imageNamed:_imageModel.imageName];
    self.imgView.image = image;

    if (image) {
        [self doLayout];
        return;
    } else {
        [self doLayout];
        return;
    }
}

- (void)setupTap{
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction)];
    doubleTap.numberOfTapsRequired = 2;
    [self.imgView addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
    singleTap.numberOfTapsRequired = 1;
    [self.imgView addGestureRecognizer:singleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];

}

- (void)doubleTapAction{
    CGFloat scale = self.scrollView.maximumZoomScale;
    if (self.scrollView.zoomScale == self.scrollView.maximumZoomScale) {
        scale = 1;
    }
    [self.scrollView setZoomScale:scale animated:YES];
}
- (void)singleTapAction{
    CGFloat scale = self.scrollView.maximumZoomScale;
    if (self.scrollView.zoomScale == self.scrollView.maximumZoomScale) {
        scale = 1;
        [self.scrollView setZoomScale:scale animated:YES];
    }else{
        if (self.tapImageActionBlock) {
            self.tapImageActionBlock();
        }
    }
}

- (CGSize)fitSize{
    UIImage *image = self.imgView.image;
    if (image == nil) {
        return CGSizeZero;
    }
    CGFloat width = self.scrollView.bounds.size.width;
    CGFloat scale = image.size.height / image.size.width;
    return CGSizeMake(width , width * scale);
}

- (CGRect)fitFrame{
    CGSize size = self.fitSize;
    CGFloat y = (self.scrollView.bounds.size.height - size.height) > 0 ? (self.scrollView.bounds.size.height - size.height) * 0.5 : 0;
    return CGRectMake(0, y, size.width, size.height);
}

- (void)doLayout{
    self.scrollView.frame = self.bounds;
    [self.scrollView setZoomScale:1 animated:NO];
    _imgView.frame = self.fitFrame;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat xcenter = scrollView.center.x, ycenter = scrollView.center.y;
    xcenter = scrollView.contentSize.width> scrollView.frame.size.width? scrollView.contentSize.width/2: xcenter;
    ycenter = scrollView.contentSize.height> scrollView.frame.size.height? scrollView.contentSize.height/2: ycenter;
    
    self.imgView.center = CGPointMake(xcenter, ycenter);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imgView;
}

- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.userInteractionEnabled = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}



@end
