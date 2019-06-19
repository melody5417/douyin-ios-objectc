//
//  UserHomePageController.h
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

// https://sshiqiao.github.io/document/douyin-objectc.html

#import "BaseViewController.h"

@interface UserHomePageController : BaseViewController
@property (nonatomic, strong) UICollectionView                 *collectionView;
@property (nonatomic, assign) NSInteger                        selectIndex;
@end
