//
//  YJGridItemListView.h
//  支付宝
//
//  Created by admin on 16/3/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJGridButtonitem,YJGridItemListButton;

@interface YJGridItemListView : UIView

@property (nonatomic, strong) YJGridButtonitem *item;

@property (atomic, assign) NSInteger index;

@property (nonatomic, copy) void(^btnClick)(YJGridItemListButton *btn);

@property (nonatomic, copy) void(^deleteBtnClick)(UIButton *btn);
@property (nonatomic, copy) void(^addBtnClick)(UIButton *btn);

@property (nonatomic, copy) void(^btnLongPress)(UILongPressGestureRecognizer *longP);

@end
