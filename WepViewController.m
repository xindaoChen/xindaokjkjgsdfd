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

@interface WepViewController ()

@end

@implementation WepViewController
@synthesize myurl;
- (id)initWithurl:(NSURL*)urls
{
    self = [super init];
    if (self) {
        myurl = urls;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    mainview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mainview.delegate = self;
    mainview.scalesPageToFit = YES;
    [mainview loadRequest:[NSURLRequest requestWithURL:myurl]];
    self.view = mainview;
    
    ;
    self.navigationItem.leftBarButtonItem = [UITools getNavButtonItem:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backtosuper
{
    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:NO];
    [self.navigationController   popViewControllerAnimated:YES];
}

@end
