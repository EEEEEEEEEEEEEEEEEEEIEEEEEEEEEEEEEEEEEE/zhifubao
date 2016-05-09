//
//  YJHomeMoreButton.m
//  支付宝
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJHomeMoreButton.h"

@implementation YJHomeMoreButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;        
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(YJBusiWidth * 1 / 3, YJBusiWidth * 1 / 3, YJBusiWidth * 1 / 3, YJBusiWidth * 1 / 3);
}
@end
