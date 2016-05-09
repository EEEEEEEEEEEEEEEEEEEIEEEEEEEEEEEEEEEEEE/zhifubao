//
//  YJGridButtonitem.m
//  支付宝
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJGridButtonitem.h"
#import "YJTestViewController.h"

@implementation YJGridButtonitem

+ (YJGridButtonitem *)CellitemWithDesClass:(Class)desClass :(NSString *)desc :(NSString *)image :(NSInteger)index
{
    YJGridButtonitem *item = [[YJGridButtonitem alloc] init];
    item.desClass = desClass;
    item.desc = desc;
    item.image = [UIImage imageNamed:image];
    item.index = index;
    
    return item;
}

+ (NSArray *)gridItems
{
    NSMutableArray *itemArray = [NSMutableArray array];
    
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝0" :@"i00" :0]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝1" :@"i01" :1]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝2" :@"i02" :2]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝3" :@"i03" :3]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝4" :@"i04" :4]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝5" :@"i05" :5]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝6" :@"i06" :6]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝7" :@"i07" :7]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝8" :@"i08" :8]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝9" :@"i09" :9]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝10" :@"i10" :10]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝11" :@"i11" :11]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝12" :@"i12" :12]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝13" :@"i13" :13]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝14" :@"i14" :14]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝15" :@"i15" :15]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝16" :@"i16" :16]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝17" :@"i17" :17]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝18" :@"i18" :18]];

    return itemArray;
}
+ (NSMutableArray *)cellItems
{
    NSMutableArray *itemArray = [NSMutableArray array];
    
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝0" :@"i00" :0]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝1" :@"i01" :1]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝2" :@"i02" :2]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝3" :@"i03" :3]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝4" :@"i04" :4]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝5" :@"i05" :5]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝6" :@"i06" :6]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝7" :@"i07" :7]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝8" :@"i08" :8]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝9" :@"i09" :9]];
    [itemArray addObject:[YJGridButtonitem CellitemWithDesClass:[YJTestViewController class] :@"淘宝10" :@"i10" :10]];
    
    return itemArray;
}

@end
