//
//  WepViewController.m
//  DevelopMent
//
//  Created by xin wang on 3/31/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import "WepViewController.h"
#import "UITools.h"
#import "AppDelegate.h"
#import "XDTabBarViewController.h"
#import "MBProgressHUD.h"
@interface WepViewController ()

@end

@implementation WepViewController
 
- (id)initWithUrl:(NSString*)weburl
{
    self = [super init];
    if (self)
    {
        myurl = weburl;
      self.hidesBottomBarWhenPushed = YES;
     }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    webview.delegate = self;
    webview.scalesPageToFit = YES;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:myurl]]];
    self.view = webview;
    self.navigationItem.leftBarButtonItem = [UITools getNavButtonItem:self];
    
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backtosuper
{
//    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:NO];
    [self.navigationController   popViewControllerAnimated:YES];
}

@end
