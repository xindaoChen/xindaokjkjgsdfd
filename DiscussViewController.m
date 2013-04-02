//
//  DiscussViewController.m
//  DevelopMent
//
//  Created by xin wang on 3/22/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import "DiscussViewController.h"
#import "QuartzCore/QuartzCore.h" 
#import "CooperaViewController.h"
#import "AppDelegate.h"
@interface DiscussViewController ()

@end

@implementation DiscussViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        AppDelegate*mydelegate = [UIApplication sharedApplication].delegate;
        if ([mydelegate.language isEqualToString:@"china"]) {
             self.title = @"云聚";
        }
        else
        {
           self.title = @"Relation";
        }
         
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
    CGRect fram = self.view.frame;
    if (fram.size.height>500) {
          textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 15, 300, 160)];
    }
    else
    {
          textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 15, 300, 150)];
    }
   
    textview.backgroundColor = [UIColor clearColor];
    textview.editable = NO;
    textview.scrollEnabled = NO;
    textview.layer.cornerRadius = 6;
    textview.layer.masksToBounds = YES;
    textview.text =@"       本产品致力于提供最详尽的全国开发区信息。采用LBS定位，默认显示所在城市的所有开发区，同时支持按省份浏览，按行业浏览，按名字关键字搜索等。针对每个开发区，都有单独的系列页面进行详尽的说明，对于有独立APP的开发区，提供其下载链接。";
    textview.textColor = [UIColor blackColor];
    textview.font =[UIFont systemFontOfSize:16];
    [self.view addSubview:textview];
    
    
    UIButton *button1= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 addTarget:self action:@selector(coopview) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed:@"kuang1.png"] forState:UIControlStateNormal];
    [button1 setTitle:@"合作单位" forState:UIControlStateNormal];

    
    
    UIButton *button2= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setBackgroundImage:[UIImage imageNamed:@"kuang2.png"] forState:UIControlStateNormal];
    [button2 setTitle:@"合作媒体" forState:UIControlStateNormal];
 
    
	UIButton *button3= [UIButton buttonWithType:UIButtonTypeRoundedRect];
     [button3 setBackgroundImage:[UIImage imageNamed:@"kuang3.png"] forState:UIControlStateNormal];
    [button3 setTitle:@"常见机构投资者" forState:UIControlStateNormal];
 
       if (fram.size.height>500)
       {
            button1.frame = CGRectMake(10, 215, 300, 40);
            button2.frame = CGRectMake(10, 275, 300, 40);
            button3.frame = CGRectMake(10, 335, 300, 40);
       }
    else
    {
        button1.frame = CGRectMake(10, 180, 300, 40);
        button2.frame = CGRectMake(10, 240, 300, 40);
        button3.frame = CGRectMake(10, 300, 300, 40);
    }
    
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
}
 
-(void)coopview
{
    CooperaViewController *coopview = [[CooperaViewController alloc] init];
    [self.navigationController pushViewController:coopview animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
