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
    
    UIButton *loginTabButton = [[UIButton alloc] init];
    [loginTabButton setTitle:@"登录" forState: UIControlStateNormal];
    [loginTabButton setTitleColor:colorDarkBlue forState:UIControlStateSelected];
    [loginTabButton setTitleColor:colorLightBlue forState:UIControlStateNormal];
    loginTabButton.titleLabel.font = [UIFont systemFontOfSize:16];
    loginTabButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *regTabButton = [[UIButton alloc] init];
    [regTabButton setTitle:@"注册" forState: UIControlStateNormal];
    [regTabButton setTitleColor:colorDarkBlue forState:UIControlStateSelected];
    [regTabButton setTitleColor:colorLightBlue forState:UIControlStateNormal];
    regTabButton.titleLabel.font = [UIFont systemFontOfSize:16];
    regTabButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *active = [[UIView alloc] init];
    active.backgroundColor = colorDarkBlue;
    
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

- (void)setSelected:(UIButton *)target {
    
    [target setSelected:YES];
    [_selectedButton setSelected:NO];

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
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
    
    _selectedButton = target;
}

@end
