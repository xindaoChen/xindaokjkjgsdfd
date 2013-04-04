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

@interface ClassViewController ()

@end

@implementation ClassViewController
@synthesize listarray;
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
//    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:NO];
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
        NetAccess *netAccess = [[NetAccess alloc]init];
        netAccess.delegate = self;
        netAccess.tag = 100;
        [netAccess theclassmessage:alltring];
    }
    else
    {
        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:@"对不起,没有网络\n请检查网络网络是否打开"];
    }

}

-(void)searcharea
{
    SearchViewController *search  = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
//    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:YES];

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
     //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:cell.frame];
    imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell_bg_%d",indexPath.section%6]];
    cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
    cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
    cell.backgroundView = imageview;
    
        cell.label.text =[NSString stringWithFormat:@"%@",[[listarray  objectAtIndex:  indexPath.section] objectForKey:@"classname"]];
    NSLog(@"##################################%@",cell.label.text);
    //label.font = [UIFont fontWithName:@"Helvetica" size:15.0];
   // label.backgroundColor = [UIColor clearColor];
    
    
  //  [cell addSubview:label];
    [imageview release];
   // [label release];

    
       
    

    
    

    return cell;
}

 
 

-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    if (na.tag ==100) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        [listarray removeAllObjects];
        listarray = resultSet;
        [listarray retain];
        NSLog(@"%@",listarray);
         [self.tableView reloadData];
        NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString*path=[paths objectAtIndex:0];
        NSString *filename=[path stringByAppendingPathComponent:@"Class.plist"];
        [listarray writeToFile:filename atomically:YES];
       
    }
}



-(void)dealloc
{
    [listarray release];listarray = nil;
    [super dealloc];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




 
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    ScanDevelopViewController *developview = [[ScanDevelopViewController alloc] initwithclassId:[[listarray objectAtIndex:indexPath.section] objectForKey:@"id"] stringnum:0];
     
    [self.navigationController pushViewController:developview animated:YES];
//    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:YES];

}

@end
