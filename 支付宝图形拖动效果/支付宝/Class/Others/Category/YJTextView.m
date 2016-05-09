//
//  YJTextView.m
//  Yj新浪微博
//
//  Created by admin on 16/1/12.
//  Copyright © 2016年 梅三IT. All rights reserved.
//

#import "YJTextView.h"

@interface YJTextView ()

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation YJTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}
- (void)textChanged
{
    self.placeholderLabel.hidden = self.text.length;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;

    // 设置placeholder字体
    self.placeholderLabel.font = self.font;
    // 计算设置placeholderLabel的frame
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.placeholderLabel.font;
    CGSize placeholderSize = [placeholder boundingRectWithSize:self.frame.size options: NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    CGFloat placeholderX = 6;
    CGFloat placeholderY = 7;
    self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
    
}

@end
