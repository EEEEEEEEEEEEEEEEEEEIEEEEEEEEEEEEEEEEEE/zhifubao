//
//  YJBusinessCellItem.m
//  支付宝
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJBusinessCellItem.h"
#import "YJTextViewController.h"

@implementation YJBusinessCellItem


+ (YJBusinessCellItem *)CellitemWithDesClass:(__unsafe_unretained Class)desClass :(NSString *)name :(NSString *)image
{
    YJBusinessCellItem *item = [[YJBusinessCellItem alloc] init];
    item.desClass = desClass;
    item.name = name;
    item.icon = [UIImage imageNamed:image];
    
    return item;
}

+ (NSArray *)CellItems
{
    NSMutableArray *itemArray = [NSMutableArray array];
    
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝1" :@"i00"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝2" :@"i01"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝3" :@"i02"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝4" :@"i03"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝5" :@"i04"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝6" :@"i05"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝7" :@"i06"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝8" :@"i07"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝9" :@"i08"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝10" :@"i09"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝11" :@"i10"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝12" :@"i11"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝" :@"i00"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝" :@"i00"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝" :@"i00"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝" :@"i00"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝" :@"i12"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝" :@"i13"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝" :@"i14"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝" :@"i15"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝" :@"i16"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"淘宝" :@"i17"]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:[YJTextViewController class] :@"更多" :nil]];
    [itemArray addObject:[YJBusinessCellItem CellitemWithDesClass:nil :nil :nil]];
    return itemArray;
}

@end
