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

@property (nonatomic, strong) NSString *content;

@property (nonatomic, weak, nullable) id <RGInputViewControllerDelegate> delegate;

- (void)showAnimated;
- (void)hideAnimated;

@end

NS_ASSUME_NONNULL_END
