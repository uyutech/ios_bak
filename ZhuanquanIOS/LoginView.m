//
//  LoginView.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/4/29.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "masonry.h"
#import "UIColor+Hex.h"
#import "LoginView.h"


@interface LoginView ()

@property (nonatomic, weak) UIView *loginBg;
@property (nonatomic, weak) UIView *loginFrame;
@property (nonatomic, weak) UIView *active;
@property (nonatomic, weak) UILabel *loginLabel;
@property (nonatomic, weak) UILabel *regLabel;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self buildLoginFrame];
        [self buildLoginTab];
    }
    
    return self;
}

- (void)buildLoginFrame {

    UIImageView *loginBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"portalBg"]];
    loginBg.contentMode = UIViewContentModeScaleAspectFit;
    
    UIView *loginFrame = [[UIView alloc] init];
    loginFrame.backgroundColor = [UIColor whiteColor];
    loginFrame.layer.cornerRadius = 5.0f;
    
    _loginBg = loginBg;
    _loginFrame = loginFrame;
    
    [self addSubview:loginBg];
    [self addSubview:loginFrame];
    
    __weak __typeof(&*self) weakSelf = self;
    
    [loginBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(0);
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(150, 250));
    }];
    
    [loginFrame mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(110);
        make.centerX.equalTo(weakSelf);
        make.width.mas_equalTo(300);
        make.height.mas_greaterThanOrEqualTo(233);
    }];
}

- (void)buildLoginTab {
    
    UIColor *colorDarkBlue = [UIColor colorWithHexString:@"#4c8daf"];
    UIColor *colorLightBlue = [UIColor colorWithHexString:@"#d8e4eb"];
    
    UILabel *loginLabel = [[UILabel alloc] init];
    loginLabel.text = @"登录";
    loginLabel.font = [UIFont systemFontOfSize:16];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.textColor = colorDarkBlue;
    
    UILabel *regLabel = [[UILabel alloc] init];
    regLabel.text = @"注册";
    regLabel.font = [UIFont systemFontOfSize:16];
    regLabel.textAlignment = NSTextAlignmentCenter;
    regLabel.textColor = colorLightBlue;
    
    UIView *active = [[UIView alloc] init];
    active.backgroundColor = colorDarkBlue;
    
    _loginLabel = loginLabel;
    _regLabel = regLabel;
    _active = active;

    [_loginFrame addSubview:loginLabel];
    [_loginFrame addSubview:regLabel];
    [_loginFrame addSubview:active];
    
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginFrame).with.offset(0);
        make.left.equalTo(_loginFrame.mas_left).with.offset(0);
        make.right.equalTo(regLabel.mas_left).with.offset(0);
        make.width.equalTo(regLabel);
        make.height.mas_equalTo(46);
    }];
    
    [regLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginFrame).with.offset(0);
        make.left.equalTo(loginLabel.mas_right).with.offset(0);
        make.right.equalTo(_loginFrame.mas_right).with.offset(0);
        make.width.equalTo(loginLabel);
        make.height.mas_equalTo(46);
    }];
    
    [active mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginLabel.mas_bottom).with.offset(-8);
        make.centerX.mas_equalTo(loginLabel.mas_centerX);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(2);
    }];
}

@end
