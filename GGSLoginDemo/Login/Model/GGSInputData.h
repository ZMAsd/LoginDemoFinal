//
//  GGSInputData.h
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGSInputData : NSObject
/**
 *  左边按钮显示的title
 */
@property (nonatomic, copy) NSString *leftBtnTitle;
/**
 *  textField占位符显示问题
 */
@property (nonatomic, copy) NSString *placeTitle;
/**
 *  键盘样式
 */
@property (nonatomic, assign) UIKeyboardType keyBoardType;
/**
 *  是否密码输入
 */
@property (nonatomic, assign) BOOL isSecurity;

/**
 *  <#Description#>
 *
 *  @param leftBtnTitle <#leftBtnTitle description#>
 *  @param placeTitle   <#placeTitle description#>
 *  @param keyBoardType <#placeTitle description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithLeftBtnTitle:(NSString *)leftBtnTitle
                          placeTitle:(NSString *)placeTitle
                        keyBoardType:(UIKeyboardType)keyBoardType
                          isSecurity:(BOOL)isSecurity;

/**
 *  <#Description#>
 *
 *  @param leftBtnTitle <#leftBtnTitle description#>
 *  @param placeTitle   <#placeTitle description#>
 *  @param keyBoardType <#placeTitle description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)inputDataWithLeftBtnTitle:(NSString *)leftBtnTitle
                               placeTitle:(NSString *)placeTitle
                             keyBoardType:(UIKeyboardType)keyBoardType
                               isSecurity:(BOOL)isSecurity;

@end
