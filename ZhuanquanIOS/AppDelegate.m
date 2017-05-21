//
//  AppDelegate.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/4/25.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SSZipArchive.h"
#import "OHHTTPStubs.h"
#import "AppConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self copyFiles];
    
    [self filterURLRequest];
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
    
    [WeiboSDK registerApp:@"890459019"];
    
    return YES;
}

- (void)copyFiles {
    NSString *homeDirectory = NSHomeDirectory();
    NSString *h5Bundle = [[NSBundle mainBundle] pathForResource:@"h5" ofType:@"zip"];
    NSString *h5Directory = [homeDirectory stringByAppendingString: @"/Documents/zhuanquan_h5"];
    NSString *h5HomeBundle = [h5Directory stringByAppendingPathComponent: @"h5.zip"];
    
    NSLog(@"home dir: %@", homeDirectory);
    NSLog(@"bundle dir: %@", h5Bundle);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:h5Directory] == NO) {
        NSLog(@"no dir: %@", h5Directory);
        [[NSFileManager defaultManager] createDirectoryAtPath:h5Directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:h5HomeBundle] == NO) {
        NSError *err = nil;
        if ([[NSFileManager defaultManager] copyItemAtPath:h5Bundle toPath:h5HomeBundle error:&err] == NO) {
            NSLog(@"copy file failed: %@", [err localizedDescription]);
        }
        [SSZipArchive unzipFileAtPath:h5HomeBundle toDestination:h5Directory overwrite:YES password:nil error:nil];
    }
}

- (void)filterURLRequest {

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        
        NSPredicate *matchZQ = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZQ_DOMAIN(@".*")];
        
        if ([matchZQ evaluateWithObject:request.URL.absoluteString] == YES) {
            
            NSPredicate *matchJSON = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZQ_DOMAIN(@".+\\.json\\?*.*")];
            
            if ([matchJSON evaluateWithObject:request.URL.absoluteString] == YES) {
                return NO;
            } else {
                return YES;
            }
        } else {
            return NO;
        }

    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        
//        NSLog(@"req url ==== %@", request.URL.absoluteString);

        NSString *path = [request.URL.absoluteString substringFromIndex:[request.URL.absoluteString rangeOfString:ZQ_MAIN_DOMAIN].length];
        NSArray *newPath = [path componentsSeparatedByString:@"?"];
    
        NSString *h5Directory = [NSHomeDirectory() stringByAppendingString: @"/Documents/zhuanquan_h5"];
        NSString *entryFile = [h5Directory stringByAppendingPathComponent: newPath[0]];
    
//        NSString *entryFile = @"/Users/ydream/Desktop/test.html";
        return [OHHTTPStubsResponse responseWithFileAtPath:entryFile statusCode:200 headers:nil];
    }];
}

// 9.0 后才生效
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return [WeiboSDK handleOpenURL:url delegate:(id<WeiboSDKDelegate>)self];
}

# pragma mark 9.0之前
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WeiboSDK handleOpenURL:url delegate:(id<WeiboSDKDelegate>)self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    return [WeiboSDK handleOpenURL:url delegate:(id<WeiboSDKDelegate>)self];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request { //向微博发送请求
    NSLog(@" %@",request.class);
}

/**
 
 微博分享  与 微博登录，成功与否都会走这个方法。 用户根据自己的业务进行处理。
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBAuthorizeResponse.class]) { //微博登录的回调
        
        NSDictionary *dic = (NSDictionary *) response.userInfo;
        NSLog(@"userinfo %@",dic);

//        if ([_weiboDelegate respondsToSelector:@selector(weiboLoginByResponse:)]) {
//            [_weiboDelegate weiboLoginByResponse:response];
//        }

    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
