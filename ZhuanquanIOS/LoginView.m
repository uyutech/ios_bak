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

@property (nonatomic, weak) UIView *mainBg;
@property (nonatomic, weak) UIView *mainFrame;
@property (nonatomic, weak) UIView *loginFrame;
@property (nonatomic, weak) UIView *active;
@property (nonatomic, weak) UIButton *selectedButton;

@property (nonatomic, weak) UIView *loginPanel;
@property (nonatomic, weak) UIView *resetPanel;
@property (nonatomic, weak) UIView *regPanel;

@end

@class AppDelegate;
@class UIApplication;

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self buildMainFrame];
        [self buildLoginTab];
        [self setSelected:_loginTabButton];
    }
    
    return self;
}

- (void)buildMainFrame {
    
    UIImageView *mainBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"portalBg"]];
    mainBg.contentMode = UIViewContentModeScaleAspectFit;
    
    UIView *mainFrame = [[UIView alloc] init];
    mainFrame.backgroundColor = [UIColor whiteColor];
    mainFrame.layer.cornerRadius = 5.0f;
    
    UIView *loginFrame = [[UIView alloc] init];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    
    ErrorTipsView *errorTips = [[ErrorTipsView alloc] init];
    
    _mainBg = mainBg;
    _mainFrame = mainFrame;
    _loginFrame = loginFrame;
    _errorTips = errorTips;
    _closeButton = closeButton;
    
    [self addSubview:mainBg];
    [self addSubview:mainFrame];
    [self addSubview:closeButton];
    [self addSubview:errorTips];
    [mainFrame addSubview:loginFrame];
    
    __weak __typeof(&*self) weakSelf = self;
    
    [mainBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(0);
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(150, 250));
    }];
    
    [mainFrame mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(loginFrame).with.offset(0);
    }];
    
    [errorTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mainBg.mas_right).with.offset(90);
        make.top.equalTo(mainBg.mas_top).with.offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(43);
    }];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
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
    [_loginFrame addSubview:regTabButton];
    [_loginFrame addSubview:active];
    
    [loginTabButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginFrame).with.offset(0);
        make.left.equalTo(_loginFrame.mas_left).with.offset(0);
        make.right.equalTo(regTabButton.mas_left).with.offset(0);
        make.width.equalTo(regTabButton);
        make.height.mas_equalTo(46);
    }];
    
    [regTabButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginFrame).with.offset(0);
        make.left.equalTo(loginTabButton.mas_right).with.offset(0);
        make.right.equalTo(_loginFrame.mas_right).with.offset(0);
        make.width.equalTo(loginTabButton);
        make.height.mas_equalTo(46);
    }];
    
    [loginTabButton addTarget:self action:@selector(setSelected:) forControlEvents:UIControlEventTouchUpInside];
    [regTabButton addTarget:self action:@selector(setSelected:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buildLoginPanel {
    
    UIView *loginPanel = [[UIView alloc] init];
    
    UITextField *passport = [self createTextField:@"请输入手机号" imageNamed:@"passportIcon"];
    UITextField *password = [self createTextField:@"请输入密码" imageNamed:@"passwordIcon"];
    
    UIButton *togglePassword = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [togglePassword setImage:[UIImage imageNamed:@"eyeOn"] forState:UIControlStateNormal];
    [togglePassword setImage:[UIImage imageNamed:@"eyeOff"] forState:UIControlStateSelected];
    [togglePassword addTarget:self action:@selector(toggleDisplayPassword:) forControlEvents:UIControlEventTouchUpInside];
    
    [password setRightView:togglePassword];
    [password setRightViewMode:UITextFieldViewModeAlways];
    [password setSecureTextEntry:YES];
    [passport setKeyboardType:UIKeyboardTypePhonePad];
    
    UIButton *forgetButton = [[UIButton alloc] init];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton setTitleColor:COLOR_DARK_BLUE forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(showResetPanel:) forControlEvents:UIControlEventTouchUpInside];
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:13];
    forgetButton.titleLabel.textAlignment = NSTextAlignmentRight;
    
    UIButton *loginSubmitButton = [self createButton:@"登 录"];
    
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
    
    [loginPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginFrame).with.offset(52);
        make.left.equalTo(_loginFrame).with.offset(0);
        make.right.equalTo(_loginFrame).with.offset(0);
        make.bottom.equalTo(loginSubmitButton.mas_bottom).with.offset(15);
    }];
}

