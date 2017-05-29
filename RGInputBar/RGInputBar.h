//
//  RGInputBar.h
//
//  Created by HyanCat on 16/4/16.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RGInputBar;

@protocol RGInputBarDelegate <NSObject>

@optional

- (void)rg_inputBar:(RGInputBar *)inputBar didTouchedInputBar:(NSSet<UITouch *> *)touches;
- (void)rg_inputBar:(RGInputBar *)inputBar didTouchedSendButton:(UIButton *)sendButton;

@end

@interface RGInputBar : UIView

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy) NSString *actionItemTitle;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, weak, nullable) id <RGInputBarDelegate> inputDelegate;

@end

NS_ASSUME_NONNULL_END
