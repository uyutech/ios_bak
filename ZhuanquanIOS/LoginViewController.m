//
//  LoginViewController.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/4/27.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoginView *loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:loginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
