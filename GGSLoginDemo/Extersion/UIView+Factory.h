//
//  UIView+Factory.h
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Factory)

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
                                action:(SEL)action;


/**
 *  递归寻找第一响应者
 *
 *  @param view 需要寻找的view
 *
 *  @return 第一响应者
 */
- (UIView *)findfirstResponser;

@end
