//
//  WebViewController.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/5/6.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "WebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface WebViewController ()

@property (nonatomic, weak) UIWebView *webview;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    webview.scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

    NSString *h5Directory = [NSHomeDirectory() stringByAppendingString: @"/Documents/zhuanquan_h5"];
    NSString *entryFile = [h5Directory stringByAppendingPathComponent: @"index.html"];
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:entryFile]]];
    
    [self.view addSubview:webview];
    
    _webview = webview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
