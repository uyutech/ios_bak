//
//  LoginViewController.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/4/27.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "UIColor+Hex.h"
#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController ()

@property (nonatomic, weak) LoginView *loginView;

@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#4c8daf"];
    self.view.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    LoginView *loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:loginView];
    
    [loginView.closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    [loginView.loginSubmitButton addTarget:self action:@selector(loginSubmit:) forControlEvents:UIControlEventTouchUpInside];

    _loginView = loginView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma User Actions

- (void)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginSubmit:(id)sender {
    [_loginView.errorTips setMessage:@"用户名与密码不匹配哟" highlightWithString:@[@"用户名",@"密码"]];
}

@end
