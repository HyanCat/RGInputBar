//
//  RGInputBar.h
//
//  Created by HyanCat on 16/4/16.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

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

/**
 When the icons did touched.

 @param inputBar The InputBar target.
 @param index The index which icon did touched.
 */
- (void)rg_inputBar:(RGInputBar *)inputBar didTouchedIconAtIndex:(NSUInteger)index;

@end

/**
 The input bar view.
 */
@interface RGInputBar : UIView

/**
 Icons array.
 A simple pencil icon will be place at first by default.
 */
@property (nonatomic, copy) NSArray <UIImage *> *icons;
@property (nonatomic, copy) NSString *actionItemTitle;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, copy) NSString *placeholder UI_APPEARANCE_SELECTOR;

@property (nonatomic, weak, nullable) id <RGInputBarDelegate> inputDelegate;

@end

NS_ASSUME_NONNULL_END
