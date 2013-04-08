//
//  ClassViewController.m
//  DevelopMent
//
//  Created by xin wang on 3/22/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//



#import "ClassViewController.h"
#import "SearchViewController.h"
 #import "ScanDevelopViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "UITools.h"
#import "calssCell.h"
#import "XDTabBarViewController.h"
#import "Yunju.h"

@interface ClassViewController ()

@end

@implementation ClassViewController
@synthesize listarray;
@synthesize gNetAccess = _gNetAccess;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
       AppDelegate*mydelegate = [UIApplication sharedApplication].delegate;
        if ([mydelegate.language isEqualToString:@"china"]) {
            self.title = @"分类";
        }
     else
        {
            self.title = @"Classification";
        }
  
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
    
    listarray = [[NSMutableArray alloc] init];
    self.tableView.backgroundView = nil;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
    NSArray*pathss=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString*pat=[pathss objectAtIndex:0];
    NSString *filenames=[pat stringByAppendingPathComponent:@"Class.plist"];
    listarray=[[NSMutableArray alloc]initWithContentsOfFile:filenames];
     
    NetAccess *netAccess = [[NetAccess alloc]init];
    _gNetAccess = netAccess;
    
    if (listarray.count != 0) {
        [self.tableView reloadData];
    }
    [self asihttp];
     
}

-(void)asihttp
{
    
    AppDelegate *mydelegate = [UIApplication sharedApplication].delegate;
    if([NetAccess reachable])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString*string1 = @"{\"type\":\"";
        NSString*string2 = [NSString stringWithFormat:@"%@\"}",mydelegate.language];
        NSMutableString*alltring = [[NSMutableString alloc] init];
        [alltring appendString:string1];
        [alltring appendString:string2];
        _gNetAccess.delegate = self;
        _gNetAccess.tag = 100;
        [_gNetAccess theclassmessage:alltring];
    }
    else
    {
        AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
        if ([delegate.language isEqualToString:@"china"])
        {
            [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:ErrorInternet];
        }
        else
        {
            [UITools showPopMessage:self titleInfo:@"Internet Contact" messageInfo:ErrorInternetEnglish];
        }

        
    }

}

-(void)searcharea
{
    SearchViewController *search  = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    return listarray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  37;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    calssCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[calssCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:cell.frame];
    imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell_bg_%d",indexPath.section%6]];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor =[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0.4];;
    cell.backgroundView = imageview;
    
    cell.label.text =[NSString stringWithFormat:@"%@",[[listarray  objectAtIndex:  indexPath.section] objectForKey:@"classname"]];
    NSLog(@"%s:%@", __PRETTY_FUNCTION__, cell.label.text);

    return cell;
}

 
#pragma mark -- NetAccessDelegate

- (void)netAccess:(NetAccess *)netAccess RequestFailed:(NSMutableArray *)resultSet
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:ErrorConnect];
}

-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    if (na.tag ==100) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (resultSet.count !=0) {
            [listarray removeAllObjects];
            listarray = resultSet;
            [self.tableView reloadData];
            
            NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString*path=[paths objectAtIndex:0];
            NSString *filename=[path stringByAppendingPathComponent:@"Class.plist"];
            [listarray writeToFile:filename atomically:YES];
        }
        
    }
}

 
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    ScanDevelopViewController *developview = [[ScanDevelopViewController alloc] initWithclassId:[[listarray objectAtIndex:indexPath.section] objectForKey:@"id"] stringnum:0];
     
    [self.navigationController pushViewController:developview animated:YES];

}

@end
