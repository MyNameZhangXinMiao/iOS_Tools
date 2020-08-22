//
//  UIView+KLEmptyView.m
//  KLSocial
//
//  Created by 播呗网络 on 2019/7/9.
//  Copyright © 2019 播呗网络. All rights reserved.
//

#import "UIView+KLEmptyView.h"

#import <objc/runtime.h>
#import "KLEmptyView.h"


static char KEmptyViewKey;
@implementation UIView (KLEmptyView)


+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

#pragma mark - Setter/Getter


- (void)setKl_emptyView:(KLEmptyView *)kl_emptyView{
    if (kl_emptyView != self.kl_emptyView) {
        
        objc_setAssociatedObject(self, &KEmptyViewKey, kl_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[KLEmptyView class]]) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.kl_emptyView];
        self.kl_emptyView.hidden = YES;//添加时默认隐藏
    }
}
- (KLEmptyView *)kl_emptyView{
    return  objc_getAssociatedObject(self, &KEmptyViewKey);
}

#pragma mark - Private Method (UITableView、UICollectionView有效)
- (NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

- (void)getDataAndSet{
        //没有设置emptyView的，直接返回
    if (!self.kl_emptyView) {
        return;
    }
    
    if ([self totalDataCount] == 0) {
        [self show];
    }else{
        [self hide];
    }
}

- (void)show{
    //当不自动显隐时，内部自动调用show方法时也不要去显示，要显示的话只有手动去调用 kl_showEmptyView
    if (!self.kl_emptyView.autoShowEmptyView) {
        self.kl_emptyView.hidden = YES;
        return;
    }
    [self kl_showEmptyView];
}

- (void)hide{
    if (!self.kl_emptyView.autoShowEmptyView) {
        self.kl_emptyView.hidden = YES;
        return;
    }
    
    [self kl_hideEmptyView];
}

#pragma mark - Public Method
- (void)kl_showEmptyView{
    NSAssert(![self isKindOfClass:[KLEmptyView class]], @"KLEmptyView及其子类不能调用kl_showEmptyView方法");
    [self.kl_emptyView.superview layoutSubviews];
    self.kl_emptyView.hidden = NO;
    
    //让 emptyBGView 始终保持在最上层
    [self bringSubviewToFront:self.kl_emptyView];
}
- (void)kl_hideEmptyView{
    NSAssert(![self isKindOfClass:[KLEmptyView class]], @"KLEmptyView及其子类不能调用kl_hideEmptyView方法");
    self.kl_emptyView.hidden = YES;
}

- (void)kl_startLoading{
    NSAssert(![self isKindOfClass:[KLEmptyView class]], @"KLEmptyView及其子类不能调用kl_startLoading方法");
    self.kl_emptyView.hidden = YES;
}
- (void)kl_endLoading{
    NSAssert(![self isKindOfClass:[KLEmptyView class]], @"KLEmptyView及其子类不能调用kl_endLoading方法");
    self.kl_emptyView.hidden = [self totalDataCount];
}

- (void)kl_setupEmptyViewContentViewOffset:(CGFloat)offset{

    self.kl_emptyView.contentViewOffset = offset;
    
}


@end

#pragma mark - ------------------ UITableView ------------------

@implementation UITableView (Empty)
+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(kl_reloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:) method2:@selector(kl_insertSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:) method2:@selector(kl_deleteSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:withRowAnimation:) method2:@selector(kl_reloadSections:withRowAnimation:)];
    
    ///row
    [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:withRowAnimation:) method2:@selector(kl_insertRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:withRowAnimation:) method2:@selector(kl_deleteRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadRowsAtIndexPaths:withRowAnimation:) method2:@selector(kl_reloadRowsAtIndexPaths:withRowAnimation:)];
}

- (void)kl_reloadData{
    [self kl_reloadData];
    [self getDataAndSet];
}

///section
- (void)kl_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self kl_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

- (void)kl_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self kl_deleteSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

- (void)kl_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self kl_reloadSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

///row
- (void)kl_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self kl_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}

- (void)kl_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self kl_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}

- (void)kl_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self kl_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}


@end

#pragma mark - ------------------ UICollectionView ------------------

@implementation UICollectionView (Empty)

+ (void)load{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(kl_reloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:) method2:@selector(kl_insertSections:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:) method2:@selector(kl_deleteSections:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:) method2:@selector(kl_reloadSections:)];
    
    ///item
    [self exchangeInstanceMethod1:@selector(insertItemsAtIndexPaths:) method2:@selector(kl_insertItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(deleteItemsAtIndexPaths:) method2:@selector(kl_deleteItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(reloadItemsAtIndexPaths:) method2:@selector(kl_reloadItemsAtIndexPaths:)];
}

- (void)kl_reloadData{
    [self kl_reloadData];
    [self getDataAndSet];
}
    ///section
- (void)kl_insertSections:(NSIndexSet *)sections{
    [self kl_insertSections:sections];
    [self getDataAndSet];
}
- (void)kl_deleteSections:(NSIndexSet *)sections{
    [self kl_deleteSections:sections];
    [self getDataAndSet];
}
- (void)kl_reloadSections:(NSIndexSet *)sections{
    [self kl_reloadSections:sections];
    [self getDataAndSet];
}

///item
- (void)kl_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self kl_insertItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

- (void)kl_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self kl_deleteItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

- (void)kl_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self kl_reloadItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

@end


