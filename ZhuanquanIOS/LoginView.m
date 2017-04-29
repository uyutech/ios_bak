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
@property (nonatomic, weak) UIButton *selectedButton;

@property (nonatomic, weak) UIView *loginPanel;
@property (nonatomic, weak) UIView *resetPanel;
@property (nonatomic, weak) UIView *regPanel;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self buildLoginFrame];
        [self buildLoginTab];
        [self buildLoginPanel];
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
    
    UIButton *loginTabButton = [self createTabButton:@"登录"];
    UIButton *regTabButton = [self createTabButton:@"注册"];
    UIView *active = [[UIView alloc] init];
    
    active.backgroundColor = COLOR_DARK_BLUE;
    
    _loginTabButton = loginTabButton;
    _regTabButton = regTabButton;
    _active = active;

    [_loginFrame addSubview:loginTabButton];
    [_loginFrame addSubview:_regTabButton];
    [_loginFrame addSubview:active];
    
    [loginTabButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginFrame).with.offset(0);
        make.left.equalTo(_loginFrame.mas_left).with.offset(0);
        make.right.equalTo(_regTabButton.mas_left).with.offset(0);
        make.width.equalTo(_regTabButton);
        make.height.mas_equalTo(46);
    }];
    
    [_regTabButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginFrame).with.offset(0);
        make.left.equalTo(loginTabButton.mas_right).with.offset(0);
        make.right.equalTo(_loginFrame.mas_right).with.offset(0);
        make.width.equalTo(loginTabButton);
        make.height.mas_equalTo(46);
    }];
    
    [self setSelected:loginTabButton];
    
    [loginTabButton addTarget:self action:@selector(setSelected:) forControlEvents:UIControlEventTouchUpInside];
    [regTabButton addTarget:self action:@selector(setSelected:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buildLoginPanel {
    
    UIView *loginPanel = [[UIView alloc] init];
    
    UITextField *passport = [self createTextField:@"请输入手机号"];
    UITextField *password = [self createTextField:@"请输入密码"];
    
    password.secureTextEntry = YES;
    
    UIButton *forgetButton = [[UIButton alloc] init];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton setTitleColor:COLOR_DARK_BLUE forState:UIControlStateNormal];
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:13];
    forgetButton.titleLabel.textAlignment = NSTextAlignmentRight;
    
    UIButton *loginSubmitButton = [self createSubmitButton:@"登 录"];
    
    _passport = passport;
    _password = password;
    _forgetButton = forgetButton;
    _loginSubmitButton = loginSubmitButton;
    _loginPanel = loginPanel;
    
    [loginPanel addSubview:passport];
    [loginPanel addSubview:password];
    [loginPanel addSubview:forgetButton];
    [loginPanel addSubview:loginSubmitButton];
    [self addSubview:loginPanel];
    
    [loginPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginFrame).with.offset(52);
        make.left.equalTo(_loginFrame).with.offset(0);
        make.right.equalTo(_loginFrame).with.offset(0);
        make.height.mas_greaterThanOrEqualTo(_loginFrame.mas_height);
    }];
    
    [passport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginPanel).with.offset(0);
        make.left.equalTo(loginPanel).with.offset(18);
        make.right.equalTo(loginPanel).with.offset(-18);
        make.height.mas_equalTo(40);
    }];
    
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passport.mas_bottom).with.offset(10);
        make.left.equalTo(loginPanel).with.offset(18);
        make.right.equalTo(loginPanel).with.offset(-18);
        make.height.mas_equalTo(40);
    }];
    
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).with.offset(10);
        make.right.equalTo(loginPanel).with.offset(-18);
        make.width.mas_greaterThanOrEqualTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [loginSubmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).with.offset(36);
        make.left.equalTo(loginPanel).with.offset(18);
        make.right.equalTo(loginPanel).with.offset(-18);
        make.height.mas_equalTo(40);
    }];
}

- (void)buildRegPanel {
    
}

- (void)buildResetPasswordPanel {
    
}

- (UITextField *)createTextField:(NSString *)withPlaceholder {
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = COLOR_INPUT_BG;
    textField.layer.cornerRadius = 5.0f;
    [textField setPlaceholder:withPlaceholder ?: @""];
    [textField setTextColor:COLOR_DARK_BLUE];
    [textField setValue:COLOR_LIGHT_BLUE forKeyPath:@"_placeholderLabel.textColor"];
    [textField setFont:[UIFont systemFontOfSize:14]];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    return textField;
}

- (UIButton *)createTabButton:(NSString *)title {
    
    UIButton *tabButton = [[UIButton alloc] init];
    [tabButton setTitle:title forState: UIControlStateNormal];
    [tabButton setTitleColor:COLOR_DARK_BLUE forState:UIControlStateSelected];
    [tabButton setTitleColor:COLOR_LIGHT_BLUE forState:UIControlStateNormal];
    tabButton.titleLabel.font = [UIFont systemFontOfSize:16];
    tabButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return tabButton;
}

- (UIButton *)createSubmitButton:(NSString *)title {
    
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = COLOR_DARK_BLUE;
    button.layer.cornerRadius = 20.0f;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    return button;
}

/// User Actions

- (void)setSelected:(UIButton *)target {
    
    [_active mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(target.mas_bottom).with.offset(-8);
        make.centerX.mas_equalTo(target.mas_centerX);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(2);
    }];
    
    [_loginBg mas_updateConstraints:^(MASConstraintMaker *make) {
        if (target == _regTabButton) {
            make.top.offset(-10);
        } else {
            make.top.offset(0);
        }
    }];
    
    __weak __typeof(&*self) weakSelf = self;
    
    if (_selectedButton != nil) {
        [_selectedButton setSelected:NO];
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
    
    [target setSelected:YES];
    _selectedButton = target;
}

@end
