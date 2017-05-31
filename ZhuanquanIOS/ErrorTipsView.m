//
//  ErrorTipsView.m
//  ZhuanquanIOS
//
//  Created by ydream on 2017/5/30.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import "ErrorTipsView.h"
#import "Masonry.h"

@interface ErrorTipsView ()

@property (nonatomic, weak) UILabel *message;

@end


@implementation ErrorTipsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        __weak __typeof(&*self) weakSelf = self;
        
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"errorTipsBg"]];
        [self addSubview:background];
        
        UILabel *message = [[UILabel alloc] init];
        message.font = [UIFont systemFontOfSize:12];
        message.textColor = [UIColor darkGrayColor];
        [self addSubview:message];
        
        _message = message;
        
        [message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
        }];
        
        CGAffineTransform rotate = CGAffineTransformRotate(self.transform, M_PI / 18);
        [self setTransform:rotate];
        
        self.hidden = YES;
    }
    
    return self;
}

- (void)setMessage:(NSString *_Nonnull)message highlightWithString:(NSArray * _Nullable)arrayString {
    NSMutableAttributedString *tempMsg = [[NSMutableAttributedString alloc] initWithString:message];
    if (arrayString != nil) {
        for (int i = 0; i < arrayString.count; i++) {
            NSRange rangeOfString = [message rangeOfString:arrayString[i]];
            [tempMsg addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rangeOfString];
        }
    }
    _message.attributedText = tempMsg;
    self.hidden = NO;
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideMessage) userInfo:nil repeats:NO];
}

- (void)hideMessage {
    _message.attributedText = nil;
    self.hidden = YES;
}

@end
