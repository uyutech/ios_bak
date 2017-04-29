//
//  LoginView.h
//  ZhuanquanIOS
//
//  Created by ydream on 2017/4/29.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR_DARK_BLUE [UIColor colorWithHexString:@"#4c8daf"]
#define COLOR_LIGHT_BLUE [UIColor colorWithHexString:@"#b4cfdd"]
#define COLOR_INPUT_BG [UIColor colorWithHexString:@"#edf3f7"]


@interface LoginView : UIView

@property (nonatomic, weak) UIButton *loginTabButton;
@property (nonatomic, weak) UIButton *regTabButton;
@property (nonatomic, weak) UIButton *forgetButton;

@property (nonatomic, weak) UIButton *loginSubmitButton;
@property (nonatomic, weak) UIButton *resetSubmitButton;
@property (nonatomic, weak) UIButton *regSubmitButton;

@property (nonatomic, weak) UITextField *passport;
@property (nonatomic, weak) UITextField *password;

@end
