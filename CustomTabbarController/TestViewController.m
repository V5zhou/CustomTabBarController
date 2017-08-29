//
//  TestViewController.m
//  CustomTabbarController
//
//  Created by zmz on 2017/8/29.
//  Copyright © 2017年 zmz. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT - 64)];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.textColor = RGBHEX_(#333333);
    label.text = [self text];
    [self.view addSubview:label];
}

- (NSString *)text {
    return @"原本是想写一个自定义的tabbar的，它的中间按钮在tabbar外一部分，很多app采用了这样的设计。\n\n边界外事件响应，于是想到了hitTest。\n想要写一个view的hitTest，有几种方式。\n1.继承UITabbar,失败。\n2.去cateGory这个view，自定义xxHitTest，方法交换，成功。\n3.KVO类似实现。运行时生成一个子类，把本isa指向子类，悄然替换。成功。";
}

@end
