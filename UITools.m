//
//  UITools.m
//  DevelopMent
//
//  Created by 容芳志 on 13-4-1.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import "UITools.h"
#import "MBProgressHUD.h"

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

+ (void)showPopMessage:(UIViewController*)viewController titleInfo:(NSString*)title messageInfo:(NSString*)msg {
    if (viewController.navigationController.view == nil) {
        return;
    }
    MBProgressHUD *HUD  = [[MBProgressHUD alloc] initWithView:viewController.navigationController.view];
    [viewController.navigationController.view addSubview:HUD];
    HUD.delegate = nil;
    HUD.labelText = title;
    HUD.detailsLabelText = msg;
    HUD.square = YES;
    
    HUD.customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}
@end
