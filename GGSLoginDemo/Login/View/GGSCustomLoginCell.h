//
//  GGSCustomLoginCell.h
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GGSInputData;

@interface GGSCustomLoginCell : UITableViewCell
/**
 *  输入框
 */
@property (nonatomic, weak) UITextField *inputTextField;

/**
 *  显示静态数据
 */
@property (nonatomic, strong) GGSInputData *staticData;
/**
 *  获取验证码
 */
@property (nonatomic, copy) void(^ValicodeBlock)();

+ (instancetype)cellWithTableView:(UITableView *)tableView
                        indexPath:(NSIndexPath *)indexPath;

@end
