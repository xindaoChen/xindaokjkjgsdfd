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
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return listarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    for (int i = 0; i<listarray.count; i++) {
        if (indexPath.row == i ) {
            cell.textLabel.text = [[listarray  objectAtIndex:i] objectForKey:@"classname"];
        }
    }
    
    

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    ScanDevelopViewController *developview = [[ScanDevelopViewController alloc] initwithclassId:[[listarray objectAtIndex:indexPath.row] objectForKey:@"id"] stringnum:0];
     
    [self.navigationController pushViewController:developview animated:YES];
}

@end
