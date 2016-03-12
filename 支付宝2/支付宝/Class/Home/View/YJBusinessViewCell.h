//
//  YJBusinessViewCell.h
//  支付宝
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJBusinessCellItem.h"


@interface YJBusinessViewCell : UICollectionViewCell

@property (nonatomic, strong) YJBusinessCellItem *busiItem;

@property (nonatomic, copy) void(^option)(Class);


@end
