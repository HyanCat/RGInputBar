//
//  RGInputView.h
//
//  Created by HyanCat on 16/4/16.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RGInputView;
@protocol RGInputViewDelegate <NSObject>

@optional

- (void)rg_inputViewWillShow:(RGInputView *)inputView;
- (void)rg_inputViewDidShow:(RGInputView *)inputView;
- (void)rg_inputViewWillDismiss:(RGInputView *)inputView;
- (void)rg_inputViewDidDismiss:(RGInputView *)inputView;

- (void)rg_inputView:(RGInputView *)inputView didTouchedCancelButton:(UIButton *)cancelButton;
- (void)rg_inputView:(RGInputView *)inputView didTouchedConfirmButton:(UIButton *)confirmButton;
- (void)rg_inputView:(RGInputView *)inputView didTouchedReplyTipButton:(UIButton *)replyTipButton;

@end

@interface RGInputView : UIView

@property (nonatomic, weak, nullable) id <RGInputViewDelegate> inputDelegate;

@property (nonatomic, copy, nullable) NSString *content;
@property (nonatomic, copy, nullable) NSString *placeholder;

@property (nonatomic, copy, nullable) NSString *cancelActionTitle;
@property (nonatomic, copy, nullable) NSString *confirmActionTitle;
@property (nonatomic, copy, nullable) NSString *replyTipTitle;

- (void)clear;

- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
