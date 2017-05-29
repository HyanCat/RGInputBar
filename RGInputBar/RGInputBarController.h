//
//  RGInputBarController.h
//
//  Created by HyanCat on 29/05/2017.
//  Copyright © 2017年 HyanCat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RGInputBar;
@class RGInputView;
@interface RGInputBarController : UIViewController

@property (nonatomic, weak, readonly) RGInputBar *inputBar;
@property (nonatomic, weak, readonly) RGInputView *inputView;

@end

NS_ASSUME_NONNULL_END
