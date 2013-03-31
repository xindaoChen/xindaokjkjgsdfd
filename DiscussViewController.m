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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    CGRect fram = self.view.frame;
    if (fram.size.height>500) {
          textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 15, 300, 230)];
    }
    else
    {
          textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 15, 300, 150)];
    }
   
    textview.backgroundColor = [UIColor underPageBackgroundColor];
    textview.editable = NO;
    textview.layer.cornerRadius = 6;
    textview.layer.masksToBounds = YES;
    textview.text =@"我多家分救分我多家分店搜救分分分店搜救分";
    textview.textColor = [UIColor blackColor];
    textview.font =[UIFont systemFontOfSize:18];
    [self.view addSubview:textview];
    
    
//    UIButton *button1= [UIButton buttonWithType:UIButtonTypeRoundedRect];
//   
//    [button1 addTarget:self action:@selector(coopview) forControlEvents:UIControlEventTouchUpInside];
//    [button1 setTitle:@"合作单位" forState:UIControlStateNormal];
////    button1.backgroundColor = [UIColor whiteColor];
//    
//    UIButton *button2= [UIButton buttonWithType:UIButtonTypeRoundedRect];
//   
//     [button2 setTitle:@"合作媒体" forState:UIControlStateNormal];
////    button2.backgroundColor = [UIColor magentaColor];
//    
//	UIButton *button3= [UIButton buttonWithType:UIButtonTypeRoundedRect];
//   
//     [button3 setTitle:@"常见机构投资者" forState:UIControlStateNormal];
////    button3.backgroundColor = [UIColor lightGrayColor];
//       if (fram.size.height>500)
//       {
//            button1.frame = CGRectMake(10, 280, 300, 40);
//            button2.frame = CGRectMake(10, 340, 300, 40);
//            button3.frame = CGRectMake(10, 400, 300, 40);
//       }
//    else
//    {
//        button1.frame = CGRectMake(10, 180, 300, 40);
//        button2.frame = CGRectMake(10, 240, 300, 40);
//        button3.frame = CGRectMake(10, 300, 300, 40);
//    }
//    
//    [self.view addSubview:button1];
//    [self.view addSubview:button2];
//    [self.view addSubview:button3];
   
    if (fram.size.height>500) {
        tabeview = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, 320, 200) style:UITableViewStyleGrouped];
    }
    else
    {
         tabeview = [[UITableView alloc] initWithFrame:CGRectMake(0, 170, 320, 200) style:UITableViewStyleGrouped];
    }
  
    tabeview.backgroundView = nil;
    tabeview.scrollEnabled = NO;
    tabeview.dataSource = self;
    tabeview.delegate = self;
    [self.view addSubview:tabeview];
    [tabeview release];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

//-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section ==0) {
        cell.textLabel.text = @"合作单位";
    }
    if (indexPath.section ==1) {
        cell.textLabel.text = @"合作媒体";
    }
    if (indexPath.section ==2) {
        cell.textLabel.text = @"常见投资机构";
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    if (indexPath.section == 0) {
        CooperaViewController *coopview = [[CooperaViewController alloc] init];
        [self.navigationController pushViewController:coopview animated:YES];
    }
    if (indexPath.section == 1) {
        CooperaViewController *coopview = [[CooperaViewController alloc] init];
        [self.navigationController pushViewController:coopview animated:YES];
    }
    if (indexPath.section == 2) {
        CooperaViewController *coopview = [[CooperaViewController alloc] init];
        [self.navigationController pushViewController:coopview animated:YES];
    }
}


//-(void)coopview
//{
//    CooperaViewController *coopview = [[CooperaViewController alloc] init];
//    [self.navigationController pushViewController:coopview animated:YES];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
