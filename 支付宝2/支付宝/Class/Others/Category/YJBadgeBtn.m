//
//  YJBadgeBtn.m
//  test2
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJBadgeBtn.h"

@interface YJBadgeBtn()

@property (nonatomic, weak)  UIView *smallCircle;

/** 形状图层 */
@property (nonatomic, weak) CAShapeLayer *shapL;



@end

@implementation YJBadgeBtn

-(CAShapeLayer *)shapL{
    
    if (_shapL == nil) {
        CAShapeLayer *shap = [CAShapeLayer layer];
        shap.fillColor = [UIColor redColor].CGColor;
        _shapL = shap;
        [self.superview.layer insertSublayer:shap atIndex:0];
    }
    return _shapL;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"..." forState:UIControlStateNormal];
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor redColor];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.smallCircle) return;
    
    [self setUp];
}
- (void)setCount:(int)count
{
    if (count > 99) {
        [self setTitle:@"99" forState:UIControlStateNormal];
    } else {
        [self setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
    }
}



- (void)setUp
{
    
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    
    //添加小圆
    UIView *smallCircle = [[UIView alloc] init];
    smallCircle.backgroundColor = self.backgroundColor;
    smallCircle.layer.cornerRadius = self.layer.cornerRadius;
    smallCircle.frame = self.frame;
    self.smallCircle = smallCircle;
    
//    [self.superview addSubview:smallCircle];
    [self.superview insertSubview:smallCircle belowSubview:self];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    //获取移动偏移量
    CGPoint transP =  [pan translationInView:self];
    //frame,center,transform.
    //transform它并不会去修改center.它修改的是frame.
    //self.transform = CGAffineTransformTranslate(self.transform, transP.x, transP.y);
    
    CGPoint center = self.center;
    center.x += transP.x;
    center.y += transP.y;
    self.center = center;
    
    //计算两个圆之间的距离
    CGFloat distance = [self distanceWithSmallCircle:self.smallCircle bigCirle:self];
    
    //获取小圆的半径
    CGFloat radius = self.bounds.size.width * 0.5;
    radius = radius - distance / 10.0;
    self.smallCircle.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
    self.smallCircle.layer.cornerRadius = radius;
    
    
    UIBezierPath *path = [self  pathWithSmallCircle:self.smallCircle bigCirle:self];
    
    //形状图层
    if (self.smallCircle.hidden == NO) {
        self.shapL.path = path.CGPath;
    }
    //判断 两个圆之间的距离
    if(distance > 60){
        self.smallCircle.hidden = YES;
        //self.shapL.hidden = YES;
        [self.shapL removeFromSuperlayer];
    }
    //判断手势的状态
    if(pan.state == UIGestureRecognizerStateEnded){
        
        if (distance <= 60) {
            self.center =  self.smallCircle.center;
            self.smallCircle.hidden = NO;
            [self.shapL removeFromSuperlayer];
        }else{
            //播放动画,消失
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
            
            NSMutableArray *imageArray = [NSMutableArray array];
            for (int i = 0;  i < 8; i++) {
                NSString *imageName = [NSString stringWithFormat:@"%d",i + 1];
                UIImage *image = [UIImage imageNamed:imageName];
                [imageArray addObject:image];
            }
            imageV.animationImages = imageArray;
            [imageV setAnimationDuration:1];
            [imageV startAnimating];
            
            //添加到按钮上
            [self addSubview:imageV];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
            
            
        }
        
    }
    
    
    //复位
    [pan setTranslation:CGPointZero inView:self];
    
}

//计算两个圆之间的距离
- (CGFloat)distanceWithSmallCircle:(UIView *)smallCircle bigCirle:(UIView *)bigCircle{
    
    CGFloat offsetX = bigCircle.center.x - smallCircle.center.x;
    CGFloat offsetY = bigCircle.center.y - smallCircle.center.y;
    return  sqrt(offsetX * offsetX + offsetY * offsetY);
}



//根据两个圆计算不规则的路径
- (UIBezierPath *)pathWithSmallCircle:(UIView *)smallCircle bigCirle:(UIView *)bigCircle {
    
    CGFloat x1 = smallCircle.center.x;
    CGFloat y1 = smallCircle.center.y;
    
    CGFloat x2 = bigCircle.center.x;
    CGFloat y2 = bigCircle.center.y;
    
    CGFloat d = [self distanceWithSmallCircle:smallCircle bigCirle:bigCircle];
    
    if (d <= 0) {
        return nil;
    }
    
    
    CGFloat cosθ = (y2 - y1) / d;
    CGFloat sinθ = (x2 - x1) / d;
    
    CGFloat r1 = smallCircle.bounds.size.width * 0.5;
    CGFloat r2 = bigCircle.bounds.size.width * 0.5;
    
    //创建点
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 * sinθ, pointA.y + d * 0.5 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinθ, pointB.y + d * 0.5 * cosθ);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //BC(曲线)
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    //CD
    [path addLineToPoint:pointD];
    //DA(曲线)
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
}






//取消高亮状态
-(void)setHighlighted:(BOOL)highlighted{
}

@end
