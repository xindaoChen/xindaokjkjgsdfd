//
//  BarCodeViewController.m
//  DevelopMent
//
//  Created by 容芳志 on 13-4-7.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import "BarCodeViewController.h"
#import "UITools.h"

@interface BarCodeViewController ()

@end

@implementation BarCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"二维码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UITools getNavButtonItem:self];
    UIImageView *barImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appstore_qr"]];
    barImageView.frame = CGRectMake(90, 70, 140, 140);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(106, 220, 130, 20)];
    label.text = @"扫描即可下载";
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:label];
    
    [self.view addSubview:barImageView];
	// Do any additional setup after loading the view.
}

-(void)backtosuper
{
    [self.navigationController   popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
