//
//  XDWebViewController.m
//  DevelopMent
//
//  Created by 容芳志 on 13-4-7.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import "XDWebViewController.h"
#import "UITools.h"

@interface XDWebViewController ()

@end

@implementation XDWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _titleString;
    self.navigationItem.leftBarButtonItem = [UITools getNavButtonItem:self];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_view_bg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
