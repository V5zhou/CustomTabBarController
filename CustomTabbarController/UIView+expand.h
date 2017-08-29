//
//  UIView+expand.h
//  UIAnimationTest
//
//  Created by zmz on 2017/8/28.
//  Copyright © 2017年 zmz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (expand)


/**
 设置本view的hitTestView
 作用是：即使hitTestView在本view的范围外，点击在hitTestView上时，依然响应。
 */
@property (nonatomic, strong) UIView *hitTestView;

@end
