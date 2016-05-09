//
//  YJGridItemListView.m
//  支付宝
//
//  Created by admin on 16/3/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJGridItemListView.h"
#import "YJGridItemListButton.h"

@implementation YJGridItemListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setItem:(YJGridButtonitem *)item
{
    _item = item;
    YJGridItemListButton *btn = [[YJGridItemListButton alloc] init];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.desClass = item.desClass;
    [btn setImage:item.image forState:UIControlStateNormal];
    [btn setTitle:item.desc forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongPress:)];
    [btn addGestureRecognizer:longP];
    
    [self addSubview:btn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"Home_delete_icon"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.frame = CGRectMake(YJBusiWidth - 20, 0, 20, 20);
    deleteBtn.hidden = YES;
    [self addSubview:deleteBtn];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"app_add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(YJBusiWidth - 20, 0, 20, 20);
    addBtn.hidden = YES;
    [self addSubview:addBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.subviews[0].frame = self.bounds;
}

- (void)btnClick:(YJGridItemListButton *)btn {
    if (self.btnClick) {
        self.btnClick(btn);
    }
}

- (void)deleteBtnClick:(UIButton *)btn {
    if (self.deleteBtnClick) {
        self.deleteBtnClick(btn);
    }
}

- (void)addBtnClick:(UIButton *)btn {
    if (self.addBtnClick) {
        self.addBtnClick(btn);
    }
}

- (void)btnLongPress:(UILongPressGestureRecognizer *)longP {
    if (self.btnLongPress) {
        self.btnLongPress(longP);
    }
}

@end
