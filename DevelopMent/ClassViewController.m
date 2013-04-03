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

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
    
    listarray = [[NSMutableArray alloc] init];
    self.tableView.backgroundView = nil;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
     
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
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        [alertV release];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:cell.frame];
    imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell_bg_%d",indexPath.section%6]];
    cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
    cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
    cell.backgroundView = imageview;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    cell.textLabel.textColor = [UIColor grayColor];
   // cell.textLabel.frame = CGRectMake(50, 10, 200, 20);
    [imageview release];

    
           cell.textLabel.text =[NSString stringWithFormat:@"    %@",[[listarray  objectAtIndex:  indexPath.section] objectForKey:@"classname"]];
    

    
    

    return cell;
}

 
 

-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    if (na.tag ==100) {
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
}

@end
