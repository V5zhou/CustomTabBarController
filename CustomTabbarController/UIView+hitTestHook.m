//
//  UIView+hitTestHook.m
//  CustomTabbarController
//
//  Created by zmz on 2017/8/29.
//  Copyright © 2017年 zmz. All rights reserved.
//

#import "UIView+hitTestHook.h"
#import <objc/runtime.h>

@implementation UIView (hitTestHook)

+ (void)load {
    Method method1 =
    class_getInstanceMethod([UIView class], @selector(hitTest:withEvent:));
    Method method11 = class_getInstanceMethod([UIView class], @selector(xxHitTest:withEvent:));
    method_exchangeImplementations(method1, method11);
}

- (UIView *)xxHitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *touchView = [self xxHitTest:point withEvent:event];
    if (!touchView) {
        if (self.hitTestView) {
            if (CGRectContainsPoint(self.hitTestView.frame, point)) {
                return self.hitTestView;
            }
        }
    }
    return touchView;
}

static char hitTestView_bind;
- (void)setHitTestView:(UIView *)hitTestView {
    objc_setAssociatedObject(self, &hitTestView_bind, hitTestView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)hitTestView {
    return objc_getAssociatedObject(self, &hitTestView_bind);
}

@end
