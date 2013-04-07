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
 
- (id)initWithnumber:(NSUInteger)number
{
    self = [super init];
    if (self)
    {
        inter = number;
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
    NSURL *myurl;
    if (inter ==100) {
        myurl = [NSURL URLWithString:@"http://192.168.1.101:8010/index.php/other/cooperator"];
    }
    else if(inter ==200)
    {
         myurl = [NSURL URLWithString:@"http://192.168.1.101:8010/index.php/other/media"];
    }
    else if(inter ==300)
    {
         myurl = [NSURL URLWithString:@"http://192.168.1.101:8010/index.php/other/investor"];
    }
   [webview loadRequest:[NSURLRequest requestWithURL:myurl]];
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
