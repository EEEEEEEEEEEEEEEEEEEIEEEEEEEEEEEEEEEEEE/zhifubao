//
//  YJBusinessCellItem.h
//  支付宝
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJBusinessCellItem : NSObject

@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) Class desClass;

@property (nonatomic, assign) NSInteger tag;

+ (YJBusinessCellItem *)CellitemWithDesClass:(Class)desClass:(NSString *)name:(NSString *)image;

+ (NSArray *)CellItems;

@end
