//
//  RGInputActionItem.h
//  RGInputBar
//
//  Created by Songming on 2019/7/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RGInputActionItem : NSObject

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy, nullable) dispatch_block_t handler;

+ (instancetype)actionItemWithIcon:(UIImage *)icon handler:(nullable dispatch_block_t)handler;

@end

NS_ASSUME_NONNULL_END
