//
//  ViewController.m
//  GGSLoginDemo
//
//  Created by zm on 16/4/26.
//  Copyright © 2016年 zhM. All rights reserved.
//

#import "ViewController.h"
#import "GGSLoginViewController.h"
#import "ZHMNavigationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *handelBtn = [UIButton zm_createButtonWithTitle:@"登录"
                                               titleColor:[UIColor whiteColor]
                                          backgroundColor:[UIColor grayColor]
                                                     font:18
                                                      target:self
                                                      action:@selector(handelAction)];

    [self.view addSubview:handelBtn];
    
    __weak typeof(self) weakSelf = self;
    [handelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)handelAction {
    GGSLoginViewController *loginVC = [[GGSLoginViewController alloc] init];
    ZHMNavigationController *navigationC = [[ZHMNavigationController alloc] initWithRootViewController:loginVC];
    [self.navigationController presentViewController:navigationC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
