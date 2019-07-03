//
//  RGInputBar.h
//
//  Created by HyanCat on 16/4/16.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RGInputActionItem;
@class RGInputBar;

/**
 The delegate protocol for RGInputBar
 */
@protocol RGInputBarDelegate <NSObject>

@optional

/**
 When the input bar main area did touched.

 @param inputBar The InputBar target.
 */
- (void)rg_inputBarDidTouched:(RGInputBar *)inputBar;

@end

/**
 The input bar view.
 */
@interface RGInputBar : UIView

@property (nonatomic, copy) NSArray <RGInputActionItem *> *actions;
@property (nonatomic, copy) NSString *actionItemTitle;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, copy) NSString *placeholder UI_APPEARANCE_SELECTOR;

@property (nonatomic, weak, nullable) id <RGInputBarDelegate> inputDelegate;

@end

NS_ASSUME_NONNULL_END
