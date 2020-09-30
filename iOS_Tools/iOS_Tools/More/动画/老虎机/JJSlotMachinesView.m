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
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
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

- (void)setDataSource:(id<JJSlotMachinesViewDataSource>)dataSource{
    _dataSource = dataSource;
    [self reloadData];
}

- (void)reloadData{
    for (CALayer *containerLayer in _contentView.layer.sublayers) {
        [containerLayer removeFromSuperlayer];
    }
    _slotScrollLayerArray = [NSMutableArray array];
    
    NSUInteger numberOfSlots = [self.dataSource numberOfSlotsInSlotMachine:self];
    CGFloat slotSpacing = 4;  //间隙
    
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
            
            int ee = abs(j);
            int dd = abs(j) % iconCount;
            
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

/// <#Description#>
- (void)startSliding{
    if (_isSliding) {
        return;
    }
    
    _isSliding = YES;
    //开始动画
    if ([self.delegate respondsToSelector:@selector(jj_slotMachinesViewWillStartSliding:)]) {
        [self.delegate jj_slotMachinesViewWillStartSliding:self];
    }
    
    NSArray *slotIcons = [self.dataSource iconsForSlotsInSlotMachine:self];
    NSUInteger slotIconsCount = [slotIcons count];
    
    __block NSMutableArray *completePositionArray = [NSMutableArray array];
    
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:^{
        self.isSliding = NO;
        NSLog(@"动画结束");
        if ([self.delegate respondsToSelector:@selector(jj_slotMachinesViewDidEndSliding:)]) {
            [self.delegate jj_slotMachinesViewDidEndSliding:self];
        }
        
        for (int i = 0; i < [self.slotScrollLayerArray count]; i++) {
            CALayer *slotScrollLayer = [self.slotScrollLayerArray objectAtIndex:i];
            
            slotScrollLayer.position = CGPointMake(slotScrollLayer.position.x, ((NSNumber *)[completePositionArray objectAtIndex:i]).floatValue);
            
            NSMutableArray *toBeDeletedLayerArray = [NSMutableArray array];
            
            NSUInteger resultIndex = [[self.slotResults objectAtIndex:i] unsignedIntegerValue];
            NSUInteger currentIndex = [[self.currentSlotResults objectAtIndex:i] unsignedIntegerValue];
            
            for (int j = 0; j < slotIconsCount * (kMinTurn + i) + resultIndex - currentIndex; j++) {
                CALayer *iconLayer = [slotScrollLayer.sublayers objectAtIndex:j];
                [toBeDeletedLayerArray addObject:iconLayer];
            }
            
            for (CALayer *toBeDeletedLayer in toBeDeletedLayerArray) {
                // use initWithLayer does not work
                CALayer *toBeAddedLayer = [CALayer layer];
                toBeAddedLayer.frame = toBeDeletedLayer.frame;
                toBeAddedLayer.contents = toBeDeletedLayer.contents;
                toBeAddedLayer.contentsScale = toBeDeletedLayer.contentsScale;
                toBeAddedLayer.contentsGravity = toBeDeletedLayer.contentsGravity;
                
                CGFloat shiftY = slotIconsCount * toBeAddedLayer.frame.size.height * (kMinTurn + i + 3);
                toBeAddedLayer.position = CGPointMake(toBeAddedLayer.position.x, toBeAddedLayer.position.y - shiftY);
                
                [toBeDeletedLayer removeFromSuperlayer];
                [slotScrollLayer addSublayer:toBeAddedLayer];
            }
            toBeDeletedLayerArray = [NSMutableArray array];
        }
        
        self.currentSlotResults = self.slotResults;
        completePositionArray = [NSMutableArray array];
        
        NSString *str = @"";
        for (NSNumber *value in self.slotResults) {
            str = [str stringByAppendingString:value.description];
        }
    }];
    
    static NSString * const keyPath = @"position.y";
    
    for (int i = 0; i < [_slotScrollLayerArray count]; i++) {
        CALayer *slotScrollLayer = [_slotScrollLayerArray objectAtIndex:i];
        
        NSUInteger resultIndex = [[self.slotResults objectAtIndex:i] unsignedIntegerValue];
        NSUInteger currentIndex = [[_currentSlotResults objectAtIndex:i] unsignedIntegerValue];
        
        NSUInteger howManyUnit = (i + kMinTurn) * slotIconsCount + resultIndex - currentIndex;
        CGFloat slideY = howManyUnit * (_contentView.frame.size.height / 3);
        
        CABasicAnimation *slideAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
        //NSLog(@"%@",slideAnimation.keyPath);
        slideAnimation.fillMode = kCAFillModeForwards;
        slideAnimation.duration = howManyUnit * self.singleUnitDuration;
        slideAnimation.toValue = [NSNumber numberWithFloat:slotScrollLayer.position.y + slideY ];
        NSLog(@"slotScrollLayer.position.y + slideY~%f",slotScrollLayer.position.y + slideY);
        slideAnimation.removedOnCompletion = NO;
        //slideAnimation.repeatDuration = 1;
        [slotScrollLayer addAnimation:slideAnimation forKey:@"slideAnimation"];
        //NSLog(@"%@",slotScrollLayer.animationKeys);
        [completePositionArray addObject:slideAnimation.toValue];
    }
    [CATransaction commit];
    
}


@end
