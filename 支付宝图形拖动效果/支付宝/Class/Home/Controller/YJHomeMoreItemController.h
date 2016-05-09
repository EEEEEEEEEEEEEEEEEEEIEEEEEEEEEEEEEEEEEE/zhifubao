//
//  YJHomeMoreItemController.h
//  支付宝
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJHomeMoreItemController,YJGridItemListView,YJGridItemListButton;
@protocol YJHomeMoreDelegate <NSObject>

@optional
- (void)addBtnClick:(YJHomeMoreItemController *)VC :(YJGridItemListView *)listView;
- (void)cellBtnClick:(YJHomeMoreItemController *)VC :(YJGridItemListButton *)btn;

@end


@interface YJHomeMoreItemController : UICollectionViewController

@property (nonatomic, weak) id<YJHomeMoreDelegate> delegate;

@end
