//
//  YJNavigationController.m
//  支付宝
//
//  Created by admin on 16/3/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJNavigationController.h"

@interface YJNavigationController ()

@end

@implementation YJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

+ (void)initialize
{
    [self setNavBarTheme];
    
    [self setNavBarButtonTheme];
    
}

+ (void)setNavBarTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *attres = [NSMutableDictionary dictionary];
    attres[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attres[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:attres];
    [navBar setTintColor:[UIColor whiteColor]];
}

+ (void)setNavBarButtonTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *attres = [NSMutableDictionary dictionary];
    attres[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attres[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [item setTintColor:[UIColor whiteColor]];
}


@end
