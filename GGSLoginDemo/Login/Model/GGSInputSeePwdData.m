
//
//  GGSInputSeePwdData.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "GGSInputSeePwdData.h"

@implementation GGSInputSeePwdData

- (instancetype)initWithLeftBtnTitle:(NSString *)leftBtnTitle
                          placeTitle:(NSString *)placeTitle
                        keyBoardType:(UIKeyboardType)keyBoardType
                          isSecurity:(BOOL)isSecurity
                            isSeePwd:(BOOL)isSeePwd
{
    self = [super initWithLeftBtnTitle:leftBtnTitle placeTitle:placeTitle keyBoardType:keyBoardType isSecurity:isSecurity];
    if (self) {
        _isSeePwd = isSeePwd;
    }
    return self;
}

+ (instancetype)inputDataWithLeftBtnTitle:(NSString *)leftBtnTitle
                               placeTitle:(NSString *)placeTitle
                             keyBoardType:(UIKeyboardType)keyBoardType
                               isSecurity:(BOOL)isSecurity
                                 isSeePwd:(BOOL)isSeePwd {
    GGSInputSeePwdData *inputSeePwdData = [[GGSInputSeePwdData alloc] initWithLeftBtnTitle:leftBtnTitle placeTitle:placeTitle keyBoardType:keyBoardType isSecurity:isSecurity isSeePwd:isSeePwd];
    return inputSeePwdData;
}

@end
