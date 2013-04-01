//
//  SearchViewController.m
//  DevelopMent
//
//  Created by xin wang on 3/20/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//



#import "SearchViewController.h"
#import "ArticleViewController.h" 
#import "MyCell.h"
#import "AppDelegate.h"
@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize listarray,searchtable,assAiv;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"搜索";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
    assAiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    assAiv.center = CGPointMake(160, 240);
    assAiv.color = [UIColor blackColor];
    [self.navigationController.navigationBar addSubview:assAiv];

    listarray = [[NSMutableArray alloc] init];
    imageDic  = [[NSMutableDictionary alloc] init ];
    UIView *firstview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    firstview.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:firstview];
  
     
    
     searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 6, 300, 30)];
    searchbar.delegate = self;
    [searchbar becomeFirstResponder];
    searchbar.placeholder = @"请输入您要搜索的关键字";
    UIView *searview = [searchbar.subviews objectAtIndex:0];
    [searview removeFromSuperview];
    searview.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:1 alpha:0.5];
    [firstview addSubview:searchbar];
 

    searchtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 468) style:UITableViewStylePlain];
    searchtable.backgroundColor = [UIColor clearColor];
    searchtable.delegate = self;
    searchtable.dataSource = self;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_view_bg"]];
    [self.view addSubview:searchtable];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10, 2, 40, 40);
    [button2 setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(backtosuper) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnTopItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.leftBarButtonItem = leftBtnTopItem;
    [leftBtnTopItem release];
    
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    NSString *string1 = @"{\"search\":\"";
    NSString *string2 = [NSString stringWithFormat:@"%@\",",searchBar.text];
    NSString *string3 = @"\"type\":\"china\"}";
    NSMutableString *allstring = [[NSMutableString alloc] init];
    allstring = [[NSMutableString alloc] init];
    [allstring appendString:string1];
    [allstring appendString:string2];
    [allstring appendString:string3];
    
    if([NetAccess reachable])
    {
        NetAccess *netAccess = [[NetAccess alloc]init];
        netAccess.delegate = self;
        netAccess.tag = 100;
        [netAccess searchthemessage:allstring];
        [assAiv startAnimating];
        [allstring release];
    }
    else
    {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        [alertV release];
    }
    

}

-(void)backtosuper
{
    [self.navigationController   popViewControllerAnimated:YES];
}
 
 

-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    [assAiv stopAnimating];
    if (na.tag ==100) {
        [listarray removeAllObjects];
        listarray = resultSet;
        [listarray retain];
        NSLog(@"%@",listarray);
        [ searchbar resignFirstResponder];
        [searchtable reloadData];
    }
}


 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return listarray.count;
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
        cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
     }
 
 
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.label.text = [[listarray objectAtIndex:indexPath.row] objectForKey:@"developname"];
    cell.labeltwo.text = [[listarray objectAtIndex:indexPath.row] objectForKey:@"content"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       UIImage *image1 = [imageDic objectForKey:[NSNumber numberWithInt:indexPath.row]];
        if (image1 == nil) {
            NSString *url = [NSString stringWithFormat:@"http://192.168.1.105:8010/assets/cityimage/%@",[[listarray objectAtIndex:indexPath.row] objectForKey:@"deveimage"]];
           NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image = [[UIImage alloc]initWithData:data];
            if (data != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell.imageview setImage:image];
                    [imageDic setObject:image forKey:[NSNumber numberWithInt:indexPath.row]];
                   });
            }

         }
        else{
            [cell.imageview setImage: image1];
        }
  });

    NSLog(@"%@",imageDic);
    return  cell;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [assAiv stopAnimating];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [searchtable deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    ArticleViewController *artiview = [[ArticleViewController alloc] initWithurl:[listarray objectAtIndex:indexPath.row]];
      [self.navigationController pushViewController:artiview animated:YES];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
-(void)dealloc
{
    
    [listarray release];listarray = nil;
    [searchtable release];searchtable = nil;
    [assAiv release];assAiv = nil;
    [super dealloc];
}


@end
