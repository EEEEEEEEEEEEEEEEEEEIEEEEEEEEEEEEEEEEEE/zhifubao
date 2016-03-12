//
//  YJHomeViewController.m
//  支付宝
//
//  Created by admin on 16/3/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//



#import "YJHomeViewController.h"
#import "YJPayView.h"
#import "YJBusinessCellItem.h"
#import "YJBusinessViewCell.h"
#import "YJTextViewController.h"
#import "YJADViewCell.h"
#import "YJBusinessView.h"

@interface YJHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) YJPayView *payView;
@property (nonatomic, weak) UICollectionView *businessView;
@property (nonatomic, strong) NSArray *busiItemArray;

@end

@implementation YJHomeViewController
static NSString *const BusiIdentifier = @"business";

- (NSArray *)busiItemArray
{
    if (!_busiItemArray){
        self.busiItemArray = [YJBusinessCellItem CellItems];
    }
    return _busiItemArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setPayView];
    
    [self setBusinessView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setPayView {
    YJPayView *payView = [[[NSBundle mainBundle] loadNibNamed:@"YJPayView" owner:nil options:nil] lastObject];
    payView.frame = CGRectMake(0, 0, YJScreenSize.width,  YJPayViewHeight);
    self.payView = payView;
    [self.view addSubview:payView];
}

- (void)setBusinessView {
    YJBusinessView *businessView = [YJBusinessView businessView];
    businessView.backgroundColor = [UIColor whiteColor];
    businessView.dataSource = self;
    businessView.delegate = self;
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image%d",i]]];
    }
    businessView.imageArray = imageArray;
    self.businessView = businessView;
    [self.view addSubview:businessView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 24;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YJBusinessViewCell *cell = [self.businessView dequeueReusableCellWithReuseIdentifier:BusiIdentifier forIndexPath:indexPath];
    cell.tag = indexPath.item;
    cell.backgroundColor = [UIColor whiteColor];
    YJBusinessCellItem *item = self.busiItemArray[indexPath.item];
    item.tag = indexPath.item;
    cell.busiItem = item;
    cell.option = ^(Class desClass){
        [self.navigationController pushViewController:[[desClass alloc] init] animated:YES];
    };
    return cell;
}
@end


//        if (indexPath.item % 3 == 2) {
//            cell.contentView.backgroundColor = [UIColor yellowColor];
//        } else if (indexPath.item % 3 == 1) {
//            cell.contentView.backgroundColor = [UIColor blackColor];
//        } else {
//            cell.contentView.backgroundColor = [UIColor whiteColor];
//        }
//        cell.contentView.backgroundColor = [UIColor purpleColor];

