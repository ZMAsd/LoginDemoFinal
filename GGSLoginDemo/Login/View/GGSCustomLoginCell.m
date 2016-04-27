//
//  GGSCustomLoginCell.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "GGSCustomLoginCell.h"
#import "GGSInputData.h"
#import "GGSInputSeePwdData.h"
#import "GGSInputSendCodeData.h"

@interface GGSCustomLoginCell()
// 左边的按钮
@property (nonatomic, weak) UIButton *leftBtn;
// 定时器
@property (nonatomic, strong) NSTimer *timer;
// 定时器剩余时间
@property (nonatomic, assign) NSInteger remainTime;
// 发送验证码按钮
@property (nonatomic, weak) UIButton *sendCodeBtn;

@end

@implementation GGSCustomLoginCell

- (void)setStaticData:(GGSInputData *)staticData {
    _staticData = staticData;
    // 设置键盘
    _inputTextField.placeholder = _staticData.placeTitle;
    _inputTextField.keyboardType = _staticData.keyBoardType;
    _inputTextField.secureTextEntry = _staticData.isSecurity;
    // 左边显示的文字
    [_leftBtn setTitle:_staticData.leftBtnTitle forState:UIControlStateNormal];
    [_leftBtn setTitle:_staticData.leftBtnTitle forState:UIControlStateSelected];
    
    [self setupRightSeePwd];
}

- (void)setupRightSeePwd {
    if ([_staticData isKindOfClass:[GGSInputSeePwdData class]] || [_staticData isKindOfClass:[GGSInputSendCodeData class]]) {
        _inputTextField.rightViewMode = UITextFieldViewModeAlways;
        if ([_staticData isKindOfClass:[GGSInputSeePwdData class]]) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            UISwitch *switchV = [[UISwitch alloc] init];
            switchV.on = YES;
            switchV.frame = CGRectMake(0, 0, 30, 30);
            [switchV addTarget:self action:@selector(switchChangeValue:) forControlEvents:UIControlEventValueChanged];
            [view addSubview:switchV];
            _inputTextField.rightView = view;
        } else {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            UIButton *button = [UIButton zm_createButtonWithTitle:@"发送验证码" titleColor:[UIColor whiteColor] backgroundColor:[UIColor blueColor] font:13 target:self action:@selector(sendCodeAction:)];
            button.frame = CGRectMake(0, 0, 90, 30);
            button.layer.cornerRadius = 15;
            button.layer.masksToBounds = YES;
            [view addSubview:button];
            _inputTextField.rightView = view;
            _sendCodeBtn = button;
        }
    } else {
        _inputTextField.rightViewMode = UITextFieldViewModeNever;
    }
}

#pragma makr - switch事件处理
- (void)switchChangeValue:(UISwitch *)sender {
    sender.on = sender.on ^ NO;
    _inputTextField.secureTextEntry = sender.on;
}

#pragma mark - 发送验证码
- (void)sendCodeAction:(UIButton *)sender {
//    if (_remainTime == 0) {
//        // 定时器相应处理
//        [self.timer invalidate];
//        self.timer = nil;
//        
//        [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
//        [sender setTitle:@"发送验证码" forState:UIControlStateSelected];
//        self.remainTime = 60;
//    } else {
//
//    }
    if (self.ValicodeBlock) {
        self.ValicodeBlock();
    }
    
   self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(reduceTimeAction:) userInfo:nil repeats:YES];
}

- (void)reduceTimeAction:(NSTimer *)timer {
    if (_remainTime == 0) {
        // 定时器相应处理
        [self.timer invalidate];
        self.timer = nil;
        
        [_sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateSelected];
        self.remainTime = 60;
        _sendCodeBtn.userInteractionEnabled = YES;
    } else {
        [_sendCodeBtn setTitle:[NSString stringWithFormat:@"剩余%lds", self.remainTime] forState:UIControlStateNormal];
        [_sendCodeBtn setTitle:[NSString stringWithFormat:@"剩余%lds", self.remainTime]  forState:UIControlStateSelected];
        _remainTime--;
        _sendCodeBtn.userInteractionEnabled = NO;
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
                        indexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"GGSCustomLoginCell";
    GGSCustomLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GGSCustomLoginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 创建相关UI SubViews控件
        [self p_setupSubViews];
        self.remainTime = 60;
    }
    return self;
}

#pragma mark - 创建SubViews
- (void)p_setupSubViews {
    UITextField *textField = [[UITextField alloc] init];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.returnKeyType = UIReturnKeyDone;
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = [UIFont systemFontOfSize:15];
    // 设置leftView
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    UIButton *button = [UIButton zm_createButtonWithTitle:@""
                                               titleColor:[UIColor grayColor]
                                          backgroundColor:[UIColor whiteColor]
                                                     font:15
                                                   target:nil
                                                   action:nil];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.frame = CGRectMake(15, 0, 70, 40);
    [view addSubview:button];
    textField.leftView = view;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.contentView addSubview:textField];
    _leftBtn = button;
    // 设置约束
    __weak typeof(self) weakSelf = self;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsZero);
    }];
    _inputTextField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField  resignFirstResponder];
    return YES;
}

@end
