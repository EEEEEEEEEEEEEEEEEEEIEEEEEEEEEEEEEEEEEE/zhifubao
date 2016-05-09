//
//  YJADViewCell.m
//  支付宝
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJADViewCell.h"

@implementation YJADViewCell

- (void)setImage:(UIImage *)image
{
    _image = image;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YJScreenSize.width, YJBusiWidth)];
    view.backgroundColor = YJColor(222, 222, 222);
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, YJScreenSize.width, YJBusiWidth - 20)];
    [view addSubview:imageV];
    imageV.image = image;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    [self.contentView addSubview:view];
}

@end
