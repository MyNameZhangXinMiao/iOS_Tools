//
//  JJPhotoBrowserFlowLayout.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/6.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJPhotoBrowserFlowLayout.h"



@interface JJPhotoBrowserFlowLayout ()

@property (nonatomic, assign)   CGFloat pageWidth;

@property (nonatomic, assign)   CGFloat lastPage;

@property (nonatomic, assign)   CGFloat minPage;

@property (nonatomic, assign)   CGFloat maxPage;
@end

@implementation JJPhotoBrowserFlowLayout



- (CGFloat)pageWidth{
    return self.itemSize.width + self.minimumLineSpacing;
}

- (CGFloat)lastPage{
    return self.collectionView.contentOffset.x / self.pageWidth;
}

- (CGFloat)minPage{
    return 0;
}

- (CGFloat)maxPage{
    CGFloat contentWidth = self.collectionView.contentSize.width + self.minimumLineSpacing;;
    return contentWidth / self.pageWidth - 1;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //页码
    int page = round(proposedContentOffset.x / self.pageWidth);
    
    // 处理轻微滑动
    if (velocity.x > 0.2) {
        page += 1;
    }else if (velocity.x > 0.2) {
        page -= 1;
    }
    
    // 一次滑动不允许超过一页
    if (page > self.lastPage+1) {
        page = self.lastPage + 1;
    }else if (page < self.lastPage - 1){
        page = self.lastPage - 1;
    }
    
    if (page > self.maxPage) {
        page = self.maxPage;
    }else if (page < self.minPage){
        page = self.minPage;
    }
    self.lastPage = page;
    
    return CGPointMake(page * self.pageWidth, 0);
}

@end
