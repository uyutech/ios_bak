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
@property WebViewJavascriptBridge *bridge;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    webview.scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSString *h5Directory = [NSHomeDirectory() stringByAppendingString: @"/Documents/zhuanquan_h5"];
    //    NSString *entryFile = [h5Directory stringByAppendingPathComponent: @"index.html"];
    NSString *entryFile = @"/Users/ydream/Desktop/test.html";
    
    NSLog(@"path: %@", h5Directory);
    
    _webview = webview;
    
    [self.view addSubview:webview];
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webview];
    [_bridge setWebViewDelegate: self];
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:entryFile]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_webview stringByEvaluatingJavaScriptFromString:@"window.test = 'abc';"];
}

@end
