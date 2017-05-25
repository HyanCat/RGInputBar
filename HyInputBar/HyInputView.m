//
//  HyInputView.m
//  Pods
//
//  Created by HyanCat on 16/4/16.
//
//

#import "HyInputView.h"
@import UITextView_Placeholder;

@interface HyInputView ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *inputPanelView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *replyTipButton;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation HyInputView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.contentTextView.placeholder = @"写评论...";
}

- (NSString *)content
{
    return self.contentTextView.text;
}

- (void)setContent:(NSString *)content
{
    self.contentTextView.text = content;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.contentTextView.placeholder = self.placeholder;
}

- (void)setCancelActionTitle:(NSString *)cancelActionTitle
{
    _cancelActionTitle = cancelActionTitle;
    [self.cancelButton setTitle:self.cancelActionTitle forState:UIControlStateNormal];
}

- (void)setConfirmActionTitle:(NSString *)confirmActionTitle
{
    _confirmActionTitle = confirmActionTitle;
    [self.confirmButton setTitle:self.confirmActionTitle forState:UIControlStateNormal];
}

- (void)setReplyTipTitle:(NSString *)replyTipTitle
{
    _replyTipTitle = replyTipTitle;
    [self.replyTipButton setTitle:replyTipTitle forState:UIControlStateNormal];
    [self.replyTipButton sizeToFit];
}

- (void)clear
{
    self.contentTextView.text = @"";
    self.replyTipTitle = nil;
}

- (void)show
{
    self.hidden = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(hy_inputViewWillShow:)]) {
        [self.delegate hy_inputViewWillShow:self];
    }
    [self.contentTextView becomeFirstResponder];
}

- (void)dismiss
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hy_inputViewWillDismiss:)]) {
        [self.delegate hy_inputViewWillDismiss:self];
    }
    [self.contentTextView resignFirstResponder];
}

- (IBAction)cancelButtonTouched:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hy_inputView:didTouchedCancelButton:)]) {
        [self.delegate hy_inputView:self didTouchedCancelButton:sender];
    }
}
- (IBAction)confirmButtonTouched:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hy_inputView:didTouchedConfirmButton:)]) {
        [self.delegate hy_inputView:self didTouchedConfirmButton:sender];
    }
}
- (IBAction)replyTipButtonTouched:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hy_inputView:didTouchedReplyTipButton:)]) {
        [self.delegate hy_inputView:self didTouchedReplyTipButton:sender];
    }
}

- (IBAction)backgroundTapped:(UITapGestureRecognizer *)sender
{
    [self dismiss];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                     animations:^{
                         CGRect frame = self.inputPanelView.frame;
                         frame.origin.y = CGRectGetMinY(keyboardEndFrame) - frame.size.height;
                         self.inputPanelView.frame = frame;
                         self.backgroundView.alpha = 0.5f;
                     }
                     completion:^(BOOL finished) {
                         if (self.delegate && [self.delegate respondsToSelector:@selector(hy_inputViewDidShow:)]) {
                             [self.delegate hy_inputViewDidShow:self];
                         }
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                     animations:^{
                         CGRect frame = self.inputPanelView.frame;
                         frame.origin.y = CGRectGetMaxY(keyboardEndFrame);
                         self.inputPanelView.frame = frame;
                         self.backgroundView.alpha = 0.f;
                     }
                     completion:^(BOOL finished) {
                         self.hidden = YES;
                         if (self.delegate && [self.delegate respondsToSelector:@selector(hy_inputViewDidDismiss:)]) {
                             [self.delegate hy_inputViewDidDismiss:self];
                         }
                     }];
}

@end
