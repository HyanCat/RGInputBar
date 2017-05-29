//
//  RGInputBarController.m
//
//  Created by HyanCat on 29/05/2017.
//  Copyright © 2017年 HyanCat. All rights reserved.
//

#import "RGInputBarController.h"
#import "RGInputBar.h"
#import "RGInputView.h"

@interface RGInputBarContentView : UIView

@end

@implementation RGInputBarContentView

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

- (void)loadView
{
    RGInputBarContentView *view = [[RGInputBarContentView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _automaticallyShowInputViewWhenAtUser = YES;

    [self.view addSubview:self.inputBar];
    [self.view addSubview:self.inputView];

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
    _content = content;
    self.inputView.content = _content;
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
    self.inputBar.content = self.inputView.content;
    _content = self.inputBar.content;
}

- (RGInputBar *)inputBar
{
    if (!_inputBar) {
        NSBundle *bundle = [NSBundle bundleForClass:[RGInputBar class]];
        RGInputBar *inputBar = [bundle loadNibNamed:NSStringFromClass(RGInputBar.class)
                                              owner:self
                                            options:nil].firstObject;
        inputBar.frame = CGRectMake(0,
                                    self.view.bounds.size.height-49,
                                    self.view.bounds.size.width,
                                    49);
        inputBar.icon = [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[bundle pathForResource:@"RGInputBar"
                                                                                                    ofType:@"bundle"]]
                                                          pathForResource:@"icon_pencil"
                                                          ofType:@"png"]];
        inputBar.inputDelegate = self;
        _inputBar = inputBar;
    }
    return _inputBar;
}

- (RGInputView *)inputView
{
    if (!_inputView) {
        NSBundle *bundle = [NSBundle bundleForClass:[RGInputBar class]];
        RGInputView *inputView = [bundle loadNibNamed:NSStringFromClass(RGInputView.class)
                                                owner:self
                                              options:nil].firstObject;
        inputView.frame = self.view.bounds;
        inputView.delegate = self;
        _inputView = inputView;
    }
    return _inputView;
}

- (void)rg_inputBar:(RGInputBar *)inputBar didTouchedInputBar:(NSSet<UITouch *> *)touches
{
    [self.inputView show];
}

- (void)rg_inputBar:(RGInputBar *)inputBar didTouchedSendButton:(UIButton *)sendButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rg_inputBarController:didConfirmInput:)]) {
        [self.delegate rg_inputBarController:self didConfirmInput:self.content];
    }
}

- (void)rg_inputView:(RGInputView *)inputView didTouchedCancelButton:(UIButton *)cancelButton
{
    [inputView dismiss];
}

- (void)rg_inputView:(RGInputView *)inputView didTouchedConfirmButton:(UIButton *)confirmButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rg_inputBarController:didConfirmInput:)]) {
        [self.delegate rg_inputBarController:self didConfirmInput:self.content];
    }
}

- (void)rg_inputView:(RGInputView *)inputView didTouchedReplyTipButton:(UIButton *)replyTipButton
{
    inputView.replyTipTitle = nil;
}

@end
