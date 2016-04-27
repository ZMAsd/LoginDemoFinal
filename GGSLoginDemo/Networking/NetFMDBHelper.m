//
//  NetFMDBHelper.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "NetFMDBHelper.h"
#import "GGSUserInfo.h"

static NetFMDBHelper *fmdbHelper = nil;

@implementation NetFMDBHelper


+ (instancetype)sharFMDBHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [filePath objectAtIndex:0];
        NSLog(@"%@",filePath);
        NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"db.sqlite"];
        fmdbHelper = [NetFMDBHelper databaseWithPath:dbFilePath];
        //判断数据库是否已经打开，如果没有打开，提示失败
        if (![fmdbHelper open]) {
            NSLog(@"数据库打开失败");
            return;
        }
        //为数据库设置缓存，提高查询效率
        [fmdbHelper setShouldCacheStatements:YES];
        //判断数据库中是否已经存在这个表，如果不存在则创建该表
        if(![fmdbHelper tableExists:@"UserInfo"])
        {
            [fmdbHelper executeUpdate:@"CREATE TABLE UserInfo (userName TEXT, userPwd INTEGER, loginDate TEXT) "];
            NSLog(@"创建完成");
        }
        
    });
    return fmdbHelper;
}

/**
 *  插入用户信息
 *
 *  @param userInfo 用户信息
 */
- (void)insertWithUserInfo:(GGSUserInfo *)userInfo {
    NetFMDBHelper *dbHelper = [NetFMDBHelper sharFMDBHelper];
    if ([dbHelper open]) {
        // 先查询是否存在相同的账户人
        NSString *requeryString = @"SELECT * FROM UserInfo WHERE userName = ?";
        FMResultSet *result = [dbHelper executeQuery:requeryString, userInfo.userName];
        if ([result next]) { // 当前账户人存在更新数据
            NSString *updateString = [NSString stringWithFormat:@"UPDATE UserInfo SET userPwd = ?, loginDate = ? Where userName = %@", userInfo.userName];
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [formater setLocale:[NSLocale localeWithLocaleIdentifier:@"ZH-CN"]];
            NSString *userLoginDate = [formater stringFromDate:userInfo.userLoginDate];
            [dbHelper executeUpdate:updateString, userInfo.userPwd, userLoginDate];
        } else {  // 当前账户人不存在插入数据
            NSString *insertString = @"INSERT INTO UserInfo (userName, userPwd, loginDate) VALUES (?, ?, ?)";
            [dbHelper executeUpdate:insertString, userInfo.userName, userInfo.userPwd, userInfo.userLoginDate];
        }
        [dbHelper close];
    }
}

/**
 *  通过用户名删除用户信息
 *
 *  @param userName 用户名
 */
- (void)deleteUserInfoWithUserName:(NSString *)userName {
    NetFMDBHelper *dbHelper = [NetFMDBHelper sharFMDBHelper];
    if ([dbHelper open]) {
        // 根据用户名删除用户信息
        NSString *deleteString = @"DELETE FROM UserInfo WHERE userName = ?";
        [dbHelper executeUpdate:deleteString, userName];
        [dbHelper close];
    }
}

/**
 *  根据用户明查询查询登录是否过期
 *
 *  @param userName 用户名
 *
 *  @return 登录是否过期的状态
 */
- (BOOL)isLoginValiableWithUserName:(NSString *)userName {
    NetFMDBHelper *dbHelper = [NetFMDBHelper sharFMDBHelper];
    NSString *loginDate = [dbHelper userLastLoginDateWithUserName:userName];
    if ([loginDate isEqualToString:@""] || loginDate == nil) {
        return NO;
    }
    
    // 和当前日期进行比较
    // 最后一次登录时间
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formater setLocale:[NSLocale localeWithLocaleIdentifier:@"ZH-CN"]];
    NSDate *lastDate = [formater dateFromString:loginDate];
    // 当前时间
    NSDate *nowDate = [NSDate date];
    NSTimeInterval value = [nowDate timeIntervalSinceDate:lastDate];
    int day = ABS(value) / (60 * 60 * 24 * 30);
    if (day >= 1) {
        return NO;
    } else {
        return YES;
    }
}

/**
 *  根据用户名获取最新的登录日期
 *
 *  @param userName 用户名
 *
 *  @return 登陆日期
 */
- (NSString *)userLastLoginDateWithUserName:(NSString *)userName {
    NetFMDBHelper *dbHelper = [NetFMDBHelper sharFMDBHelper];
    if ([dbHelper open]) {
        NSString *selectString = @"SELECT * FROM UserInfo WHERE userName = ?";
        FMResultSet *result = [dbHelper executeQuery:selectString, userName];
        
        NSString *loginDate = @"";
        if ([result next]) {
            loginDate = [result stringForColumn:@"loginDate"];
        }
        return loginDate;
    } else {
        return @"";
    }
}

/**
 *  根据用户名查询密码
 *
 *  @param userName 用户名
 *
 *  @return 密码
 */
- (NSString *)queryUserPwdWithUserName:(NSString *)userName {
    NetFMDBHelper *dbHelper = [NetFMDBHelper sharFMDBHelper];
    if ([dbHelper open]) {
        NSString *selectString = @"SELECT * FROM UserInfo WHERE userName = ?";
        FMResultSet *result = [dbHelper executeQuery:selectString, userName];
        NSString *userPwd = @"";
        if ([result next]) {
            userPwd = [result stringForColumn:@"userPwd"];
        } else {
            userPwd = @"";
        }
        return userPwd;
    } else {
        return @"";
    }
}

/**
 *  判断当前账户是否存在
 *
 *  @param userName 账户名
 *
 *  @return 状态
 */
- (BOOL)isExesitWithUserName:(NSString *)userName {
    NetFMDBHelper *dbHelper = [NetFMDBHelper sharFMDBHelper];
    if ([dbHelper open]) {
        NSString *selectString = @"SELECT * FROM UserInfo WHERE userName = ?";
        FMResultSet *result = [dbHelper executeQuery:selectString, userName];
        BOOL state = NO;
        if ([result next]) {
           NSString *userPwd = [result stringForColumn:@"userPwd"];
            if ([NSString zm_isEffectString:userPwd]) {
                state = YES;
            } else {
                state = NO;
            }
        } else {
            state = NO;
        }
        return state;
    } else {
        return NO;
    }
}

@end
