//
//  CustomTabBarController.m
//  UIAnimationTest
//
//  Created by zmz on 2017/8/28.
//  Copyright © 2017年 zmz. All rights reserved.
//

#import "CustomTabBarController.h"
#import "UIView+expand.h"
//#import "UIView+hitTestHook.h"

@interface CustomTabBarController () <UITabBarControllerDelegate>

@end

#define kTagStart 1000

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.delegate = self;
    
    //
    [self addViewControllers];
}

- (void)addViewControllers {
    //清除半透明层
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
    
    //标题、图片、视图
    NSArray *titles = @[@"1111", @"2222", @"", @"3333", @"4444"];
    NSArray *images = @[@"tabbar-home", @"tabbar-match", @"", @"tabbar-discover", @"tabbar-me"];
    self.viewControllers = @[
                             [[UINavigationController alloc] initWithRootViewController:ControllerWithName(@"TestViewController")],
                             [[UINavigationController alloc] initWithRootViewController:ControllerWithName(@"TestViewController")],
                             [[UIViewController alloc] init],
                             [[UINavigationController alloc] initWithRootViewController:ControllerWithName(@"TestViewController")],
                             [[UINavigationController alloc] initWithRootViewController:ControllerWithName(@"TestViewController")],
                             ];
    
    //样式设置
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        UIImage* unSelectedImage = [UIImage imageNamed:images[idx]];
        UIImage* selectedImage   = [UIImage imageNamed:[images[idx] stringByAppendingString:@"-selected"]];
        unSelectedImage          = [unSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage            = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setImage:unSelectedImage];
        [item setSelectedImage:selectedImage];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#2aab5d"]} forState:UIControlStateSelected];
    }];
    
    [self.tabBar setShadowImage:[UIImage imageWithColor:RGBHEX_(#e5e5e5)]];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.97 alpha:0.96]]];
    
    //创建中间按钮
    [self addCustomCenterButton];
}

- (void)addCustomCenterButton {
    UIButton *center = [UIButton buttonWithType:UIButtonTypeCustom];
    center.frame = CGRectMake((kSCREEN_WIDTH-40)/2, -20, 40, 40);
    center.showsTouchWhenHighlighted = NO;
    [center setImage:[UIImage imageNamed:@"tabbar-more"] forState:UIControlStateNormal];
    [self.tabBar addSubview:center];
    //把center添加响应进去
    self.tabBar.hitTestView = center;
    
    //加上边框
    center.layer.cornerRadius = 30;
    CAShapeLayer *shap = [[CAShapeLayer alloc] init];
    shap.frame = CGRectMake((kSCREEN_WIDTH-60)/2, -30, 60, 60);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:25 startAngle:M_PI endAngle:M_PI*2 clockwise:YES];
    shap.path = path.CGPath;
    shap.strokeColor = [RGBHEX_(#e5e5e5) CGColor];
    shap.fillColor = [[UIColor colorWithWhite:0.97 alpha:0.96] CGColor];
    [self.tabBar.layer insertSublayer:shap atIndex:0];
    
    [center setsAction:^(UIButton *button) {
        NSLog(@"这里处理自定义事件，比如发帖等，可以响应tabbar外事件");
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.fromValue = @(1);
        animation.toValue = @(2);
        animation.autoreverses = YES;
        animation.duration = 0.3;
        [button.layer addAnimation:animation forKey:nil];
    }];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([NSStringFromClass([viewController class]) isEqualToString:@"UIViewController"]) {
        return NO;
    }
    return YES;
}

static UIViewController *ControllerWithName(NSString *controllerName) {
    Class cls = NSClassFromString(controllerName);
    if (cls) {
        UIViewController *ctl = [[cls alloc] init];
        return ctl;
    }
    return nil;
}

@end
