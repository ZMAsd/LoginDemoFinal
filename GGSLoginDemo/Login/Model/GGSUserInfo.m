
//
//  GGSUserInfoData.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "GGSUserInfo.h"

@implementation GGSUserInfo

- (instancetype)initWithUserName:(NSString *)userName
                         userPwd:(NSString *)userPwd
                   userLoginDate:(NSDate *)userLoginDate {
    self = [super init];
    if (self) {
        _userName = userName;
        _userPwd = [NSString md5:userPwd];
        _userLoginDate = userLoginDate;
    }
    return self;
}

+ (instancetype)userInfoWithUserName:(NSString *)userName
                             userPwd:(NSString *)userPwd
                       userLoginDate:(NSDate *)userLoginDate {
    GGSUserInfo *userInfo = [[GGSUserInfo alloc] initWithUserName:userName
                                                          userPwd:userPwd
                                                    userLoginDate:userLoginDate];
    return userInfo;
}

@end
