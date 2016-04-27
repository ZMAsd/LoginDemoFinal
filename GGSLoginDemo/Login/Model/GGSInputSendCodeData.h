//
//  GGSInputSendCodeData.h
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGSInputData.h"

@interface GGSInputSendCodeData : GGSInputData

@property (nonatomic, copy) NSString *sendCodeString;

- (instancetype)initWithLeftBtnTitle:(NSString *)leftBtnTitle
                          placeTitle:(NSString *)placeTitle
                        keyBoardType:(UIKeyboardType)keyBoardType
                          isSecurity:(BOOL)isSecurity
                      sendCodeString:(NSString *)sendCodeString;

+ (instancetype)inputDataWithLeftBtnTitle:(NSString *)leftBtnTitle
                               placeTitle:(NSString *)placeTitle
                             keyBoardType:(UIKeyboardType)keyBoardType
                               isSecurity:(BOOL)isSecurity
                           sendCodeString:(NSString *)sendCodeString;


@end
