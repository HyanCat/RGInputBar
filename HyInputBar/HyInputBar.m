//
//  HyInputBar.m
//
//  Created by HyanCat on 16/4/16.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import "HyInputBar.h"

@interface HyInputBar ()

@property (strong, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic, assign) BOOL placeholding;

@end

@implementation HyInputBar

- (void)awakeFromNib
{
    [super awakeFromNib];

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
    if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(hy_inputBar:didTouchedSendButton:)]) {
        [self.inputDelegate hy_inputBar:self didTouchedSendButton:sender];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(hy_inputBar:didTouchedInputBar:)]) {
        [self.inputDelegate hy_inputBar:self didTouchedInputBar:touches];
    }
}

- (void)_checkPlaceholder
{
    if (!self.content || self.content.length == 0) {
        self.textLabel.text = self.placeholder;
        self.placeholding = YES;
    }
    else {
        self.textLabel.text = _content;
        self.placeholding = NO;
    }
}

@end
