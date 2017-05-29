//
//  RGInputBar.m
//
//  Created by HyanCat on 16/4/16.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import "RGInputBar.h"
@import UITextView_Placeholder;

@interface RGInputBar ()

@property (strong, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, assign) BOOL placeholding;

@end

@implementation RGInputBar

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.layer.shadowOffset = CGSizeMake(0, -2.f);
    self.layer.shadowColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    self.layer.shadowRadius = 2.f;
    self.layer.shadowOpacity = 1.0f;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;

    [self _checkPlaceholder];
}

- (void)setContent:(NSString *)content
{
    _content = content;

    [self _checkPlaceholder];
}

- (void)setIcon:(UIImage *)icon
{
    _icon = icon;
    [self.iconButton setImage:self.icon forState:UIControlStateNormal];
}

- (void)setActionItemTitle:(NSString *)actionItemTitle
{
    _actionItemTitle = actionItemTitle;
    [self.sendButton setTitle:self.actionItemTitle forState:UIControlStateNormal];
}

- (IBAction)sendButtonTouched:(id)sender
{
    if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(rg_inputBar:didTouchedSendButton:)]) {
        [self.inputDelegate rg_inputBar:self didTouchedSendButton:sender];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(rg_inputBar:didTouchedInputBar:)]) {
        [self.inputDelegate rg_inputBar:self didTouchedInputBar:touches];
    }
}

- (void)_checkPlaceholder
{
    if (!self.content || self.content.length == 0) {
        self.textView.text = self.placeholder;
        self.placeholding = YES;
    }
    else {
        self.textView.text = _content;
        self.placeholding = NO;
    }
}

@end