- (void)buildRegPanel {
    
    UIView *regPanel = [[UIView alloc] init];
    UIView *regAgreementLine = [[UIView alloc] init];
    
    UITextField *passport = [self createTextField:@"请输入手机号" imageNamed:@"passportIcon"];
    UITextField *password = [self createTextField:@"请输入密码(至少6位)" imageNamed:@"passwordIcon"];
    UITextField *passcode = [self createTextField:@"请输入验证码" imageNamed:@"mobileIcon"];
    UIButton *regGetCodeButton = [self createButton:@"发送验证码" fontOfSize:13 borderRadius:4.0f];
    UIButton *regSubmitButton = [self createButton:@"注 册"];
    
    UILabel *regAgreementLabel = [[UILabel alloc] init];
    UIButton *regAgreementButton = [[UIButton alloc] init];
    
    UIButton *togglePassword = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [togglePassword setImage:[UIImage imageNamed:@"eyeOn"] forState:UIControlStateNormal];
    [togglePassword setImage:[UIImage imageNamed:@"eyeOff"] forState:UIControlStateSelected];
    [togglePassword addTarget:self action:@selector(toggleDisplayPassword:) forControlEvents:UIControlEventTouchUpInside];
    
    [password setRightView:togglePassword];
    [password setRightViewMode:UITextFieldViewModeAlways];
    [password setSecureTextEntry:YES];
    [passport setKeyboardType:UIKeyboardTypePhonePad];
    [passcode setKeyboardType:UIKeyboardTypeNumberPad];
    
    regAgreementLabel.text = @"绑定后意味着同意转圈的";
    regAgreementLabel.textColor = [UIColor lightGrayColor];
    regAgreementLabel.font = [UIFont systemFontOfSize:11];
    
    regAgreementButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [regAgreementButton setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [regAgreementButton setTitleColor:COLOR_DARK_BLUE forState:UIControlStateNormal];
    
    _regPassport = passport;
    _regPassword = password;
    _regPasscode = password;
    _regGetCodeButton = regGetCodeButton;
    _regSubmitButton = regSubmitButton;
    _regAgreementButton = regAgreementButton;
    _regPanel = regPanel;
    
    [regPanel addSubview:passport];
    [regPanel addSubview:password];
    [regPanel addSubview:passcode];
    [regPanel addSubview:regGetCodeButton];
    [regPanel addSubview:regSubmitButton];
    [regPanel addSubview:regAgreementLine];
    
    [regAgreementLine addSubview:regAgreementLabel];
    [regAgreementLine addSubview:regAgreementButton];
    
    [self addSubview:regPanel];
    
    [passport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(regPanel).with.offset(0);
        make.left.equalTo(regPanel).with.offset(18);
        make.right.equalTo(regPanel).with.offset(-18);
        make.height.mas_equalTo(40);
    }];
    
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passport.mas_bottom).with.offset(10);
        make.left.equalTo(regPanel).with.offset(18);
        make.right.equalTo(regPanel).with.offset(-18);
        make.height.mas_equalTo(40);
    }];
    
    [passcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).with.offset(10);
        make.left.equalTo(regPanel).with.offset(18);
        make.right.equalTo(regGetCodeButton.mas_left).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    [regGetCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).with.offset(10);
        make.left.equalTo(passcode.mas_right).with.offset(10);
        make.right.equalTo(regPanel).with.offset(-18);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(40);
    }];
    
    [regSubmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passcode.mas_bottom).with.offset(15);
        make.left.equalTo(regPanel).with.offset(18);
        make.right.equalTo(regPanel).with.offset(-18);
        make.height.mas_equalTo(40);
    }];
    
    [regAgreementLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(regSubmitButton.mas_bottom).with.offset(10);
        make.centerX.equalTo(regPanel.mas_centerX);
        make.height.mas_equalTo(12);
    }];
    
    [regAgreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(regAgreementLine).with.offset(0);
        make.left.equalTo(regAgreementLine).with.offset(18);
        make.right.equalTo(regAgreementButton.mas_left).with.offset(0);
        make.height.mas_equalTo(12);
    }];
    
    [regAgreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(regAgreementLine).with.offset(0);
        make.left.equalTo(regAgreementLabel.mas_right).with.offset(0);
        make.right.equalTo(regAgreementLine).with.offset(-18);
        make.height.mas_equalTo(12);
    }];
    
    [regPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginFrame).with.offset(52);
        make.left.equalTo(_loginFrame).with.offset(0);
        make.right.equalTo(_loginFrame).with.offset(0);
        make.bottom.equalTo(regAgreementLine.mas_bottom).with.offset(15);
    }];
}

