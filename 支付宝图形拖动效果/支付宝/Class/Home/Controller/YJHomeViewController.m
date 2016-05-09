//
//  YJHomeViewController.m
//  支付宝
//
//  Created by admin on 16/3/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//



#import "YJHomeViewController.h"
#import "YJPayView.h"
#import "YJGridView.h"
#import "YJGridButtonitem.h"
#import "YJTestViewController.h"
#import "YJGridItemListButton.h"
#import "YJHomeMoreItemController.h"
#import "SDScanViewController.h"

@interface YJHomeViewController () <YJGridViewDelegate,YJHomeMoreDelegate>

@property (nonatomic, weak) YJPayView *payView;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, weak) YJGridView *gridView;
@property (nonatomic, strong) YJHomeMoreItemController *moreItemVC;

@end

@implementation YJHomeViewController

- (NSArray *)itemArray
{
    if (!_itemArray){
        self.itemArray = [YJGridButtonitem gridItems];
    }
    return _itemArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setPayView];

    [self setGridView];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)setPayView {
    YJPayView *payView = [[[NSBundle mainBundle] loadNibNamed:@"YJPayView" owner:nil options:nil] lastObject];
    payView.frame = CGRectMake(0, 0, YJScreenSize.width,  YJPayViewHeight);
    [payView.scanBtn addTarget:self action:@selector(scanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.payView = payView;
    [self.view addSubview:payView];
}

- (void)scanBtnClick {
    SDScanViewController *desVc = [[SDScanViewController alloc] init];
    [self.navigationController pushViewController:desVc animated:YES];

}

- (void)setGridView
{
    YJGridView *gridView = [[YJGridView alloc] init];
    CGFloat gridX = 0;
    CGFloat gridY = YJPayViewHeight - 64;
    CGFloat gridW = YJScreenSize.width;
    CGFloat gridH = (self.itemArray.count / 4 + 1) * YJBusiWidth;
    gridView.frame = CGRectMake(gridX, gridY, gridW, gridH);
    gridView.delegate = self;
    gridView.itemArray = self.itemArray;
    CGFloat contW = YJScreenSize.width;
    CGFloat contH = YJBusiWidth * (self.itemArray.count / 4 + 2) + 49;
    gridView.contentSize = CGSizeMake(contW, contH);
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image%d",i]]];
    }
    
    YJHomeMoreItemController *moreItemVC = [[YJHomeMoreItemController alloc] init];
    moreItemVC.delegate = self;
    self.moreItemVC = moreItemVC;
    gridView.collecDelegate = (id)self.moreItemVC;
    
    self.gridView = gridView;
    [self.view addSubview:gridView];
    [self setSparateLine];
    gridView.imageArray = imageArray;
}


- (void)setSparateLine
{
    for (int i = 0; i < 11; i++) {
        UIView *view = [[UIView alloc ] init];
        if (i < 4) {
            view = [[UIView alloc] initWithFrame:CGRectMake(YJBusiWidth * (i+1), 0, 0.5, YJBusiWidth * 6)];
        } else {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, YJBusiWidth * (i-4), YJScreenSize.width, 0.5)];
        }
        view.backgroundColor = YJColor(200, 200, 200);
        [self.gridView addSubview:view];
    }
}

- (void)gridViewBtnClick:(YJGridView *)gridView :(YJGridItemListButton *)button
{
    UIViewController *VC = [[button.desClass alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)moreBtnClick:(YJGridView *)gridView :(YJHomeMoreButton *)button
{
    
    [self.navigationController pushViewController:self.moreItemVC animated:YES];
}

- (void)addBtnClick:(YJHomeMoreItemController *)VC :(YJGridItemListView *)listView {
    [self.gridView addNewListView:listView];
}

- (void)cellBtnClick:(YJHomeMoreItemController *)VC :(YJGridItemListButton *)btn
{
    UIViewController *viewC = [[btn.desClass alloc] init];
    [self.navigationController pushViewController:viewC animated:YES];
}




@end


