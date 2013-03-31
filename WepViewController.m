//
//  WepViewController.m
//  DevelopMent
//
//  Created by xin wang on 3/31/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import "WepViewController.h"

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
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10, 2, 40, 40);
    [button2 setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(backtosuper) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnTopItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.leftBarButtonItem = leftBtnTopItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backtosuper
{
    [self.navigationController   popViewControllerAnimated:YES];
}

@end
