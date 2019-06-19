//
//  HoverViewFlowLayout.m
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import "HoverViewFlowLayout.h"

@implementation HoverViewFlowLayout

- (instancetype)initWithTopHeight:(CGFloat)height{
    self = [super init];
    if (self){
        self.topHeight = height;
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    // 获取当前在屏幕rect中显示的元素属性 挑出第一个section的header和footer
    // 修改frame 达到固定在头部的效果
    NSMutableArray<UICollectionViewLayoutAttributes *> *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];

    // header 和 footer 全部移除，后续单独处理
    for (UICollectionViewLayoutAttributes *attributes in [superArray mutableCopy]) {
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [superArray removeObject:attributes];
        }
    }

    // 单独添加上一步移除的Header和Footer，
    // 单独添加是因为第一步只能获取当前在屏幕rect中显示的元素属性，
    // 当第一个Sectioin移除屏幕便无法获取Header和Footer，
    // 这是需要单独添加Header和Footer以及第二部单独移除Header和Footer的原因。
    [superArray addObject:[super layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];


    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        if(attributes.indexPath.section == 0) {
            if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
                // 获取header的frame
                CGRect rect = attributes.frame;
                // 判断header的bottom是否滑动到导航栏下方
                if(self.collectionView.contentOffset.y + self.topHeight > rect.size.height +  rect.origin.y) {
                    rect.origin.y =  self.collectionView.contentOffset.y + self.topHeight - rect.size.height;
                    attributes.frame = rect;
                }
                attributes.zIndex = 5;
                break;
            }
        }
        
    }
    return [superArray copy];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
    return YES;
}

@end
