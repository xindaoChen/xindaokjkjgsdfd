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
    UIWebView *webview;
    NSUInteger inter;
}
 
- (id)initWithnumber:(NSUInteger)number;
@end
