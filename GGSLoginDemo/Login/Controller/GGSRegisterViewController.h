//
//  GGSRegisterViewController.h
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  注册控制器的样式
 */
typedef NS_ENUM(NSInteger, GGSResiterViewControllType) {
    /**
     *  注册
     */
    GGSRegisterViewControllerTypeRegiste = 0,
    /**
     *  忘记密码
     */
    GGSRegisterViewControllerTypeForgetPwd,
};

@interface GGSRegisterViewController : UIViewController

/**
 *  控制器的样式
 */
@property (nonatomic, assign) GGSResiterViewControllType registerViewConttrollerType;

@end
