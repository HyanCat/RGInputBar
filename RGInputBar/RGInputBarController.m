//
//  RGInputBarController.m
//
//  Created by HyanCat on 29/05/2017.
//  Copyright © 2017年 HyanCat. All rights reserved.
//

#import "RGInputBarController.h"
#import "RGInputBar.h"
#import "RGInputViewController.h"
#import <Masonry/Masonry.h>
#import "RGInputActionItem.h"

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

@interface RGInputBarController () <RGInputBarDelegate>

@property (nonatomic, weak) __kindof UIViewController *controller;

/**
 * Input bar is used for output.
 */
@property (nonatomic, weak, readwrite) RGInputBar *inputBar;

@property (nonatomic, strong) NSMutableArray <RGInputActionItem *> *actions;

/**
 * Input view is used for input.
 */
@property (nonatomic, weak, readwrite) RGInputViewController *inputViewController;

@end

@implementation RGInputBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _actions = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Public Methods

- (void)addAction:(RGInputActionItem *)action
{
    [self.actions addObject:action];
}

- (void)attachToViewController:(UIViewController *)controller atPosition:(RGInputBarPosition)position
{
    self.controller = controller;

    if (position == RGInputBarPositionBottom) {
        [self attachInputBar];
    }
}

- (void)showInputView
{
    RGInputViewController *inputViewController = [[RGInputViewController alloc] init];
    inputViewController.delegate = self;
    inputViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    inputViewController.content = self.content;
    [self.controller presentViewController:inputViewController animated:NO completion:nil];
    self.inputViewController = inputViewController;
}

- (void)dismissInputView
{
    [self.inputViewController hideAnimated];
}

- (void)resetActions
{
    [self.actions removeAllObjects];
    [self reloadActions];
}

- (void)reloadActions
{
    self.inputBar.actions = self.actions;
}

- (void)clear
{
    self.content = nil;
    self.inputViewController.content = nil;
}

- (void)attachInputBar
{
    RGInputBar *inputBar = [[RGInputBar alloc] init];
    inputBar.inputDelegate = self;
    [self.controller.view addSubview:inputBar];
    [inputBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
    }];
    inputBar.actions = self.actions;
    self.inputBar = inputBar;
}

#pragma mark - Delegate

- (void)rg_inputViewController:(RGInputViewController *)controller
              didChangeContent:(NSString *)content
{
    self.content = content;
}

- (void)rg_inputViewControllerDidConfirm:(RGInputViewController *)controller
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rg_inputBarController:sendInput:)]) {
        __weak typeof(self) weakSelf = self;
        [self.delegate rg_inputBarController:self sendInput:self.content];
    }
}

- (void)rg_inputBarDidTouched:(RGInputBar *)inputBar
{
    [self showInputView];
}

@end
