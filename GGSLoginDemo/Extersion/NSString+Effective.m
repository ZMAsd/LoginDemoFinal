//
//  NSString+Effective.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/27.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "NSString+Effective.h"
#import "GTMBase64/GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Effective)

/**
 *  验证字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return 判断结果
 */
+ (BOOL)zm_isEffectString:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (string == nil || string == NULL) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return NO;
    }
    
    BOOL isEffect = YES;
    if ([string isEqualToString:@""] || string == nil || string == NULL || [string isEqualToString:@"<NULL>"] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"<nil>"]) {
        
        isEffect = NO;
    }
    return isEffect;
}

/**
 *  验证手机号是否有效
 *
 *  @param mobileNumber 手机号码
 *
 *  @return 是否有效
 */
+ (BOOL)zm_validateMobileNumber:(NSString *)mobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumber] == YES)
        || ([regextestcm evaluateWithObject:mobileNumber] == YES)
        || ([regextestct evaluateWithObject:mobileNumber] == YES)
        || ([regextestcu evaluateWithObject:mobileNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  MD5 和 base64 加密
 *
 *  @param string 需要加密的string
 *
 *  @return 加密数据
 */
+ (NSString *)md5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    NSData *data = [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

@end
