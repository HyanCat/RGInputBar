//
//  RGInputKeyboardLayoutGuide.m
//  RGInputBar
//
//  Created by Songming on 2019/7/3.
//

#import "RGInputKeyboardLayoutGuide.h"

@implementation RGInputKeyboardLayoutGuide

- (instancetype)init
{
    self = [super init];
    if (self) {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillShowNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)install
{
    [self setupConstraints];
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification
{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    self.heightConstraint.constant = CGRectGetMaxY(UIScreen.mainScreen.bounds) - CGRectGetMinY(frame);
    [UIView setAnimationCurve:curve];
    [UIView animateWithDuration:duration animations:^{
        [self.owningView layoutIfNeeded];
    }];
}

- (void)setupConstraints
{
    UIView *view = self.owningView;
    if (view) {
        self.heightConstraint = [self.heightAnchor constraintEqualToConstant:0];
        self.heightConstraint.active = YES;
        [self.leftAnchor constraintEqualToAnchor:view.leftAnchor].active = YES;
        [self.rightAnchor constraintEqualToAnchor:view.rightAnchor].active = YES;
        [self.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    }
}

@end
