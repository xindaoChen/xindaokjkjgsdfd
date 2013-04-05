//
//  CooperaViewController.m
//  DevelopMent
//
//  Created by xin wang on 3/23/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import "CooperaViewController.h"
#import "MyCell.h"
#import "UITools.h"
#import "AppDelegate.h"
#import "XDTabBarViewController.h"

@interface CooperaViewController ()

@end

@implementation CooperaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_view_bg"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
    self.navigationItem.leftBarButtonItem = [UITools getNavButtonItem:self];

    mytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 504) style:UITableViewStylePlain];
    mytableview.delegate = self;
    mytableview.dataSource = self;
    [self.view addSubview:mytableview];

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

-(void)backtosuper
{
//    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:NO];
    [self.navigationController   popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
