//
//  YJGridButtonitem.h
//  支付宝
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YJGridButtonitem : NSObject

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) Class desClass;

@property (nonatomic, assign) NSInteger index;


+ (YJGridButtonitem *)CellitemWithDesClass:(Class)desClass:(NSString *)desc:(NSString *)image :(NSInteger)index;

+ (NSArray *)gridItems;

+ (NSMutableArray *)cellItems;

@end
