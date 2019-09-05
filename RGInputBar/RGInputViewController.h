//
//  RGInputViewController.h
//  RGInputBar
//
//  Created by Songming on 2019/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RGInputViewController;
@protocol RGInputViewControllerDelegate <NSObject>

- (void)rg_inputViewController:(RGInputViewController *)controller
              didChangeContent:(NSString *)content;
- (void)rg_inputViewControllerDidCancel:(RGInputViewController *)controller;
- (void)rg_inputViewControllerDidConfirm:(RGInputViewController *)controller;

@end

@interface RGInputViewController : UIViewController

@property (nonatomic, strong, readonly) NSString *content;

@property (nonatomic, weak, nullable) id <RGInputViewControllerDelegate> delegate;

- (instancetype)initWithContent:(NSString * _Nullable)content;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (void)showAnimated;
- (void)hideAnimated;

- (void)clearContent;

@end

NS_ASSUME_NONNULL_END
