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
#import "LoginManager.h"
#import "WeiboSDK.h"

@interface LoginViewController ()

@property (nonatomic, weak) LoginView *loginView;

@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#4c8daf"];
    self.view.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    
    LoginView *loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    loginView.delegate = self;
    
    [self.view addSubview:loginView];
    
    [loginView.closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];

    _loginView = loginView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark User Actions

- (void)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginSubmit:(id)sender {
    
    if ([_loginView.passport.text isEqualToString:@""] || [_loginView.password.text isEqualToString:@""]) {
        [_loginView.errorTips setMessage:@"用户名与密码不为空哟" highlightWithString:@[@"用户名",@"密码"]];
        return;
    }
    
    [[LoginManager manager] loginWithUsername:_loginView.passport.text password:_loginView.password.text verifyCode:nil success:^(id  _Nullable data) {
        [self.navigationController popViewControllerAnimated:NO];
    } failure:^(id  _Nullable error) {
        if (error != nil) {
            [_loginView.errorTips setMessage:@"用户名与密码不匹配哟" highlightWithString:@[@"用户名",@"密码"]];
        } else {
            [_loginView.errorTips setMessage:@"出错啦，请再试试哟" highlightWithString:nil];
        }
    }];
}

- (void)regSubmit:(id)sender {

    if ([_loginView.regPassport.text isEqualToString:@""] || [_loginView.regPassword.text isEqualToString:@""]) {
        [_loginView.errorTips setMessage:@"用户名与密码不为空哟" highlightWithString:@[@"用户名",@"密码"]];
        return;
    }
    
    if ([_loginView checkMobile:_loginView.regPassport.text] == NO) {
        [_loginView.errorTips setMessage:@"手机号码格式有错误" highlightWithString:@[@"手机号码",@"有错误"]];
        return;
    }
    
    if (_loginView.regPassword.text.length < 6) {
        [_loginView.errorTips setMessage:@"密码请输入至少6位" highlightWithString:@[@"密码",@"至少6位"]];
        return;
    }
    
    if ([_loginView.regPasscode.text isEqualToString:@""]) {
        [_loginView.errorTips setMessage:@"验证码输入不为空哦" highlightWithString:@[@"验证码"]];
        return;
    }
    
    [[LoginManager manager] registerWithMobile:_loginView.regPassport.text
                                      password:_loginView.regPassword.text
                                    verifyCode:_loginView.regPasscode.text success:^(id  _Nullable data) {
        [self.navigationController popViewControllerAnimated:NO];
    } failure:^(id  _Nullable error) {
        if (error != nil) {
            [_loginView.errorTips setMessage:@"验证码输入有误哦" highlightWithString:@[@"验证码",@"有误"]];
        } else {
            [_loginView.errorTips setMessage:@"出错啦，请再试试哟" highlightWithString:nil];
        }
    }];
}

- (void)getMobileCode:(NSString *)mobile typeOfCode:(id)type {

    if ([_loginView checkMobile:mobile] == NO) {
        [_loginView.errorTips setMessage:@"手机号码格式有错误" highlightWithString:@[@"手机号码",@"有错误"]];
        return;
    }
    
    [[LoginManager manager] sendRegSms:mobile success:^(id  _Nullable data) {
        NSLog(@"send mobile: %@ success", mobile);
    } failure:^(id  _Nullable error) {
        [_loginView.errorTips setMessage:@"验证码发送失败了" highlightWithString:nil];
    }];
}

- (void)loginWithWeiboSDK:(id)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    request.scope = @"all";
    request.userInfo = nil;
    [WeiboSDK sendRequest:request];
}

@end
