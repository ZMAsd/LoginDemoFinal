

//
//  GGSInputSendCodeData.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "GGSInputSendCodeData.h"

@implementation GGSInputSendCodeData

- (instancetype)initWithLeftBtnTitle:(NSString *)leftBtnTitle
                          placeTitle:(NSString *)placeTitle
                        keyBoardType:(UIKeyboardType)keyBoardType
                          isSecurity:(BOOL)isSecurity
                      sendCodeString:(NSString *)sendCodeString {
    self = [super initWithLeftBtnTitle:leftBtnTitle placeTitle:placeTitle keyBoardType:keyBoardType isSecurity:isSecurity];
    if (self) {
        _sendCodeString = sendCodeString;
    }
    return self;
}

+ (instancetype)inputDataWithLeftBtnTitle:(NSString *)leftBtnTitle
                               placeTitle:(NSString *)placeTitle
                             keyBoardType:(UIKeyboardType)keyBoardType
                               isSecurity:(BOOL)isSecurity
                           sendCodeString:(NSString *)sendCodeString
{
    GGSInputSendCodeData *inputSendCodeData = [[GGSInputSendCodeData alloc] initWithLeftBtnTitle:leftBtnTitle placeTitle:placeTitle keyBoardType:keyBoardType isSecurity:isSecurity sendCodeString:sendCodeString];
    return inputSendCodeData;
}

@end
