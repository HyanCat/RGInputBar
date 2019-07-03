//
//  RGInputBar.m
//
//  Created by HyanCat on 16/4/16.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import "RGInputBar.h"
#import <Masonry/Masonry.h>
#import "RGRoundedTextLabel.h"
#import "RGInputViewController.h"
#import "RGInputActionItem.h"

#define RGINPUTBAR_ICON_BUTTON_TAG 1800

@interface _RGActionsView : UIView

@end

@implementation _RGActionsView

- (void)layoutSubviews
{
    [super layoutSubviews];

    __block CGPoint center = CGPointMake(22, self.bounds.size.height/2);
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.center = center;
        center.x += obj.bounds.size.width;
    }];

    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize
{
    __block CGRect rect = CGRectZero;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        rect = CGRectUnion(rect, obj.frame);
    }];
    return rect.size;
}

@end

@interface RGInputBar () <RGInputViewControllerDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIVisualEffectView *blurView;

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIBarButtonItem *defaultIconButton;

@property (nonatomic, strong) RGRoundedTextLabel *textLabel;
@property (nonatomic, strong) _RGActionsView *actionsView;

@end

@implementation RGInputBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.bounds;
    effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:effectView];

    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(0);
        }
        make.height.mas_equalTo(49);
    }];
    self.contentView = contentView;

    RGRoundedTextLabel *textLabel = [[RGRoundedTextLabel alloc] init];
    textLabel.backgroundColor = [UIColor colorWithRed:216/225.f green:216/225.f blue:216/225.f alpha:1];
    [self.contentView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(32);
    }];
    self.textLabel = textLabel;

    _RGActionsView *actionsView = [[_RGActionsView alloc] init];
    [self.contentView addSubview:actionsView];
    [actionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textLabel.mas_right).offset(8);
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.actionsView = actionsView;

    [self.actionsView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    self.textLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textLabelDidTapped:)];
    [self.textLabel addGestureRecognizer:tapGesture];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;

    self.textLabel.text = placeholder;
}

- (void)setTextColor:(UIColor *)textColor
{
    self.textLabel.textColor = textColor;
}

- (void)setActions:(NSArray<RGInputActionItem *> *)actions
{
    _actions = actions.copy;

    [self.actionsView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [actions enumerateObjectsUsingBlock:^(RGInputActionItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *item = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [item setImage:obj.icon forState:UIControlStateNormal];
        [item addTarget:self action:@selector(iconButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        item.tag = RGINPUTBAR_ICON_BUTTON_TAG + idx;
        [self.actionsView addSubview:item];
    }];
}

- (void)setActionItemTitle:(NSString *)actionItemTitle
{
    _actionItemTitle = actionItemTitle;

    [self.sendButton setTitle:actionItemTitle forState:UIControlStateNormal];
}

- (void)iconButtonTouched:(UIButton *)sender
{
    NSUInteger idx = sender.tag - RGINPUTBAR_ICON_BUTTON_TAG;
    if (idx < self.actions.count) {
        RGInputActionItem *action = self.actions[idx];
        if (action.handler) {
            action.handler();
        }
    }
}

- (void)textLabelDidTapped:(UITapGestureRecognizer *)tapGesture
{
    if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(rg_inputBarDidTouched:)]) {
        [self.inputDelegate rg_inputBarDidTouched:self];
    } else {

    }
}

@end
