//
//  RGInputBarController.h
//
//  Created by HyanCat on 29/05/2017.
//  Copyright © 2017年 HyanCat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RGInputBarController;
@protocol RGInputBarControllerDelegate <NSObject>

@optional
- (void)rg_inputBarController:(RGInputBarController *)controller didSendInput:(NSString  * _Nullable)content;

@end

@class RGInputBar;
@class RGInputView;
@interface RGInputBarController : UIViewController

@property (nonatomic, weak, readonly) RGInputBar *inputBar;
@property (nonatomic, weak, readonly) RGInputView *inputView;

@property (nonatomic, copy, nullable) NSString *content;
@property (nonatomic, copy, nullable) NSString *atUserName;
@property (nonatomic, assign) BOOL automaticallyShowInputViewWhenAtUser;    // default YES
@property (nonatomic, weak) id <RGInputBarControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
