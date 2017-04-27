//
//  ViewController.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/4/25.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "Masonry.h"
#import "UIColor+Hex.h"
#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    
    view.backgroundColor = [UIColor colorWithHexString:@"#4c8daf"];
    
    [self.view addSubview:view];

    LoginViewController *loginVC = [[LoginViewController alloc] init];

    [self.view addSubview:loginVC.view];

    [loginVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(20);
        make.size.mas_equalTo(loginVC.view.frame.size);
        make.centerX.equalTo(view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
