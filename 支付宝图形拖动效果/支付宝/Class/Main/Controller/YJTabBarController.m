//
//  YJTabBarController.m
//  支付宝
//
//  Created by admin on 16/3/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "YJTabBarController.h"
#import "YJHomeViewController.h"
#import "YJServeViewController.h"
#import "YJDiscoverViewController.h"
#import "YJAssetViewController.h"
#import "YJNavigationController.h"

@interface YJTabBarController ()

@property (nonatomic, strong) YJHomeViewController *homeVC;
@property (nonatomic, strong) YJServeViewController *serveVC;
@property (nonatomic, strong) YJDiscoverViewController *discoverVC;
@property (nonatomic, strong) YJAssetViewController *assetVC;


@end

@implementation YJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加自控制器
    [self setChildControllers];

    
}

- (void)setChildControllers
{
    YJHomeViewController *homeVC = [[YJHomeViewController alloc] init];
    self.homeVC = homeVC;
    [self setupChildController:self.homeVC title:@"支付宝" image:@"TabBar_HomeBar_Sel" selectedImage:@"TabBar_HomeBar_Sel"];
    
    YJServeViewController *serveVC = [[YJServeViewController alloc] init];
    self.serveVC = serveVC;
    [self setupChildController:self.serveVC title:@"服务窗" image:@"TabBar_PublicService" selectedImage:@"TabBar_PublicService_Sel"];
    
    YJDiscoverViewController *discoverVC = [[YJDiscoverViewController alloc] init];
    self.discoverVC = discoverVC;
    [self setupChildController:self.discoverVC title:@"发现" image:@"TabBar_Discovery" selectedImage:@"TabBar_Discovery_Sel"];
    
    YJAssetViewController *assetVC = [[YJAssetViewController alloc] init];
    self.assetVC = assetVC;
    [self setupChildController:self.assetVC title:@"财富" image:@"TabBar_Assets" selectedImage:@"TabBar_Assets_Sel"];
}

- (void)setupChildController:(UIViewController *)controller title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectesImage
{
    controller.title = title;
    
    YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:controller];
    
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectesImage];
    
    [self addChildViewController:nav];
}


@end
