//
//  JJSlotMachinesView.m
//  iOS_Tools
//
//  Created by zhouxuanhe on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJSlotMachinesView.h"

#define kMinTurn 6


@interface JJSlotMachinesView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSMutableArray *slotScrollLayerArray;

@property (nonatomic, strong) NSArray *currentSlotResults;

@property (nonatomic, assign)   BOOL isSliding;


@end

@implementation JJSlotMachinesView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUIWith:frame];
    }
    return self;
}


#pragma mark - 初始化界面
- (void)setupUIWith:(CGRect)frame
{
    _contentView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:_contentView];
    
    _slotScrollLayerArray = [NSMutableArray array];
    
    self.singleUnitDuration = 0.14f;
    
}

- (void)setSlotResults:(NSArray *)slotResults {
    if (!_isSliding) {
        _slotResults = slotResults;
        
        if (!_currentSlotResults) {
            NSMutableArray *currentSlotResults = [NSMutableArray array];
            for (int i = 0; i < [slotResults count]; i++) {
                [currentSlotResults addObject:[NSNumber numberWithUnsignedInteger:0]];
            }
            _currentSlotResults = [NSArray arrayWithArray:currentSlotResults];
        }
    }
}


- (void)reloadData{
    for (CALayer *containerLayer in _contentView.layer.sublayers) {
        [containerLayer removeFromSuperlayer];
    }
    _slotScrollLayerArray = [NSMutableArray array];
    
    NSUInteger numberOfSlots = [self.dataSource numberOfSlotsInSlotMachine:self];
    CGFloat slotSpacing = 0;  //间隙
    
    //item宽度
    CGFloat slotWidth = _contentView.frame.size.width / numberOfSlots;
    
    
    for (int i = 0; i < numberOfSlots; i++) {
        CALayer *slotContainerLayer = [[CALayer alloc] init];
        slotContainerLayer.frame = CGRectMake(i * (slotWidth + slotSpacing), 0, slotWidth, _contentView.frame.size.height);
        slotContainerLayer.masksToBounds = YES;
        
        CALayer *slotScrollLayer = [[CALayer alloc] init];
        slotScrollLayer.frame = CGRectMake(0, 0, slotWidth, _contentView.frame.size.height);
        
        [slotContainerLayer addSublayer:slotScrollLayer];
        
        [_contentView.layer addSublayer:slotContainerLayer];
        
        [_slotScrollLayerArray addObject:slotScrollLayer];
    }
    
    CGFloat singleUnitHeight = _contentView.frame.size.height / 3;
    
    NSArray *slotIcons = [self.dataSource iconsForSlotsInSlotMachine:self];
    NSUInteger iconCount = [slotIcons count];
    
    for (int i = 0; i < numberOfSlots; i++) {
        CALayer *slotScrollLayer = [_slotScrollLayerArray objectAtIndex:i];
        NSInteger scrollLayerTopIndex = - (i + kMinTurn + 3) * iconCount;
        
        for (int j = 0; j > scrollLayerTopIndex; j--) {
            UIImage *iconImage = [slotIcons objectAtIndex:abs(j) % iconCount];
            
            CALayer *iconImageLayer = [[CALayer alloc] init];
            // adjust the beginning offset of the first unit
            NSInteger offsetYUnit = j + 1 + iconCount;
            iconImageLayer.frame = CGRectMake(0, offsetYUnit * singleUnitHeight, slotScrollLayer.frame.size.width, singleUnitHeight);
            
            iconImageLayer.contents = (id)iconImage.CGImage;
            iconImageLayer.contentsScale = iconImage.scale;
            iconImageLayer.contentsGravity = kCAGravityCenter;
            
            [slotScrollLayer addSublayer:iconImageLayer];
        }
    }
    
}

- (void)startSliding{
    if (_isSliding) {
        return;
    }
    
    _isSliding = YES;
    //开始动画
    if ([self.delegate respondsToSelector:@selector(jj_slotMachinesViewWillStartSliding:)]) {
        [self.delegate jj_slotMachinesViewWillStartSliding:self];
    }
    
    
    
    
    
    
}


@end
