//
//  ErrorTipsView.h
//  ZhuanquanIOS
//
//  Created by ydream on 2017/5/30.
//  Copyright © 2017年 ydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorTipsView : UIView

- (void)setMessage:(NSString *_Nonnull)message highlightWithString:(NSArray * _Nullable)arrayString;
- (void)hideMessage;

@end