- (void)buildResetPanel {
    
    __weak __typeof(&*self) weakSelf = self;
    
    UIView *resetPanel = [[UIView alloc] init];
    resetPanel.backgroundColor = [UIColor whiteColor];
    resetPanel.layer.cornerRadius = 5.0f;
    
    UILabel *title = [[UILabel alloc] init];
    [title setText:@"重置密码"];
    [title setFont:[UIFont systemFontOfSize:16]];
    [title setTextColor:COLOR_DARK_BLUE];
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(hideResetPanel:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *passport = [self createTextField:@"请输入手机号" imageNamed:@"passportIcon"];
    UITextField *password = [self createTextField:@"请输入新密码(至少6位)" imageNamed:@"passwordIcon"];
    UITextField *passcode = [self createTextField:@"请输入验证码" imageNamed:@"mobileIcon"];
    UIButton *resetGetCodeButton = [self createButton:@"发送验证码" fontOfSize:13 borderRadius:4.0f];
    UIButton *resetSubmitButton = [self createButton:@"确 认"];
    
    UIButton *togglePassword = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [togglePassword setImage:[UIImage imageNamed:@"eyeOn"] forState:UIControlStateNormal];
    [togglePassword setImage:[UIImage imageNamed:@"eyeOff"] forState:UIControlStateSelected];
    [togglePassword addTarget:self action:@selector(toggleDisplayPassword:) forControlEvents:UIControlEventTouchUpInside];
    
    [password setRightView:togglePassword];
    [password setRightViewMode:UITextFieldViewModeAlways];
    [password setSecureTextEntry:YES];
    [passport setKeyboardType:UIKeyboardTypePhonePad];
    [passcode setKeyboardType:UIKeyboardTypeNumberPad];
    
    _resetPassport = passport;
    _resetPassword = password;
    _resetPasscode = password;
    _resetGetCodeButton = resetGetCodeButton;
    _resetSubmitButton = resetSubmitButton;
    _resetPanel = resetPanel;
    
    [resetPanel addSubview:title];
    [resetPanel addSubview:backButton];
    [resetPanel addSubview:passport];
    [resetPanel addSubview:password];
    [resetPanel addSubview:passcode];
    [resetPanel addSubview:resetGetCodeButton];
    [resetPanel addSubview:resetSubmitButton];
    
    [self addSubview:resetPanel];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resetPanel.mas_top).with.offset(0);
        make.centerX.equalTo(resetPanel.mas_centerX);
        make.height.mas_equalTo(40);
    }];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resetPanel.mas_top).with.offset(0);
        make.left.equalTo(resetPanel.mas_left).with.offset(2);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [passport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resetPanel).with.offset(40);
        make.left.equalTo(resetPanel).with.offset(18);
        make.right.equalTo(resetPanel).with.offset(-18);
        make.height.mas_equalTo(40);
    }];
    
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passport.mas_bottom).with.offset(10);
        make.left.equalTo(resetPanel).with.offset(18);
        make.right.equalTo(resetPanel).with.offset(-18);
        make.height.mas_equalTo(40);
    }];
    
    [passcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).with.offset(10);
        make.left.equalTo(resetPanel).with.offset(18);
        make.right.equalTo(resetGetCodeButton.mas_left).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    [resetGetCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).with.offset(10);
        make.left.equalTo(passcode.mas_right).with.offset(10);
        make.right.equalTo(resetPanel).with.offset(-18);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(40);
    }];
    
    [resetSubmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passcode.mas_bottom).with.offset(15);
        make.left.equalTo(resetPanel).with.offset(18);
        make.right.equalTo(resetPanel).with.offset(-18);
        make.height.mas_equalTo(40);
    }];
    
    [resetPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(110);
        make.centerX.equalTo(weakSelf);
        make.width.mas_equalTo(300);
        make.bottom.equalTo(resetSubmitButton.mas_bottom).with.offset(15);
    }];
    
}

