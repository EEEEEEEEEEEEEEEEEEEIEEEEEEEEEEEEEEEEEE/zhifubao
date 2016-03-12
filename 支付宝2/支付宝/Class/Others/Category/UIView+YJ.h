//
//  1.直接修改view的x,y,width,height,size,origin

#import <UIKit/UIKit.h>

@interface UIView (YJ)

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;

@end
