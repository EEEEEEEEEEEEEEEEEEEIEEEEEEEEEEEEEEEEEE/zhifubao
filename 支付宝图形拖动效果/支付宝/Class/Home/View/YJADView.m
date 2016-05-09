//
//  YJADView.m
//  支付宝
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJADView.h"
#import "YJADViewCell.h"

@interface YJADView()

@end

@implementation YJADView

+ (YJADView *)adViewWithIdentifier:(NSString *)identifier
{
    // 设置布局方式
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(YJScreenSize.width, YJBusiWidth);
    // 创建collectionView,设置相关属性
    CGFloat ADX = 0;
    CGFloat ADY = 3 * YJBusiWidth;
    CGFloat ADW = YJScreenSize.width;
    CGFloat ADH = YJBusiWidth;
    YJADView *ADView = [[YJADView alloc] initWithFrame:CGRectMake(ADX, ADY, ADW, ADH) collectionViewLayout:layout];
    ADView.showsHorizontalScrollIndicator = NO;
    ADView.pagingEnabled = YES;
    ADView.backgroundColor = [UIColor whiteColor];
    // 注册缓存池
    [ADView registerClass:[YJADViewCell class] forCellWithReuseIdentifier:identifier];
    
    return ADView;
}





@end
