//
//  YJHomeMoreItemController.m
//  支付宝
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJHomeMoreItemController.h"
#import "YJGridItemListView.h"
#import "YJGridView.h"
#import "YJGridButtonitem.h"
#import "MBProgressHUD+XMG.h"

@interface YJHomeMoreItemController () <YJGridViewDelegate>

@property (nonatomic, strong) NSMutableArray *cellItemArray;
@property (nonatomic, strong) NSMutableArray *lineArray;

@property (nonatomic, weak) YJGridItemListView *longPressV;
@property (nonatomic, assign) NSInteger toIndex;

@end

@implementation YJHomeMoreItemController

- (NSMutableArray *)lineArray
{
    if (!_lineArray){
        self.lineArray = [[NSMutableArray alloc] init];
    }
    return _lineArray;
    
}

- (NSMutableArray *)cellItemArray
{
    if (!_cellItemArray){
        self.cellItemArray = [YJGridButtonitem cellItems];
    }
    return _cellItemArray;
    
}

- (YJGridItemListView *)longPressV
{
    if (!_longPressV){
        YJGridItemListView *listView =  [[YJGridItemListView alloc] init];
        _longPressV = listView;
    }
    return _longPressV;
    
}

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    //流水布局
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    //设置每一个格子的大小
    flowL.itemSize = CGSizeMake(YJBusiWidth, YJBusiWidth);
    //设置最小行间距
    flowL.minimumLineSpacing = 0;
    //设置每个格子之间的间距
    flowL.minimumInteritemSpacing = 0;
    
    //设置滚动的方向
    flowL.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return [super initWithCollectionViewLayout:flowL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setSparateLine];
}


- (void)setSparateLine
{
    for (UIView *view in self.lineArray) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < 6 + (_cellItemArray.count-1)/4; i++) {
        UIView *view = [[UIView alloc ] init];
        if (i < 4) {
            view = [[UIView alloc] initWithFrame:CGRectMake(YJBusiWidth * (i+1), 0, 0.5, YJBusiWidth * ((self.cellItemArray.count+3)/4))];
        } else {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, YJBusiWidth * (i-4), YJScreenSize.width, 0.5)];
        }
        view.backgroundColor = YJColor(200, 200, 200);
        [self.collectionView addSubview:view];
        [self.lineArray addObject:view];
    }
}

- (void)deleteBtnClick:(YJGridView *)gridView :(YJGridItemListView *)listView
{
    [self.cellItemArray addObject:listView.item];
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.cellItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    YJGridItemListView *itemView = [[YJGridItemListView alloc] init];
    itemView.index = indexPath.row;
    YJGridButtonitem *item = _cellItemArray[indexPath.row];
    itemView.item = item;
    itemView.frame = [self frameWithIndex:indexPath.row];
    itemView.btnClick = ^(YJGridItemListButton *btn){
        [self btnClick:btn];
    };
    itemView.btnLongPress = ^(UILongPressGestureRecognizer *longP) {
        [self btnLongPress:longP];
    };
    itemView.addBtnClick = ^(UIButton *btn){
        [self addbtnClick:btn];
    };
    [cell.contentView addSubview:itemView];
    NSLog(@"%@",cell.contentView.subviews.firstObject);
    
    return cell;
}
- (void)btnLongPress:(UILongPressGestureRecognizer *)longP {
    YJGridItemListView *pressedView = (YJGridItemListView *)longP.view.superview;
    if (longP.state == UIGestureRecognizerStateBegan){
        self.longPressV.subviews[2].hidden = YES;
        self.longPressV = pressedView;
        pressedView.subviews.lastObject.hidden = NO;
        
    }
    CGPoint curP = [longP locationInView:self.collectionView];
    NSInteger indexX = curP.x / ((NSInteger)YJBusiWidth);
    NSInteger indexY = (NSInteger)(curP.y / ((NSInteger)YJBusiWidth)) * 4;
    self.toIndex = indexX + (indexY >= 12 ? indexY - 4 : indexY);
}

- (void)addbtnClick:(UIButton *)btn {
    if (_cellItemArray.count < 12) {
        [MBProgressHUD showError:@"放不下了"];
        self.longPressV.subviews[2].hidden = YES;
        return;
    }
    YJGridItemListView *view = (YJGridItemListView *)btn.superview;
    [self.cellItemArray removeObject:view.item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.toIndex inSection:0];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    [self setSparateLine];
    if ([self.delegate respondsToSelector:@selector(addBtnClick::)]) {
        [self.delegate addBtnClick:self :view];
    }
}
- (void)btnClick:(YJGridItemListButton *)btn {
    if ([self.delegate respondsToSelector:@selector(cellBtnClick::)] && self.longPressV.subviews[2].hidden == YES) {
        [self.delegate cellBtnClick:self :btn];
    }
    self.longPressV.subviews[2].hidden = YES;
}

- (CGRect)frameWithIndex:(NSInteger)index
{
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = YJBusiWidth;
    CGFloat H = YJBusiWidth;
    return CGRectMake(X, Y, W, H);
}

@end