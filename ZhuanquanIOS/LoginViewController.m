//
//  LoginViewController.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/4/27.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "masonry.h"
#import "LoginViewController.h"


@interface LoginViewController ()

@property (nonatomic, strong) UIView *loginFrame;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildLoginFrame];
    
}

- (void)buildLoginFrame {
    __weak __typeof(&*self) weakSelf = self;
    
    UIImageView *loginBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"portalBg"]];
    loginBg.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:loginBg];
    
    [loginBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(0);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(150, 250));
    }];
    
    _loginFrame = [[UIView alloc] init];
    _loginFrame.backgroundColor = [UIColor whiteColor];
    _loginFrame.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:_loginFrame];
    
    [_loginFrame mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(110);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(@300);
        make.height.mas_greaterThanOrEqualTo(@233);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
