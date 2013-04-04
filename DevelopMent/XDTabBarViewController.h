//
//  XDTabBarViewController.h
//  DevelopMent
//
//  Created by 容芳志 on 13-4-3.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDTabBarViewController : UITabBarController
{
    UIButton *settingsButton;
    UIButton *infoButton;
    UIButton *aboutUsButton;
}
@property (nonatomic, retain) UIButton *settingsButton;
@property (nonatomic, retain) UIButton *infoButton;
@property (nonatomic, retain) UIButton *aboutUsButton;
-(void) addCustomElements;
-(void) selectTab:(int)tabID;
- (void) setHideCustomButton:(BOOL) isHide;
@end
