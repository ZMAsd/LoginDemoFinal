//
//  ZHMNavigationController.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/27.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "ZHMNavigationController.h"

@implementation ZHMNavigationController

+ (void)initialize {
    [self p_setupNavigationBarStyle];
    [self p_setupBarButtonItemStyle];
}

+ (void)p_setupNavigationBarStyle {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:19],
                                 NSForegroundColorAttributeName : [UIColor blackColor]}];
    [navigationBar setBarTintColor:[UIColor whiteColor]];
}

+ (void)p_setupBarButtonItemStyle {
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    [barButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15],
                               NSForegroundColorAttributeName : [UIColor blackColor]}
                                 forState:UIControlStateNormal];
    [barButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(-400, 0) forBarMetrics:UIBarMetricsDefault];
}

@end
