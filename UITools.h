//
//  UITools.h
//  DevelopMent
//
//  Created by 容芳志 on 13-4-1.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITools : NSObject
+ (UIBarButtonItem* )getNavButtonItem: (UIViewController*) controller;
+ (void)showPopMessage:(UIViewController*)viewController titleInfo:(NSString*)title messageInfo:(NSString*)msg;

@end
