//
//  WepViewController.h
//  DevelopMent
//
//  Created by xin wang on 3/31/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WepViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *mainview;
    NSURL *myurl;
}
@property(nonatomic,strong) NSURL *myurl;
- (id)initWithurl:(NSURL*)urls;
@end
