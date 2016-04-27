//
//  GGSRegisterViewController.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "GGSRegisterViewController.h"
#import "GGSCustomLoginCell.h"
#import "GGSInputData.h"
#import "GGSInputSendCodeData.h"
#import "NetFMDBHelper.h"
#import "GGSUserInfo.h"

typedef NS_ENUM(NSInteger, GGSInputCellType) {
    GGSInputCellTypeUserName = 0,
    GGSInputCellTypeValicode,
    GGSInputCellTypePwd,
    GGSInputCellTypeConfirmPwd,
};

@interface GGSRegisterViewController ()
<UITableViewDataSource,
UITableViewDelegate>
// 表单
@property (nonatomic, weak) UITableView *tableView;
// 立即注册按钮
@property (nonatomic, weak) UIButton *registerSoonBtn;
// 静态数据
@property (nonatomic, strong) NSMutableArray *staticDataArray;
// 验证码
@property (nonatomic, copy) NSString *valiCodeString;

@end

@implementation GGSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MZColor(239, 239, 244);
    
    [self p_setupSubViews];
}

#pragma mark - 底部点击事件处理
- (void)handelAction {
    // 获取相关控件以及显示字段
    UITextField *userPhoneT = [self cellSubTextFieldWithinputCellType:GGSInputCellTypeUserName];
    UITextField *valicodeT = [self cellSubTextFieldWithinputCellType:GGSInputCellTypeValicode];
    UITextField *passwordT = [self cellSubTextFieldWithinputCellType:GGSInputCellTypePwd];
    UITextField *confirmPwdT = [self cellSubTextFieldWithinputCellType:GGSInputCellTypeConfirmPwd];
    
    // 用户名
    NSString *userName = userPhoneT.text;
    // 验证码
    NSString *valicode = valicodeT.text;
    // 密码
    NSString *passWord = passwordT.text;
    // 验证密码
    NSString *confirmPwd = confirmPwdT.text;
    
    // 相关位数判断 1 验证手机号是否已注册, 格式是否正确 2 验证码是否有效 3 两次输入密码是否一致 4 完成
    if (_registerViewConttrollerType == GGSRegisterViewControllerTypeRegiste) {
        if ([NSString zm_validateMobileNumber:userName]) {
            NetFMDBHelper *dbHelper = [NetFMDBHelper sharFMDBHelper];
            if ([dbHelper isExesitWithUserName:userName]) { // 检测账号是否已注册
                [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
                [SVProgressHUD showImage:nil status:@"当前账户已注册"];
            } else {
                // 生成验证码
                if (_valiCodeString == nil) {
                    [SVProgressHUD setMinimumDismissTimeInterval:3.0f];
                    NSString *valideCodeString = [self p_productValicode];
                    [SVProgressHUD showInfoWithStatus:valideCodeString];
                    _valiCodeString = valideCodeString;
                }
                // 验证信息一致
                if ([_valiCodeString isEqualToString:valicode]) {
                    if ([passWord isEqualToString:confirmPwd]) { // 两次输入密码是否一致
                        GGSUserInfo *userInfo = [GGSUserInfo userInfoWithUserName:userName userPwd:passWord userLoginDate:[NSDate date]];
                        [dbHelper insertWithUserInfo:userInfo];
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
                        [SVProgressHUD showErrorWithStatus:@"验证码输入错误"];
                    }
                } else {
                    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
                    [SVProgressHUD showErrorWithStatus:@"验证码输入错误"];
                }
            }
        } else {
            [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
            [SVProgressHUD showImage:nil status:@"手机号格式错误请重新输入"];
        }
    } else {
        if ([NSString zm_validateMobileNumber:userName]) {
            NetFMDBHelper *dbHelper = [NetFMDBHelper sharFMDBHelper];
            if ([dbHelper isExesitWithUserName:userName]) { // 检测账号是否已注册
                // 生成验证码
                if (_valiCodeString == nil) {
                    [SVProgressHUD setMinimumDismissTimeInterval:3.0f];
                    NSString *valideCodeString = [self p_productValicode];
                    [SVProgressHUD showInfoWithStatus:valideCodeString];
                    _valiCodeString = valideCodeString;
                }
                // 验证信息一致
                if ([_valiCodeString isEqualToString:valicode]) {
                    if ([passWord isEqualToString:confirmPwd]) { // 两次输入密码是否一致
                        GGSUserInfo *userInfo = [GGSUserInfo userInfoWithUserName:userName userPwd:passWord userLoginDate:[NSDate date]];
                        [dbHelper insertWithUserInfo:userInfo];
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
                        [SVProgressHUD showErrorWithStatus:@"验证码输入错误"];
                    }
                } else {
                    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
                    [SVProgressHUD showErrorWithStatus:@"验证码输入错误"];
                }
            } else {
                [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
                [SVProgressHUD showImage:nil status:@"当前账户未注册"];
            }
        } else {
            [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
            [SVProgressHUD showImage:nil status:@"手机号格式错误请重新输入"];
        }
    }
}

/**
 *  创建相关子控件
 */
- (void)p_setupSubViews {
    // tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.scrollEnabled = NO;
    tableView.sectionHeaderHeight = 0;
    tableView.sectionFooterHeight = 0;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    _tableView = tableView;
    // 立即注册
    UIButton *registerSoonBtn = [UIButton zm_createButtonWithTitle:@"立即注册"
                                                    titleColor:[UIColor whiteColor]
                                               backgroundColor:[UIColor blueColor]
                                                          font:18
                                                        target:self
                                                            action:@selector(handelAction)];
    registerSoonBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:registerSoonBtn];
    _registerSoonBtn = registerSoonBtn;
    
    // 设置显示的title
    NSString *showTitle = @"";
    if (_registerViewConttrollerType == GGSRegisterViewControllerTypeRegiste) {
        showTitle = @"注册";
    } else {
        showTitle = @"重置密码";
    }
    [_registerSoonBtn setTitle:showTitle forState:UIControlStateNormal];
    [_registerSoonBtn setTitle:showTitle forState:UIControlStateSelected];
    
    // 设置相关约束
    __weak typeof(self) weakSelft = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelft.view);
        make.height.equalTo(@220);
    }];
    [registerSoonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelft.tableView.mas_bottom).offset(15);
        make.left.equalTo(weakSelft.view.mas_left).offset(10);
        make.right.equalTo(weakSelft.view.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.staticDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GGSCustomLoginCell *cell = [GGSCustomLoginCell cellWithTableView:tableView indexPath:indexPath];
    cell.staticData = self.staticDataArray[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    [cell setValicodeBlock:^{
        NSString *valiCode = [weakSelf p_productValicode];
        [NSString stringWithFormat:@"你的SUSUGU验证码为:%@", valiCode];
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"验证码" message:[NSString stringWithFormat:@"你的SUSUGU验证码为:%@", valiCode] preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alertC dismissViewControllerAnimated:YES completion:nil];
            weakSelf.valiCodeString = valiCode;
        }]];
        [weakSelf.navigationController presentViewController:alertC animated:YES completion:nil];
    }];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (NSMutableArray *)staticDataArray {
    if (_staticDataArray == nil) {
        _staticDataArray = [NSMutableArray array];
        // 设置相关数据
        GGSInputData *inputData0 = [GGSInputData inputDataWithLeftBtnTitle:@"账号"
                                                                placeTitle:@"请输入用户名"
                                                              keyBoardType:UIKeyboardTypeNumberPad
                                                                isSecurity:NO];
        GGSInputData *inputData1 = [GGSInputSendCodeData inputDataWithLeftBtnTitle:@"验证码"
                                                                placeTitle:@"请输入验证码"
                                                              keyBoardType:UIKeyboardTypeNumberPad
                                                                isSecurity:NO
                                                                    sendCodeString:@"发送验证码"];
        GGSInputData *inputData2 = [GGSInputData inputDataWithLeftBtnTitle:@"新密码"
                                                                placeTitle:@"请输入密码"
                                                              keyBoardType:UIKeyboardTypeDefault
                                                                isSecurity:YES];
        GGSInputData *inputData3 = [GGSInputData inputDataWithLeftBtnTitle:@"确认密码"
                                                                placeTitle:@"请确认密码"
                                                              keyBoardType:UIKeyboardTypeDefault
                                                                isSecurity:YES];
        [_staticDataArray addObjectsFromArray:@[inputData0, inputData1, inputData2, inputData3]];
    }
    return _staticDataArray;
}

- (UITextField *)cellSubTextFieldWithinputCellType:(GGSInputCellType)inputCellType {
    GGSCustomLoginCell *cell = (GGSCustomLoginCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:inputCellType inSection:0]];
    UITextField *textField = cell.inputTextField;
    return textField;
}

- (void)setRegisterViewConttrollerType:(GGSResiterViewControllType)registerViewConttrollerType {
    _registerViewConttrollerType = registerViewConttrollerType;
        if (_registerViewConttrollerType == GGSRegisterViewControllerTypeRegiste) {
        self.navigationItem.title = @"立即注册";
    } else {
        self.navigationItem.title = @"忘记密码";
    }
}

/**
 *   生成验证码
 */
- (NSString *)p_productValicode {
    int valiCode = 0;
    for (int i = 4; i > 0; i--) {
        int a = pow(10, i) * (arc4random()%9 + 1);
        valiCode += a;
    }
    NSString *valiCodeString = [NSString stringWithFormat:@"%d", valiCode];
    return valiCodeString;
}

@end
