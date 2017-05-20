//
//  LoginManager.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/5/20.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "LoginManager.h"
#import "AFNetworking.h"

static LoginManager *manager = nil;

@implementation LoginManager

+ (instancetype)manager {
    if (manager == nil) {
        manager = [[self alloc] init];
    }
    return manager;
}

- (void)request:(NSString *)url
     parameters:(NSDictionary * _Nullable)params
        success:(void (^ _Nonnull)(id _Nullable data))success
        failure:(void (^ _Nullable)(id _Nullable error))failure {
    
    NSLog(@"request url == %@", url);
    
    [[AFHTTPSessionManager manager] GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success == nil) {
            return;
        }
        NSNumber *status = (NSNumber *)[responseObject valueForKey:@"success"];
        if ([status isEqual: @1]) {
            success([responseObject valueForKey:@"data"]);
        } else {
            if (failure != nil) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure != nil) {
            failure(nil);
        }
    }];
}

#pragma mark API

- (void)checkSession:(void (^)(id _Nullable))success failure:(void (^)(id _Nullable))failure {
    
    NSString *url = ZQ_DOMAIN(@"/login/sessionCheck.json");
    
    [self request:url parameters:nil success:success failure:failure];
}

- (void)sendRegSms:(NSString *)mobile
           success:(void (^ _Nonnull)(id _Nullable))success
           failure:(void (^ _Nullable)(id _Nullable))failure {
    
    NSString *url = ZQ_DOMAIN(@"/register/sendRegSms.json");
    
    NSDictionary *params = @{@"mobile": mobile};
    
    [self request:url parameters:params success:success failure:failure];
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
               verifyCode:(NSString * _Nullable)code
                  success:(void (^)(id _Nullable))success
                  failure:(void (^)(id _Nullable))failure {
    
    NSString *url = ZQ_DOMAIN(@"/login/loginByMobile.json");
    
    NSDictionary *params = @{@"userName": username, @"password": password};
    
    if (code != nil) {
        [params setValue:code forKey:@"verifyCode"];
    }
    
    [self request:url parameters:params success:success failure:failure];
}

- (void)loginWithOpenId:(NSString *)openid
                  token:(NSString *)token
            channelType:(NSString *)channelType
                success:(void (^)(id _Nullable))success
                failure:(void (^)(id _Nullable))failure {
    
    NSString *url = ZQ_DOMAIN(@"/login/loginByOpenId.json");
    
    NSDictionary *params = @{@"openId": openid, @"token": token, @"channelType": channelType};
    
    [self request:url parameters:params success:success failure:failure];
}

- (void)registerWithMobile:(NSString *)mobile
                  password:(NSString *)password
                verifyCode:(NSString *)code
                   success:(void (^)(id _Nullable))success
                   failure:(void (^)(id _Nullable))failure {
    
    NSString *url = ZQ_DOMAIN(@"/register/registerByMobile.json");
    
    NSDictionary *params = @{@"mobile": mobile, @"password": password, @"verifyCode": code};
    
    [self request:url parameters:params success:success failure:failure];
}

@end
