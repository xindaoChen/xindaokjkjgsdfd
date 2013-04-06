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
#import "MBProgressHUD.h"
#import "UITools.h"
#import "XDTabBarViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize listarray,searchtable;

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

    listarray = [[NSMutableArray alloc] init];
    imageDic  = [[NSMutableDictionary alloc] init ];
    UIView *firstview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    firstview.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:firstview];
  
    AppDelegate *mydelegate = [UIApplication sharedApplication].delegate;
    searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 6, 300, 30)];
    searchbar.delegate = self;
    [searchbar becomeFirstResponder];
    if ([mydelegate.language isEqualToString:@"china"]) {
        searchbar.placeholder = @"请输入您要搜索的开发区名字";
    }
    else
    {
      searchbar.placeholder =@"Please enter your search keyword";
    }
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
    button2.frame = CGRectMake(0, 2, 40, 40);
    [button2 setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(backtosuper) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnTopItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.leftBarButtonItem = leftBtnTopItem;
    NetAccess *netAccess = [[NetAccess alloc]init];
    _gNetAccess= netAccess;
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
 
    [searchBar resignFirstResponder];
    AppDelegate *appdele = [UIApplication sharedApplication].delegate;
    NSString *allstring = [NSString stringWithFormat:@"{\"type\":\"%@\",\"search\":\"%@\"}",appdele.language,searchbar.text];
    NSLog(@"%@",allstring);
    if([NetAccess reachable])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _gNetAccess.delegate = self;
        _gNetAccess.tag = 100;
        [_gNetAccess searchthemessage:allstring];
        
    }
    else
    {
        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:@"对不起,没有网络\n请检查网络网络是否打开"];
    }
    

}

-(void)backtosuper
{
    [_gNetAccess cancelAsynchronousRequest];
    [self.navigationController   popViewControllerAnimated:YES];
}
 


#pragma mark -- NetAccessDelegate

- (void)netAccess:(NetAccess *)netAccess RequestFailed:(NSMutableArray *)resultSet
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if (na.tag ==100) {
//        [listarray removeAllObjects];
        listarray = resultSet;
        
        NSLog(@"%@",listarray);
        [ searchbar resignFirstResponder];
        if (listarray.count != 0) {
            [searchtable reloadData];
        }
        else
        {
           [UITools showPopMessage:self titleInfo:@"提示" messageInfo:@"没有搜索结果"];        }
        
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
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     }
 
    if (listarray.count != 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.label.text = [[listarray objectAtIndex:indexPath.row] objectForKey:@"developname"];
        cell.labeltwo.text = [[listarray objectAtIndex:indexPath.row] objectForKey:@"content"];
        
        NSString *index_row = [NSString stringWithFormat:@"%d", indexPath.row];
        
        if ([imageDic objectForKey:index_row] != nil) {
            UIImage *image1 = [imageDic objectForKey:[NSNumber numberWithInt:indexPath.row]];
            [cell.imageview setImage: image1];
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *url = [NSString stringWithFormat:
                                 @"%@%@%@",
                                 HOST_URL, API_DEVELOPIAMGE,
                                 [[listarray objectAtIndex:indexPath.row] objectForKey:@"deveimage"]];
                 NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
                UIImage *image = [[UIImage alloc]initWithData:data];
                if (data != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell.imageview setImage:image];
                        [imageDic setObject:image forKey:[NSNumber numberWithInt:indexPath.row]];
                    });
                }
            });
    

        }

        

    }
   
   
    return  cell;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

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

@end
