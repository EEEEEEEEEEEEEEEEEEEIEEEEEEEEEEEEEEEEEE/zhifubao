//
//  YJGridItemListButton.m
//  支付宝
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJGridItemListButton.h"
#define YJBusiWidth [UIScreen mainScreen].bounds.size.width / 4

@implementation YJGridItemListButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(YJBusiWidth * 1 / 3, YJBusiWidth * 1 / 3, YJBusiWidth * 1 / 3, YJBusiWidth * 1 / 3);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, YJBusiWidth * 2 / 3, YJBusiWidth, YJBusiWidth * 1 / 3);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


@end
