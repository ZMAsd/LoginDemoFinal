//
//  GGSLoginViewController.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "GGSLoginViewController.h"
#import "GGSRegisterViewController.h"
#import "GGSCustomLoginCell.h"
#import "UIView+Factory.h"
#import "GGSInputData.h"
#import "GGSInputSeePwdData.h"
#import "GGSUserInfo.h"
#import "NetFMDBHelper.h"

typedef NS_ENUM(NSInteger, ZZSLoginCellType) {
    ZZSLoginCellTypeUserNmae = 0,
    ZZSLoginCellTypePassWord,
};

@interface GGSLoginViewController ()
<UITableViewDataSource,
UITableViewDelegate>

// 表单
@property (nonatomic, weak) UITableView *tableView;
// 注册按钮
@property (nonatomic, weak) UIButton *registerBtn;
// 忘记密码
@property (nonatomic, weak) UIButton *forgetPwdBtn;
// 登录
@property (nonatomic, weak) UIButton *loginBtn;
// 静态数组
@property (nonatomic, strong) NSMutableArray *staticDataArray;

@end

@implementation GGSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MZColor(239, 239, 244);
    self.navigationItem.title = @"登录";
    
    self.navigationController.navigationBar.translucent = NO;
    // 创建相关子控件
    [self p_setupSubViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.staticDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GGSCustomLoginCell *cell = [GGSCustomLoginCell cellWithTableView:tableView indexPath:indexPath];
    cell.staticData = self.staticDataArray[indexPath.row];
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

/**
 *  按钮点击事件
 *
 *  @param sender 被点击的按钮
 */
- (void)buttonClicked:(UIButton *)sender {
    if (_loginBtn == sender) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.f];
        
        UITextField *userNameT = [self cellSubTextFieldWithLoginCellType:ZZSLoginCellTypeUserNmae];
        NSString *userName = userNameT.text;
        UITextField *passwordT = [self cellSubTextFieldWithLoginCellType:ZZSLoginCellTypePassWord];
        NSString *password = passwordT.text;
        // 插入用户登录数据
        // 1 查询当前账户是否存在 2 查询密码是否正确 3返回
        NetFMDBHelper *dbHelper = [NetFMDBHelper sharFMDBHelper];
        BOOL state = [dbHelper isExesitWithUserName:userName];
        if (state) { // 用户名存在
            // 检查密码是否正确
            NSString *md5PwdString = [NSString md5:password];
            NSString *dbPwdString = [dbHelper queryUserPwdWithUserName:userName];
            // 判断密码是否正确
            if ([dbPwdString isEqualToString:md5PwdString]) { // 密码正确
//                [SVProgressHUD showSuccessWithStatus:@"密码正确"];
                // 结束键盘相应
                UIView *view = [self.view findfirstResponser];
                [view resignFirstResponder];
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            } else { // 密码错误
                [SVProgressHUD showErrorWithStatus:@"密码错误"];
            }
        } else { // 用户名不存在
            [SVProgressHUD showErrorWithStatus:@"当前账户不存在"];
        }
    } else {
        GGSRegisterViewController *registerVC = [[GGSRegisterViewController alloc] init];
        if (_registerBtn == sender) { // 注册
            registerVC.registerViewConttrollerType = GGSRegisterViewControllerTypeRegiste;
        } else { // 忘记密码
            registerVC.registerViewConttrollerType = GGSRegisterViewControllerTypeForgetPwd;
        }
        [self.navigationController pushViewController:registerVC animated:YES];
    }
}

- (UITextField *)cellSubTextFieldWithLoginCellType:(ZZSLoginCellType)loginCellType {
    GGSCustomLoginCell *cell = (GGSCustomLoginCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:loginCellType inSection:0]];
    UITextField *textField = cell.inputTextField;
    return textField;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_tableView endEditing:YES];
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
    UIButton *registerBtn = [UIButton zm_createButtonWithTitle:@"立即注册"
                                                    titleColor:[UIColor grayColor]
                                               backgroundColor:MZColor(239, 239, 244)
                                                          font:13
                                                        target:self
                                                        action:@selector(buttonClicked:)];
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:registerBtn];
    _registerBtn = registerBtn;
    // 忘记密码
    UIButton *forgetPwdBtn = [UIButton zm_createButtonWithTitle:@"忘记密码"
                                                     titleColor:[UIColor grayColor]
                                                backgroundColor:MZColor(239, 239, 244)
                                                           font:13
                                                         target:self
                                                         action:@selector(buttonClicked:)];
    forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:forgetPwdBtn];
    _forgetPwdBtn = forgetPwdBtn;
    // 登录
    UIButton *loginBtn = [UIButton zm_createButtonWithTitle:@"登录"
                                                 titleColor:[UIColor whiteColor]
                                            backgroundColor:[UIColor blueColor]
                                                       font:18
                                                     target:self
                                                     action:@selector(buttonClicked:)];
    loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:loginBtn];
    _loginBtn = loginBtn;
    
    // 设置相关约束
    __weak typeof(self) weakSelft = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(weakSelft.view);
        make.height.equalTo(@120);
    }];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelft.tableView.mas_bottom).offset(15);
        make.left.equalTo(weakSelft.view.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [_forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelft.tableView.mas_bottom).offset(15);
        make.right.equalTo(weakSelft.view.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelft.registerBtn.mas_bottom).offset(15);
        make.left.equalTo(weakSelft.view.mas_left).offset(10);
        make.right.equalTo(weakSelft.view.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
}

- (NSMutableArray *)staticDataArray {
    if (_staticDataArray == nil) {
        _staticDataArray = [NSMutableArray array];
        // 设置相关数据
        GGSInputData *inputData0 = [GGSInputData inputDataWithLeftBtnTitle:@"账号"
                                                                placeTitle:@"请输入用户名"
                                                              keyBoardType:UIKeyboardTypeNumberPad
                                                                isSecurity:NO];
        GGSInputData *inputData1 = [GGSInputSeePwdData inputDataWithLeftBtnTitle:@"登录密码"
                                                                placeTitle:@"请输入密码"
                                                              keyBoardType:UIKeyboardTypeDefault
                                                                isSecurity:YES
                                                                  isSeePwd:NO];
        [_staticDataArray addObjectsFromArray:@[inputData0, inputData1]];
    }
    return _staticDataArray;
}

@end
