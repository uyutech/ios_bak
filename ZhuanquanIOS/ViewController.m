//
//  ViewController.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/4/25.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "Masonry.h"
#import "UIColor+Hex.h"
#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIView *view = [[UIView alloc] init];
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    
    view.backgroundColor = [UIColor colorWithHexString:@"#4c8daf"];
    
    [self.view addSubview:view];
    
    
//    
//    __weak __typeof(&*self) weakSelf = self;
//    
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
//    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
