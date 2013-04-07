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
    NSString *myurl;
}

@property (nonatomic, strong) NSString *titleName;
- (id)initWithUrl:(NSString*)weburl;
@end
