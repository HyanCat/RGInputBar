//
//  RGInputBarController.m
//
//  Created by HyanCat on 29/05/2017.
//  Copyright © 2017年 HyanCat. All rights reserved.
//

#import "RGInputBarController.h"
#import "RGInputBar.h"
#import "RGInputView.h"
#import <Masonry/Masonry.h>

@interface _RGInputBarContentView : UIView

@end

@implementation _RGInputBarContentView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // Pass the hit event to others if no view handle it.
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }
    return hitView;
}

@end

@interface RGInputBarController () <RGInputBarDelegate, RGInputViewDelegate>

/**
 * Input bar is used for output.
 */
@property (nonatomic, weak, readwrite) RGInputBar *inputBar;

/**
 * Input view is used for input.
 */
@property (nonatomic, weak, readwrite) RGInputView *inputView;

@end

@implementation RGInputBarController
@dynamic content;

- (void)dealloc
{
    [self.inputView removeObserver:self forKeyPath:@"content"];
}

- (void)loadView
{
    _RGInputBarContentView *view = [[_RGInputBarContentView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _automaticallyShowInputViewWhenAtUser = YES;

    RGInputBar *inputBar = [[RGInputBar alloc] init];
    inputBar.inputDelegate = self;
    self.inputBar = inputBar;
    [self.view addSubview:inputBar];

    NSBundle *bundle = [NSBundle bundleForClass:[RGInputBar class]];
    RGInputView *inputView = [bundle loadNibNamed:NSStringFromClass(RGInputView.class)
                                            owner:self
                                          options:nil].firstObject;
    inputView.frame = self.view.bounds;
    inputView.inputDelegate = self;
    self.inputView = inputView;
    [self.view addSubview:self.inputView];

    [inputBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    [self.inputView addObserver:self
                     forKeyPath:@"content"
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                        context:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.parentViewController touchesBegan:touches withEvent:event];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object != self.inputView) {
        return;
    }
    if ([keyPath isEqualToString:@"content"]) {
        id newValue = [change objectForKey:NSKeyValueChangeNewKey];
        id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
        if (newValue != oldValue) {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateContent) object:nil];
            [self performSelectorOnMainThread:@selector(updateContent) withObject:nil waitUntilDone:NO];
        }
    }
}

- (void)setContent:(NSString *)content
{
    self.inputView.content = content;
}

- (NSString *)content
{
    return self.inputView.content;
}

- (void)setAtUserName:(NSString *)atUserName
{
    _atUserName = atUserName;
    self.inputView.replyTipTitle = _atUserName;
    if (self.automaticallyShowInputViewWhenAtUser && _atUserName && _atUserName.length > 0) {
        [self.inputView show];
    }
}

- (void)updateContent
{
//    self.inputBar.content = self.inputView.content;
}

- (void)rg_inputBarDidTouched:(RGInputBar *)inputBar
{
    [self.inputView show];
}

- (void)rg_inputView:(RGInputView *)inputView didTouchedCancelButton:(UIButton *)cancelButton
{
    [inputView dismiss];
}

- (void)rg_inputView:(RGInputView *)inputView didTouchedSendButton:(nonnull UIButton *)sendButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rg_inputBarController:didSendInput:)]) {
        [self.delegate rg_inputBarController:self didSendInput:self.content];
    }
}

- (void)rg_inputView:(RGInputView *)inputView didTouchedReplyTipButton:(UIButton *)replyTipButton
{
    _atUserName = nil;
    inputView.replyTipTitle = nil;
}

@end
