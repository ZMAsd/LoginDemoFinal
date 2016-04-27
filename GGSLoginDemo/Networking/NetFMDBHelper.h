//
//  NetFMDBHelper.h
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GGSUserInfo;

@interface NetFMDBHelper : FMDatabase

+ (instancetype)sharFMDBHelper;

/**
 *  插入用户信息
 *
 *  @param userInfo 用户信息
 */
- (void)insertWithUserInfo:(GGSUserInfo *)userInfo;

/**
 *  通过用户名删除用户信息
 *
 *  @param userName 用户名
 */
- (void)deleteUserInfoWithUserName:(NSString *)userName;
/**
 *  根据用户明查询查询登录是否过期
 *
 *  @param userName 用户名
 *
 *  @return 登录是否过期的状态
 */
- (BOOL)isLoginValiableWithUserName:(NSString *)userName;

/**
 *  根据用户名获取最新的登录日期
 *
 *  @param userName 用户名
 *
 *  @return 登陆日期
 */
- (NSString *)userLastLoginDateWithUserName:(NSString *)userName;

/**
 *  根据用户名查询密码
 *
 *  @param userName 用户名
 *
 *  @return 密码
 */
- (NSString *)queryUserPwdWithUserName:(NSString *)userName;

/**
 *  判断当前账户是否存在
 *
 *  @param userName 账户名
 *
 *  @return 状态
 */
- (BOOL)isExesitWithUserName:(NSString *)userName;

@end
