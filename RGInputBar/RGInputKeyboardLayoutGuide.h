//
//  RGInputKeyboardLayoutGuide.h
//  RGInputBar
//
//  Created by Songming on 2019/7/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RGInputKeyboardLayoutGuide : UILayoutGuide

@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

- (void)install;

@end

NS_ASSUME_NONNULL_END
