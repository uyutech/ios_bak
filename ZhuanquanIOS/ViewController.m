//
//  ViewController.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/4/25.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "WebViewController.h"
#import "WeiboSDK.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    __weak __typeof(&*self) weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"打开登录面板" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(20, 60, 200, 20)];
    
    UIButton *button2 = [[UIButton alloc] init];
    [button2 setTitle:@"打开页面" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(openPage:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setFrame:CGRectMake(20, 100, 200, 20)];
    
    UIButton *button3 = [[UIButton alloc] init];
    [button3 setTitle:@"新浪SDK接入" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(callWeiboSDK:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 setFrame:CGRectMake(20, 140, 200, 20)];
    
    [self.view addSubview:button];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (void)login:(UIButton *)target {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)openPage:(id)sender {
    WebViewController *webviewVC = [[WebViewController alloc] init];
    [self.navigationController pushViewController:webviewVC animated:YES];
}

- (void)callWeiboSDK:(id)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    request.scope = @"all";
    request.userInfo = nil;
    [WeiboSDK sendRequest:request];
}

@end
