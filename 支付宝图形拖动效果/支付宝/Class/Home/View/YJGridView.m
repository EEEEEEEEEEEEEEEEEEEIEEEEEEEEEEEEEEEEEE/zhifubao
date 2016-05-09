//
//  YJGridView.m
//  支付宝
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJGridView.h"
#import "YJGridItemListView.h"
#import "YJGridButtonitem.h"
#import "YJADView.h"
#import "YJADViewCell.h"
#import "YJHomeMoreButton.h"

@interface YJGridView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *ADView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, assign) CGPoint startP;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger fromIndex;
@property (nonatomic, assign) NSInteger toIndex;
@property (nonatomic, assign) NSInteger originIndex;
@property (nonatomic, weak) YJGridItemListView *longPressV;
@property (nonatomic, weak) YJHomeMoreButton *morebtn;

@end

@implementation YJGridView
static NSString *const ADIdentifier = @"AD";
static int listViewCount = 0;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (YJGridItemListView *)longPressV
{
    if (!_longPressV){
        YJGridItemListView *listView =  [[YJGridItemListView alloc] init];
        _longPressV = listView;
    }
    return _longPressV;
}

- (void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    listViewCount = (int)itemArray.count;
    for (int i = 0; i < itemArray.count; i++) {
        YJGridItemListView *itemView = [[YJGridItemListView alloc] init];
        itemView.index = i;
        itemView.btnClick = ^(YJGridItemListButton *btn){
            [self btnClick:btn];
        };
        itemView.deleteBtnClick = ^(UIButton *btn){
            [self deleteBtnClick:btn];
        };
        itemView.btnLongPress = ^(UILongPressGestureRecognizer *longP){
            [self btnLongPress:longP];
        };
        YJGridButtonitem *item = itemArray[i];
        itemView.item = item;
        itemView.frame = [self frameWithIndex:i];
        [self addSubview:itemView];
    }
    YJHomeMoreButton *moreBtn = [YJHomeMoreButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = [self frameWithIndex:listViewCount];
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:[UIImage imageNamed:@"tf_home_more"] forState:UIControlStateNormal];
    [self addSubview:moreBtn];
    self.morebtn = moreBtn;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)moreBtnClick:(YJHomeMoreButton *)btn {
    if ([self.delegate respondsToSelector:@selector(moreBtnClick::)]) {
        [self.delegate moreBtnClick:self :btn];
    }
}

- (void)btnClick:(YJGridItemListButton *)btn {
    if (self.longPressV.subviews.count == 0) {
        [self.delegate gridViewBtnClick:self :btn];
    }
    if ([self.delegate respondsToSelector:@selector(gridViewBtnClick::)] && self.longPressV.subviews[1].hidden == YES) {
        [self.delegate gridViewBtnClick:self :btn];
    }
    self.longPressV.subviews[1].hidden = YES;
}

- (void)deleteBtnClick:(UIButton *)btn {
    YJGridItemListView *view = (YJGridItemListView *)btn.superview;
    [self reSetListViewFrame:view.index :19];
    [view removeFromSuperview];
    listViewCount--;
    [UIView animateWithDuration:0.5 animations:^{
        self.morebtn.frame = [self frameWithIndex:listViewCount];
    }];
    
    if ([self.collecDelegate respondsToSelector:@selector(deleteBtnClick::)]) {
        [self.collecDelegate deleteBtnClick:self :view];
    }
}

- (void)addNewListView:(YJGridItemListView *)listView {
    listView.frame = [self frameWithIndex:listViewCount];
    listView.subviews[2].hidden = YES;
    listView.index = listViewCount;
    listView.btnLongPress = ^(UILongPressGestureRecognizer *longP){
        [self btnLongPress:longP];
    };
    listView.btnClick = ^(YJGridItemListButton *btn){
        [self btnClick:btn];
    };
    listView.deleteBtnClick = ^(UIButton *btn){
        [self deleteBtnClick:btn];
    };
    [self addSubview:listView];
    [self sendSubviewToBack:listView];
    listViewCount++;
    self.morebtn.frame = [self frameWithIndex:listViewCount];
}

