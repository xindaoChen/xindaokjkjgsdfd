//
//  UITools.m
//  DevelopMent
//
//  Created by 容芳志 on 13-4-1.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import "UITools.h"

@implementation UITools


+ (UIBarButtonItem* )getNavButtonItem :(UIViewController*)controller
{
    UIButton *leftButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButtonItem.frame = CGRectMake(0, 10, 60, 40);
    [leftButtonItem setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
    [leftButtonItem addTarget:controller action:@selector(backtosuper) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnTopItem = [[[UIBarButtonItem alloc] initWithCustomView:leftButtonItem] autorelease];

    return leftBtnTopItem;
}
@end
