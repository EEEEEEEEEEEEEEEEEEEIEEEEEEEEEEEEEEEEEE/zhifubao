//
//  YJGridView.h
//  支付宝
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJGridView,YJGridItemListButton,YJHomeMoreButton,YJGridItemListView;

@protocol YJGridViewDelegate <NSObject>
@optional

- (void)gridViewBtnClick:(YJGridView *)gridView :(YJGridItemListButton *)button;

- (void)moreBtnClick:(YJGridView *)gridView :(YJHomeMoreButton *)button;

- (void)deleteBtnClick:(YJGridView *)gridView :(YJGridItemListView *)listView;

@end

@interface YJGridView : UIScrollView

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, weak) id<YJGridViewDelegate> delegate;

@property (nonatomic, weak) id<YJGridViewDelegate> collecDelegate;

- (void)addNewListView :(YJGridItemListView *)listView;

@end
