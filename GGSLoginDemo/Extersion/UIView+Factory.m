//
//  UIView+Factory.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "UIView+Factory.h"

@implementation UIView (Factory)

/**
 *  创建button并设置title 自弃对齐方式
 *
 *  @param title         显示的title
 *  @param titleColor    字体颜色
 *  @param font          字体大小
 *  @param target        关联对象
 *  @param action        响应事件
 *
 *  @return 创建的button
 */
+ (UIButton *)zm_createButtonWithTitle:(NSString *)title
                            titleColor:(UIColor *)titleColor
                       backgroundColor:(UIColor *)backgroundColor
                                  font:(CGFloat)font
                                target:(id)target
                                action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateSelected];
    button.backgroundColor = backgroundColor;
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/**
 *  递归寻找第一响应者
 *
 *  @param view 需要寻找的view
 *
 *  @return 第一响应者
 */
- (UIView *)findfirstResponser {
    if ([self isFirstResponder]) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponser = [subView findfirstResponser];
        if (firstResponser != nil) {
            return firstResponser;
        }
    }
    return nil;
}

@end
