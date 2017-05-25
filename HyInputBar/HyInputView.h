//
//  HyInputView.h
//  Pods
//
//  Created by HyanCat on 16/4/16.
//
//

#import <UIKit/UIKit.h>

@class HyInputView;
@protocol HyInputViewDelegate <NSObject>

@optional

- (void)hy_inputViewWillShow:(HyInputView *)inputView;
- (void)hy_inputViewDidShow:(HyInputView *)inputView;
- (void)hy_inputViewWillDismiss:(HyInputView *)inputView;
- (void)hy_inputViewDidDismiss:(HyInputView *)inputView;

- (void)hy_inputView:(HyInputView *)inputView didTouchedCancelButton:(UIButton *)cancelButton;
- (void)hy_inputView:(HyInputView *)inputView didTouchedConfirmButton:(UIButton *)confirmButton;
- (void)hy_inputView:(HyInputView *)inputView didTouchedReplyTipButton:(UIButton *)replyTipButton;

@end

@interface HyInputView : UIView

@property (nonatomic, weak) id <HyInputViewDelegate> delegate;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) NSString *cancelActionTitle;
@property (nonatomic, copy) NSString *confirmActionTitle;
@property (nonatomic, copy) NSString *replyTipTitle;

- (void)clear;

- (void)show;
- (void)dismiss;

@end
