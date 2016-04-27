
//
//  GGSInputData.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "GGSInputData.h"

@implementation GGSInputData

/**
 *  <#Description#>
 *
 *  @param leftBtnTitle <#leftBtnTitle description#>
 *  @param placeTitle   <#placeTitle description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithLeftBtnTitle:(NSString *)leftBtnTitle
                          placeTitle:(NSString *)placeTitle
                        keyBoardType:(UIKeyboardType)keyBoardType
                          isSecurity:(BOOL)isSecurity {
    self = [super init];
    if (self) {
        _leftBtnTitle = leftBtnTitle;
        _placeTitle = placeTitle;
        _keyBoardType = keyBoardType;
        _isSecurity = isSecurity;
    }
    return self;
}

/**
 *  <#Description#>
 *
 *  @param leftBtnTitle <#leftBtnTitle description#>
 *  @param placeTitle   <#placeTitle description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)inputDataWithLeftBtnTitle:(NSString *)leftBtnTitle
                               placeTitle:(NSString *)placeTitle
                             keyBoardType:(UIKeyboardType)keyBoardType
                               isSecurity:(BOOL)isSecurity {
    GGSInputData *inputData = [[GGSInputData alloc] initWithLeftBtnTitle:leftBtnTitle
                                                              placeTitle:placeTitle keyBoardType:keyBoardType
                                                              isSecurity:isSecurity];
    return  inputData;
}

@end
