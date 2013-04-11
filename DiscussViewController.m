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
#import "WepViewController.h"
#import "XDHeader.h"
#import "BarCodeViewController.h"

@interface DiscussViewController ()

@end

@implementation DiscussViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        AppDelegate*mydelegate = [UIApplication sharedApplication].delegate;
        if ([mydelegate.language isEqualToString:@"china"]) {
             self.title = @"北京科润创想信息技术有限公司";
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

    AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
    _urlHost = delegate.domainName;

      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
    CGRect fram = self.view.frame;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
    UIImageView *myimageview = [[UIImageView alloc] initWithFrame:CGRectMake(95, 10, 130, 100)];
    [myimageview setImage:[UIImage imageNamed:@"applogo.png"]];
//    myimageview.userInteractionEnabled=YES;
//    UITapGestureRecognizer *tapImgView=[[UITapGestureRecognizer alloc]initWithTarget:self
//                                                                              action:@selector(pushtoapp)];
//    [myimageview addGestureRecognizer:tapImgView];
 
    [self.view addSubview:myimageview];
    
    
    UIButton *button1= [UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 addTarget:self action:@selector(coopview) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed:@"cell_bg_0.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pushtowebview:) forControlEvents:UIControlEventTouchUpInside];
     button1.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    button1.tag =100;
    [button1 setTitleColor:[UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0] forState:UIControlStateNormal];

   
   
    
    
    UIButton *button2= [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:[UIImage imageNamed:@"cell_bg_1.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(pushtowebview:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag =200;
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button2 setTitleColor:[UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0] forState:UIControlStateNormal];

    
	UIButton *button3= [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setBackgroundImage:[UIImage imageNamed:@"cell_bg_2.png"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(pushtowebview:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag =300;
   button3.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button3 setTitleColor:[UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0] forState:UIControlStateNormal];


    UIButton *button4= [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setBackgroundImage:[UIImage imageNamed:@"cell_bg_3.png"] forState:UIControlStateNormal];

    button4.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button4 addTarget:self action:@selector(pushtoreview) forControlEvents:UIControlEventTouchUpInside];
    [button4 setTitleColor:[UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    UIButton *buttonFor2D= [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonFor2D setBackgroundImage:[UIImage imageNamed:@"cell_bg_4.png"] forState:UIControlStateNormal];
    
    buttonFor2D.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [buttonFor2D addTarget:self action:@selector(pushto2D) forControlEvents:UIControlEventTouchUpInside];
    [buttonFor2D setTitleColor:[UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    
    AppDelegate *mydelefate = [UIApplication sharedApplication].delegate;
    if ([mydelefate.language isEqualToString:@"english"]) {
        [button4 setTitle:@"Give me ratings" forState:UIControlStateNormal];
        [button3 setTitle:@"Common investors" forState:UIControlStateNormal];
        [button2 setTitle:@"Co-operation" forState:UIControlStateNormal];
        [button1 setTitle:@"KerunInnovation" forState:UIControlStateNormal];
        [buttonFor2D setTitle:@"2D bar code" forState:UIControlStateNormal];

    }
    else
    {
        [button4 setTitle:@"去点评一下" forState:UIControlStateNormal];
        [button3 setTitle:@"常见机构投资者" forState:UIControlStateNormal];
        [button2 setTitle:@"合作单位" forState:UIControlStateNormal];
        [button1 setTitle:@"北京科润创想信息技术有限公司" forState:UIControlStateNormal];
        [buttonFor2D setTitle:@"二维码" forState:UIControlStateNormal];
    }
    
    float hight = 20;
   if (fram.size.height>500)
   {
        button1.frame = CGRectMake(10, 205 - hight, 300, 37);
        button2.frame = CGRectMake(10, 248 - hight, 300, 37);
        button3.frame = CGRectMake(10, 291 - hight, 300, 37);
        button4.frame = CGRectMake(10, 335 - hight, 300, 37);
        buttonFor2D.frame = CGRectMake(10,378 - hight, 300, 37);


   }
    else
    {
        button1.frame = CGRectMake(10, 170 - hight, 300, 37);
        button2.frame = CGRectMake(10, 213 - hight, 300, 37);
        button3.frame = CGRectMake(10,256 - hight, 300, 37);
        button4.frame = CGRectMake(10,299 - hight, 300, 37);
        buttonFor2D.frame = CGRectMake(10,342 - hight, 300, 37);

    }
    
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
    [self.view addSubview:button4];
    [self.view addSubview:buttonFor2D];
}


-(void)pushtowebview:(UIButton *)sender
{
    AppDelegate *medele = [UIApplication sharedApplication].delegate;
    NSString *url;
    if (sender.tag == 100) {
         
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",medele.compsite]]];
        return;
    }
    else if (sender.tag == 200)
    {
         url =[NSString stringWithFormat:@"%@%@",_urlHost,@"index.php/other/media"];
    }
    else if (sender.tag == 300)
    {
         url =[NSString stringWithFormat:@"%@%@",_urlHost,@"index.php/other/investor"];
    }
    WepViewController *mywepview = [[WepViewController alloc] initWithUrl:url];
    if (sender.tag == 100) {
//       mywepview.title = @"合作单位";
    }
    else if (sender.tag == 200)
    {
       mywepview.title = @"合作单位";
    }
    else if (sender.tag == 300)
    {
        mywepview.title = @"常见机构投资者";
    }

    [self.navigationController pushViewController:mywepview animated:YES];
}
 

- (void)pushto2D
{
    BarCodeViewController *barcode = [[BarCodeViewController alloc] init];
    
    [self.navigationController pushViewController:barcode animated:YES];
}

 
-(void)pushtoreview
{
    AppDelegate *mydelega = [UIApplication sharedApplication].delegate;
    if (mydelega.applink != nil && ![mydelega.applink isEqualToString:@""]) {
        NSURL *appurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",mydelega.applink]];
         [[UIApplication sharedApplication] openURL:appurl];
    }else{
        NSString *appName = [NSString stringWithString:
                             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
        NSURL *appStoreURL = [NSURL URLWithString:[[NSString stringWithFormat:@"http://itunes.com/app/%@",appName]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ]];
        NSLog(@"appStoreURL:%@", appStoreURL);
        [[UIApplication sharedApplication] openURL:appStoreURL];
    }
   

     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
