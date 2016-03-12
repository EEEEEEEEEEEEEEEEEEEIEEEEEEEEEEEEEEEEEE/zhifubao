//
//  YJBusinessViewCell.m
//  支付宝
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJBusinessViewCell.h"
#import "YJBusiButton.h"
#define YJBusiWidth [UIScreen mainScreen].bounds.size.width / 4

@interface YJBusinessViewCell ()


@end

@implementation YJBusinessViewCell



- (void)setBusiItem:(YJBusinessCellItem *)busiItem {
    
    _busiItem = busiItem;
    
    YJBusiButton *btn = [[YJBusiButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.tag = busiItem.tag;

    [btn setImage:busiItem.icon forState:UIControlStateNormal];
    [btn setTitle:busiItem.name forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    for (UIView *btn in self.contentView.subviews) {
        [btn removeFromSuperview];
    }
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.size = CGSizeMake(YJBusiWidth, YJBusiWidth);
    btn.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:btn];
    
}

- (void)btnClick
{
    if (self.option) {
        self.option(_busiItem.desClass);
    }
}

@end
