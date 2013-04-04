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
#import "XDTabBarViewController.h"

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

- (void)viewDidAppear:(BOOL)animated
{
//    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:NO];
    [super viewDidAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
    CGRect fram = self.view.frame;
//    if (fram.size.height>500) {
//          textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 15, 300, 160)];
//    }
//    else
//    {
//          textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 15, 300, 150)];
//    }
//   
//    textview.backgroundColor = [UIColor redColor];
//    textview.editable = NO;
//    textview.scrollEnabled = NO;
//    textview.layer.cornerRadius = 6;
//    textview.layer.masksToBounds = YES;
//    textview.text =@"       本产品致力于提供最详尽的全国开发区信息。采用LBS定位，默认显示所在城市的所有开发区，同时支持按省份浏览，按行业浏览，按名字关键字搜索等。针对每个开发区，都有单独的系列页面进行详尽的说明，对于有独立APP的开发区，提供其下载链接。";
//    textview.textColor = [UIColor blackColor];
//    textview.font =[UIFont systemFontOfSize:15];
//    [self.view addSubview:textview];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
    webview = [[UIWebView alloc] init];
    UIImageView *myimageview = [[UIImageView alloc] initWithFrame:CGRectMake(90,  10, 140, 140)];
    [myimageview setImage:[UIImage imageNamed:@"applogo.png"]];
    myimageview.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapImgView=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(pushtoapp)];
    [myimageview addGestureRecognizer:tapImgView];

    [self.view addSubview:myimageview];
    
    
    UIButton *button1= [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 addTarget:self action:@selector(coopview) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed:@"cell_bg_0.png"] forState:UIControlStateNormal];
  
     button1.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button1 setTitleColor:[UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0] forState:UIControlStateNormal];

   
   
    
    
    UIButton *button2= [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:[UIImage imageNamed:@"cell_bg_1.png"] forState:UIControlStateNormal];
 
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button2 setTitleColor:[UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0] forState:UIControlStateNormal];

    
	UIButton *button3= [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setBackgroundImage:[UIImage imageNamed:@"cell_bg_2.png"] forState:UIControlStateNormal];

      button3.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button3 setTitleColor:[UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0] forState:UIControlStateNormal];


    UIButton *button4= [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setBackgroundImage:[UIImage imageNamed:@"cell_bg_3.png"] forState:UIControlStateNormal];

    button4.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button4 addTarget:self action:@selector(pushtoreview) forControlEvents:UIControlEventTouchUpInside];
    [button4 setTitleColor:[UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    AppDelegate *mydelefate = [UIApplication sharedApplication].delegate;
    if ([mydelefate.language isEqualToString:@"english"]) {
        [button4 setTitle:@"Give me ratings" forState:UIControlStateNormal];
        [button3 setTitle:@"Common investors" forState:UIControlStateNormal];
        [button2 setTitle:@"Media Partners" forState:UIControlStateNormal];
        [button1 setTitle:@"Cooperation" forState:UIControlStateNormal];

         
    }
    else
    {
        [button4 setTitle:@"去点评一下" forState:UIControlStateNormal];
        [button3 setTitle:@"常见机构投资者" forState:UIControlStateNormal];
        [button2 setTitle:@"合作媒体" forState:UIControlStateNormal];
        [button1 setTitle:@"合作单位" forState:UIControlStateNormal];
    }
    
    
       if (fram.size.height>500)
       {
            button1.frame = CGRectMake(10, 215, 300, 37);
            button2.frame = CGRectMake(10, 258, 300, 37);
            button3.frame = CGRectMake(10, 301, 300, 37);
           button4.frame = CGRectMake(10,345, 300, 37);
       }
    else
    {
        button1.frame = CGRectMake(10, 180, 300, 37);
        button2.frame = CGRectMake(10, 223, 300, 37);
        button3.frame = CGRectMake(10,266, 300, 37);
        button4.frame = CGRectMake(10,309, 300, 37);

    }
    
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
    [self.view addSubview:button4];
}
 
-(void)coopview
{
    CooperaViewController *coopview = [[CooperaViewController alloc] init];
    [self.navigationController pushViewController:coopview animated:YES];
//    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:YES];
    
}


-(void)pushtoapp
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/moxtra-jing-cai.-fen-cheng/id590571587?mt=8"]];
}

-(void)pushtoreview
{
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/moxtra-jing-cai.-fen-cheng/id590571587?mt=8"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
