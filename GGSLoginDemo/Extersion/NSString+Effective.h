//
//  NSString+Effective.h
//  GGSLoginDemo
//
//  Created by zm on 16/4/27.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Effective)

/**
 *  验证字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return 判断结果
 */
+ (BOOL)zm_isEffectString:(NSString *)string;

/**
 *  验证手机号是否有效
 *
 *  @param mobileNumber 手机号码
 *
 *  @return 是否有效
 */
+ (BOOL)zm_validateMobileNumber:(NSString *)mobileNumber;

/**
 *  MD5 和 base64 加密
 *
 *  @param string 需要加密的string
 *
 *  @return 加密数据
 */
+ (NSString *)md5:(NSString *)string;


@end
