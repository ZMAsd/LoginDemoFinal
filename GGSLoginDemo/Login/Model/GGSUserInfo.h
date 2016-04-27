//
//  GGSUserInfoData.h
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGSUserInfo : NSObject
///**
// *  用户id
// */
//@property (nonatomic, copy) NSString *userId;
/**
 *  用户姓名
 */
@property (nonatomic, copy) NSString *userName;
/**
 *  用户密码
 */
@property (nonatomic, copy) NSString *userPwd;
/**
 *  用户登录日期
 */
@property (nonatomic, strong) NSDate *userLoginDate;

- (instancetype)initWithUserName:(NSString *)userName
                         userPwd:(NSString *)userPwd
                   userLoginDate:(NSDate *)userLoginDate;

+ (instancetype)userInfoWithUserName:(NSString *)userName
                             userPwd:(NSString *)userPwd
                       userLoginDate:(NSDate *)userPwdDate;

@end