- (UITextField *)createTextField:(NSString *)withPlaceholder imageNamed:(NSString *)name {
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = COLOR_INPUT_BG;
    textField.layer.cornerRadius = 5.0f;
    [textField setPlaceholder:withPlaceholder ?: @""];
    [textField setTextColor:COLOR_DARK_BLUE];
    [textField setValue:COLOR_LIGHT_BLUE forKeyPath:@"_placeholderLabel.textColor"];
    [textField setFont:[UIFont systemFontOfSize:14]];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    image.frame = CGRectMake(0, 0, 40, 40);
    image.contentMode = UIViewContentModeCenter;
    [textField setLeftView:image];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    
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

- (UIButton *)createButton:(NSString *)title fontOfSize:(CGFloat)fontsize borderRadius:(CGFloat)radius {
    
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = COLOR_DARK_BLUE;
    button.layer.cornerRadius = radius;
    button.titleLabel.font = [UIFont systemFontOfSize:fontsize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    return button;
}

- (UIButton *)createButton:(NSString *)title {
    
    UIButton *button = [self createButton:title fontOfSize:15 borderRadius:20.0f];
    
    return button;
}

#pragma User Actions

- (void)setSelected:(UIButton *)target {
    
    __weak __typeof(&*self) weakSelf = self;
    
    if (target == _loginTabButton) {
        if (_regPanel != nil) {
            _regPanel.hidden = YES;
        }
        if (_loginPanel == nil) {
            [self buildLoginPanel];
        } else {
            _loginPanel.hidden = NO;
        }
    }
    
    if (target == _regTabButton) {
        if (_loginPanel != nil) {
            _loginPanel.hidden = YES;
        }
        if (_regPanel == nil) {
            [self buildRegPanel];
        } else {
            _regPanel.hidden = NO;
        }
    }
    
    [_loginFrame mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(110);
        make.centerX.equalTo(weakSelf);
        make.width.mas_equalTo(300);
        if (target == _regTabButton) {
            make.bottom.equalTo(_regPanel.mas_bottom).with.offset(0);
        } else {
            make.bottom.equalTo(_loginPanel.mas_bottom).with.offset(0);
        }
    }];
    
    [self endEditing:YES];
    [self layoutIfNeeded];
    
    [_active mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(target.mas_bottom).with.offset(-8);
        make.centerX.mas_equalTo(target.mas_centerX);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(2);
    }];
    
    [_mainBg mas_updateConstraints:^(MASConstraintMaker *make) {
        if (target == _regTabButton) {
            make.top.offset(-15);
        } else {
            make.top.offset(0);
        }
    }];
    
    if (_selectedButton != nil) {
        [_selectedButton setSelected:NO];
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf layoutIfNeeded];
        }];
    }

    [_errorTips hideMessage];
    
    [target setSelected:YES];
    _selectedButton = target;
}

- (void)toggleDisplayPassword:(UIButton *)target {
    
    BOOL state = NO;
    UITextField *password = nil;
    
    if (_loginPanel.hidden == NO) {
        password = _password;
    } else {
        password = _regPassword;
    }
    
    if (_resetPanel && _resetPanel.hidden == NO) {
        password = _resetPassword;
    }
    
    state = password.secureTextEntry;
    [password setSecureTextEntry:!state];
    [target setSelected: state];
}

- (void)showResetPanel:(UIButton *)target {
    if (_resetPanel == nil) {
        [self buildResetPanel];
    } else {
        _resetPanel.hidden = NO;
    }
}

- (void)hideResetPanel:(UIButton *)target {
    if (_resetPanel != nil) {
        _resetPanel.hidden = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
