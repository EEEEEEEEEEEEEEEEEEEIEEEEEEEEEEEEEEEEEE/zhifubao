//
//  YJPayView.m
//  支付宝
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJPayView.h"


@interface YJPayView ()


@end

@implementation YJPayView

- (void)awakeFromNib {
    
    [self.scanBtn setBackgroundColor:YJColor(32, 35, 52)];
    [self.payBtn setBackgroundColor:YJColor(32, 35, 52)];
}

@end
