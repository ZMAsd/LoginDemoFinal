//
//  GGSInputSeePwdData.h
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGSInputData.h"

@interface GGSInputSeePwdData : GGSInputData
/**
 *  是否查看密码
 */
@property (nonatomic, assign) BOOL isSeePwd;

- (instancetype)initWithLeftBtnTitle:(NSString *)leftBtnTitle
                          placeTitle:(NSString *)placeTitle
                        keyBoardType:(UIKeyboardType)keyBoardType
                          isSecurity:(BOOL)isSecurity
                            isSeePwd:(BOOL)isSeePwd;

+ (instancetype)inputDataWithLeftBtnTitle:(NSString *)leftBtnTitle
                               placeTitle:(NSString *)placeTitle
                             keyBoardType:(UIKeyboardType)keyBoardType
                               isSecurity:(BOOL)isSecurity
                                 isSeePwd:(BOOL)isSeePwd;

@end