- (void)btnLongPress:(UILongPressGestureRecognizer *)longP {
    
    YJGridItemListView *pressedView = (YJGridItemListView *)longP.view.superview;
    CGPoint curP = [longP locationInView:self];
    if (longP.state == UIGestureRecognizerStateBegan) {
        self.longPressV.subviews[1].hidden = YES;
        pressedView.subviews[1].hidden = NO;
        self.startP = [longP locationInView:self];
        [self bringSubviewToFront:pressedView];

        NSInteger indexX = curP.x / ((NSInteger)YJBusiWidth);
        NSInteger indexY = (NSInteger)(curP.y / ((NSInteger)YJBusiWidth)) * 4;
        NSInteger fromIndex = indexX + (indexY >= 12 ? indexY - 4 : indexY);
        self.fromIndex = fromIndex;
        self.originIndex = fromIndex;
        self.longPressV = pressedView;
    }
    pressedView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    CGPoint disP = CGPointMake(curP.x - self.startP.x, curP.y - self.startP.y);
    pressedView.transform = CGAffineTransformTranslate(pressedView.transform,disP.x, disP.y);
    
    NSInteger indexX = curP.x / ((NSInteger)YJBusiWidth);
    NSInteger indexY = (NSInteger)(curP.y / ((NSInteger)YJBusiWidth)) * 4;
    NSInteger toIndex = indexX + (indexY >= 12 ? indexY - 4 : indexY);
    if (self.toIndex != toIndex && toIndex < 20) {
        if (toIndex > listViewCount - 1) {
            self.toIndex = listViewCount - 1;
        } else {
            self.toIndex = toIndex;
        }
        [self reSetListViewFrame:self.fromIndex :self.toIndex];
    }
    if (longP.state == UIGestureRecognizerStateChanged) {
        self.morebtn.hidden = YES;
    }
    
    if (longP.state == UIGestureRecognizerStateEnded) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            pressedView.transform = CGAffineTransformMakeTranslation(0, 0);
            pressedView.frame = [weakSelf frameWithIndex:weakSelf.toIndex];
            [weakSelf sendSubviewToBack:pressedView];
        } completion:^(BOOL finished) {
            self.morebtn.hidden = NO;
        }];
        if (self.originIndex != toIndex) {
            pressedView.subviews[1].hidden = YES;
        }
        
    }
}


- (void)reSetListViewFrame:(NSInteger)fromIndex :(NSInteger)toIndex
{
    NSLog(@"%ld----%ld",fromIndex,toIndex);
    for (YJGridItemListView *view in self.subviews) {
        if ([view isKindOfClass:[YJGridItemListView class]] && view.index >= fromIndex && view.index <= toIndex) {
            if (view.index == fromIndex) {
                view.index = toIndex;
                self.fromIndex = toIndex;
                NSLog(@"cur %ld",view.index);
            } else {
                NSLog(@"%ld",view.index);
                view.index--;
                [UIView animateWithDuration:0.5 animations:^{
                    view.frame = [self frameWithIndex:view.index];
                }];
             }
        } else if ([view isKindOfClass:[YJGridItemListView class]] && view.index >= toIndex && view.index <= fromIndex) {
            if (view.index == fromIndex) {
                view.index = toIndex;
                self.fromIndex = toIndex;
                NSLog(@"cur %ld",view.index);
            } else {
                NSLog(@"%ld",view.index);
                view.index++;
                [UIView animateWithDuration:0.5 animations:^{
                    view.frame = [self frameWithIndex:view.index];
                }];
            }
        }
    }
}

- (CGRect)frameWithIndex:(NSInteger)index
{
    CGFloat X = index % 4 * YJBusiWidth;
    CGFloat Y = index < 12 ? index / 4 * YJBusiWidth : index / 4 * YJBusiWidth + YJBusiWidth;
    CGFloat W = YJBusiWidth;
    CGFloat H = YJBusiWidth;
    return CGRectMake(X, Y, W, H);
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    [self addTimer];
    [self setADView];
    [self.ADView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2500 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    [self addPageControll];
}

- (void)setADView {
    YJADView *ADView = [YJADView adViewWithIdentifier:ADIdentifier];
    ADView.dataSource = self;
    ADView.delegate = self;
    self.ADView = ADView;
    [self addSubview:ADView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5000;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YJADViewCell *cell = [self.ADView dequeueReusableCellWithReuseIdentifier:ADIdentifier forIndexPath:indexPath];
    cell.image = _imageArray[indexPath.item % _imageArray.count];
    self.indexPath = indexPath;
    return cell;
}
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextPage
{
    [self.ADView setContentOffset:CGPointMake(YJScreenSize.width * (self.indexPath.item+1), 0) animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView.size.height == YJBusiWidth) {
        [self removeTimer];
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView.size.height == YJBusiWidth) {
        [self addTimer];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = self.indexPath.item % 3;
}
- (void)addPageControll
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 1;
    pageControl.center = CGPointMake(YJScreenSize.width / 2, 360);
    pageControl.bounds = CGRectMake(0, 0, 50, 50);
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}


@end
