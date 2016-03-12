//
//  YJBusinessView.m
//  支付宝
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJBusinessView.h"
#import "YJBusinessViewCell.h"
#import "YJADViewCell.h"
#import "YJADView.h"


@interface YJBusinessView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *ADView;
@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, assign) CGPoint curP;
@property (nonatomic, assign) CGPoint startP;
@property (nonatomic, strong) YJBusinessViewCell *selectedCell;
@property (nonatomic, weak) UIView *belowView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) UIImageView *cellImageV;


@end

@implementation YJBusinessView



- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveCell:)];
    
    [self addGestureRecognizer:longP];
    
    return [super initWithFrame:frame collectionViewLayout:layout];
}

static NSString *const BusiIdentifier = @"business";
static NSString *const ADIdentifier = @"AD";
+ (YJBusinessView *)businessView
{
    // 设置布局方式
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(YJBusiWidth, YJBusiWidth);
    // 创建collectionView,设置相关属性
    CGFloat busiX = 0;
    CGFloat busiY = YJPayViewHeight - YJTabBarHeight;
    CGFloat busiW = YJScreenSize.width;
    CGFloat busiH = YJScreenSize.height - YJPayViewHeight - 49;
    YJBusinessView *businessView = [[YJBusinessView alloc] initWithFrame:CGRectMake(busiX, busiY, busiW, busiH) collectionViewLayout:layout];
    businessView.backgroundColor = [UIColor whiteColor];
    
    // 注册缓存池
    [businessView registerClass:[YJBusinessViewCell class] forCellWithReuseIdentifier:BusiIdentifier];
    // 添加cell分割线
    for (int i = 0; i < 11; i++) {
        UIView *view = [[UIView alloc ] init];
        if (i < 4) {
            view = [[UIView alloc] initWithFrame:CGRectMake(YJBusiWidth * (i+1), 0, 0.5, YJBusiWidth * 6)];
        } else {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, YJBusiWidth * (i-4), YJScreenSize.width, 0.5)];
        }
        view.backgroundColor = YJColor(200, 200, 200);
        [businessView addSubview:view];
    }
    return businessView;
}

- (void)moveCell:(UILongPressGestureRecognizer *)longP {
    CGPoint curP = [longP locationInView:self];
    
    if (longP.state == UIGestureRecognizerStateBegan) {

        for (YJBusinessViewCell *cell in self.subviews) {
            if ([cell isKindOfClass:[YJBusinessViewCell class]] && CGRectContainsPoint(cell.frame, curP)) {
                
                self.selectedCell = cell;
                self.startP = [longP locationInView:self];
//                [self insertSubview:cell aboveSubview:self.aboveView];
                //1.开启一个位图上下文
                UIGraphicsBeginImageContextWithOptions(cell.size, 1, 10);
                //2.把View的内容绘制到上下文当中
                CGContextRef ctx =  UIGraphicsGetCurrentContext();
                //UIView内容想要绘制到上下文当中, 必须使用渲染的方式
                [cell.layer renderInContext:ctx];
                //3.从上下文当中生成一张图片
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                //4.关闭上下文
                UIGraphicsEndImageContext();

                UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.frame];
                [self addSubview:imageView];
                imageView.image = newImage;
                imageView.size = CGSizeMake(imageView.width * 1.1, imageView.height*1.1);
                imageView.center = cell.center;
                self.cellImageV = imageView;
                
                UIView *cover = [[UIView alloc] initWithFrame:cell.bounds];
                cover.backgroundColor = [UIColor whiteColor];
                [cell addSubview:cover];
            }
        }
    } else if (longP.state == UIGestureRecognizerStateChanged ) {
        CGPoint offSet = CGPointMake(curP.x - self.startP.x, curP.y - self.startP.y);
        self.cellImageV.transform = CGAffineTransformMakeTranslation(offSet.x, offSet.y);
        for (YJBusinessViewCell *cell in self.subviews) {
            if ([cell isKindOfClass:[YJBusinessViewCell class]] && CGRectContainsPoint(cell.frame, curP)) {
                if (cell.tag != self.selectedCell.tag) {
                    NSLog(@"%ld %ld",cell.tag,self.selectedCell.tag);
                    
                    [self moveItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedCell.tag inSection:0] toIndexPath:[NSIndexPath indexPathForItem:cell.tag inSection:0]];
                    if (self.selectedCell.tag > cell.tag) {
                        [self insertSubview:self.selectedCell belowSubview:cell];
                    } else {
                        [self insertSubview:self.selectedCell aboveSubview:cell];
                    }
                    for (int i = 0; i < self.subviews.count; i++) {
                        if ([self.subviews[i] isKindOfClass:[YJBusinessViewCell class]]) {
                            self.subviews[i].tag = self.index;
                            self.index++;
                        }
                    }
                    self.index = 0;
                }
            }
            
        }

    } else if (longP.state == UIGestureRecognizerStateEnded) {
        self.selectedCell.transform = CGAffineTransformMakeTranslation(0, 0);
        
        for (YJBusinessViewCell *cell in self.subviews) {
            if ([cell isKindOfClass:[YJBusinessViewCell class]] && CGRectContainsPoint(cell.frame, curP)) {
                NSLog(@"%@",NSStringFromCGPoint(self.selectedCell.center));
                NSLog(@"%@",NSStringFromCGPoint(self.cellImageV.center));
                [UIView animateWithDuration:0.2 animations:^{
                    self.cellImageV.transform = CGAffineTransformMakeTranslation(cell.center.x - self.cellImageV.center.x, cell.center.y - self.cellImageV.center.y);
                } completion:^(BOOL finished) {
                    [self.cellImageV removeFromSuperview];
                    [[cell.subviews lastObject] removeFromSuperview];
                }];
            }
        }
        for (int i = 0; i < self.subviews.count; i++) {
            if ([self.subviews[i] isKindOfClass:[YJBusinessViewCell class]]) {
                self.subviews[i].tag = self.index;
                self.index++;
//                NSLog(@"%ld",self.subviews[i].tag);
            }
        }
        self.index = 0;
        
    }
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
