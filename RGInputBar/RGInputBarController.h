//
//  RGInputBarController.h
//
//  Created by HyanCat on 29/05/2017.
//  Copyright © 2017年 HyanCat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGInputActionItem;
NS_ASSUME_NONNULL_BEGIN

@class RGInputBarController;
@protocol RGInputBarControllerDelegate <NSObject>

@optional
- (void)rg_inputBarController:(RGInputBarController *)controller sendInput:(NSString  * _Nullable)content;

@end

typedef NS_ENUM(NSInteger, RGInputBarPosition) {
    RGInputBarPositionNone = 0,
    RGInputBarPositionBottom,
};

@class RGInputBar;
@interface RGInputBarController : NSObject

@property (nonatomic, weak, nullable, readonly) RGInputBar *inputBar;

@property (nonatomic, copy, nullable) NSString *content;
@property (nonatomic, copy, nullable) NSString *atUserName;

@property (nonatomic, weak) id <RGInputBarControllerDelegate> delegate;

- (void)addAction:(RGInputActionItem *)action;

- (void)attachToViewController:(UIViewController *)controller atPosition:(RGInputBarPosition)position;

- (void)showInputView;
- (void)dismissInputView;

- (void)resetActions;
- (void)reloadActions;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
