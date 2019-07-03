//
//  RGInputActionItem.m
//  RGInputBar
//
//  Created by Songming on 2019/7/3.
//

#import "RGInputActionItem.h"

@implementation RGInputActionItem

+ (instancetype)actionItemWithIcon:(UIImage *)icon handler:(dispatch_block_t)handler
{
    RGInputActionItem *item = [[self alloc] init];
    item.icon = icon;
    item.handler = handler;
    return item;
}

@end
