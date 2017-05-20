//
//  LoginManager.h
//  ZhuanquanIOS
//
//  Created by ydream on 2017/5/20.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConfig.h"

@interface LoginManager : NSObject

+ (instancetype _Nullable)manager;

- (void)checkSession:(void(^_Nonnull)(id _Nullable data))success failure:(void(^ _Nullable)(id _Nullable error))failure;

- (void)sendRegSms:(NSString *_Nullable)mobile success:(void(^_Nonnull)(id _Nullable data))success failure:(void(^ _Nullable)(id _Nullable error))failure;

- (void)loginWithUsername:(NSString *_Nonnull)username password:(NSString *_Nonnull)password verifyCode:(NSString *_Nullable)code success:(void(^_Nonnull)(id _Nullable data))success failure:(void(^ _Nullable)(id _Nullable error))failure;

- (void)loginWithOpenId:(NSString *_Nonnull)openid token:(NSString *_Nonnull)token channelType:(NSString *_Nonnull)channelType success:(void(^_Nonnull)(id _Nullable data))success failure:(void(^ _Nullable)(id _Nullable error))failure;

- (void)registerWithMobile:(NSString *_Nonnull)mobile password:(NSString *_Nonnull)password verifyCode:(NSString *_Nonnull)code success:(void(^_Nonnull)(id _Nullable data))success failure:(void(^ _Nullable)(id _Nullable error))failure;

@end
