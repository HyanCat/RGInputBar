//
//  RGInputBar.m
//
//  Created by HyanCat on 16/4/16.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import "RGInputBar.h"

#define RGINPUTBAR_ICON_BUTTON_TAG 1800

@interface RGInputBar ()

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic, strong) UIButton *defaultIconButton;

@end

@implementation RGInputBar

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.layer.shadowOffset = CGSizeMake(0, -2.f);
    self.layer.shadowColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    self.layer.shadowRadius = 2.f;
    self.layer.shadowOpacity = 1.0f;

    [self makeDefaultIconButton];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;

    [self updatePlaceholderAndContent];
}

- (void)setContent:(NSString *)content
{
    _content = content;

    [self updatePlaceholderAndContent];
}

- (void)setTextColor:(UIColor *)textColor
{
    self.textLabel.textColor = textColor;
}

- (void)setIcons:(NSArray<UIImage *> *)icons
{
    _icons = icons;

    NSArray *subviews = self.stackView.arrangedSubviews.copy;
    [subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == RGINPUTBAR_ICON_BUTTON_TAG + idx) {
            [self.stackView removeArrangedSubview:obj];
        }
    }];

    [icons enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = RGINPUTBAR_ICON_BUTTON_TAG + idx;
        [button addTarget:self action:@selector(iconButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:obj forState:UIControlStateNormal];
        [self.stackView insertArrangedSubview:button atIndex:idx];
        [[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:0 constant:44] setActive:YES];
    }];
}

- (void)setActionItemTitle:(NSString *)actionItemTitle
{
    _actionItemTitle = actionItemTitle;
    [self.sendButton setTitle:self.actionItemTitle forState:UIControlStateNormal];
}

- (void)makeDefaultIconButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = RGINPUTBAR_ICON_BUTTON_TAG;
    [button addTarget:self action:@selector(iconButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    NSBundle *bundle = [NSBundle bundleForClass:[RGInputBar class]];
    NSBundle *resource = [NSBundle bundleWithURL:[bundle URLForResource:@"RGInputBar" withExtension:@"bundle"]];
    UIImage *icon = [UIImage imageWithContentsOfFile:[resource pathForResource:@"icon_pencil" ofType:@"png"]];
    [button setImage:icon forState:UIControlStateNormal];

    self.defaultIconButton = button;
    [self.stackView insertArrangedSubview:self.defaultIconButton atIndex:0];
    [[NSLayoutConstraint constraintWithItem:self.defaultIconButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:0 constant:44] setActive:YES];
}

- (void)iconButtonTouched:(UIButton *)sender
{
    NSUInteger idx = sender.tag - RGINPUTBAR_ICON_BUTTON_TAG;
    if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(rg_inputBar:didTouchedIconAtIndex:)]) {
        [self.inputDelegate rg_inputBar:self didTouchedIconAtIndex:idx];
    }
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
    if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(rg_inputBarDidTouched:)]) {
        [self.inputDelegate rg_inputBarDidTouched:self];
    }
}

- (void)updatePlaceholderAndContent
{
    if ([self.content length] > 0) {
        self.textLabel.text = self.content;
    } else {
        self.textLabel.text = self.placeholder;
    }
}

@end
