//
//  HyInputBar.h
//
//  Created by HyanCat on 16/4/16.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HyInputBar;

@protocol HyInputBarDelegate <NSObject>

@optional

- (void)hy_inputBar:(HyInputBar *)inputBar didTouchedInputBar:(NSSet<UITouch *> *)touches;
- (void)hy_inputBar:(HyInputBar *)inputBar didTouchedSendButton:(UIButton *)sendButton;

@end

@interface HyInputBar : UIView

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy) NSString *actionItemTitle;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, weak) id <HyInputBarDelegate> inputDelegate;

@end
