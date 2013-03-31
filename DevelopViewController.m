//
//  DevelopViewController.m
//  DevelopMent
//
//  Created by xin wang on 3/20/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//


#import "DevelopViewController.h"
#import "ArticleViewController.h"
#import "SearchViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
@interface DevelopViewController ()

@end

@implementation DevelopViewController
@synthesize devetableview,hideview1,hideview2,backview,arrayone,cityarrray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(id)initWithnumber:( NSInteger )stringnum
{
    self = [super init];
    if (self) {
//        buttontag = stringnum;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"开发区";
    number = 1;
    number2 = 1;
         
    array1 = [[NSArray alloc] initWithObjects:@"a",@"s",@"d",@"f",@"g",@"h",@"k",@"l", nil];
    array2 = [[NSArray alloc] initWithObjects:@"aaa",@"ssss",@"111",@"2222",@"333",@"33344",@"5555",@"666",@"666777",@"8888",@"9999", nil];
    cityarrray = [[NSMutableArray alloc] init];
    CGRect frame = self.view.frame;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0,frame.size.width/3, 40);
    [button1 setTitle:buttontag forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor lightGrayColor];
    UITapGestureRecognizer *tapSsImgView=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(yincang:)];
    [button1 addGestureRecognizer:tapSsImgView];

    UITapGestureRecognizer *tapSsImgView2=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(yincangtwo:)];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(frame.size.width/3+1, 0,frame.size.width/3-1, 40);
    button2.backgroundColor = [UIColor lightGrayColor];
    [button2 addTarget:self action:@selector(levelview) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"国家级" forState:UIControlStateNormal];
    [button2 addGestureRecognizer:tapSsImgView2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(2*frame.size.width/3+1, 0,frame.size.width/3, 40);
    button3.backgroundColor = [UIColor lightGrayColor];
    [button3 setTitle:@"行业" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
    
    arraylist = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *bu = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searcharea)];
    self.navigationItem.rightBarButtonItem = bu;
    
    devetableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 468) style:UITableViewStylePlain];
    devetableview.tag =100;
    devetableview.delegate = self;
    devetableview.dataSource = self;
   [self.view addSubview:devetableview];

    backview = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 468)];
    backview.backgroundColor = [UIColor blackColor];
    backview.alpha = 0.7;
    backview.hidden = YES;
    
    [self.view addSubview:backview];
    
    hideview1 = [[UITableView alloc] initWithFrame:CGRectMake(10, 55, 120, 380) style:UITableViewStylePlain];
    hideview1.delegate = self;
    hideview1.tag = 111;
    hideview1.dataSource = self;
    hideview1.backgroundColor = [UIColor lightGrayColor];
    hideview1.hidden = YES;
    [self.view addSubview:hideview1];
    
    hideview2 = [[UITableView alloc] initWithFrame:CGRectMake(130, 55, 180, 380) style:UITableViewStylePlain];
    hideview2.delegate = self;
    hideview2.tag = 222;
    hideview2.dataSource = self;
    hideview2.backgroundColor = [UIColor whiteColor];
    hideview2.hidden = YES;
    [self.view addSubview:hideview2];
    
    hideview3 = [[UITableView alloc] initWithFrame:CGRectMake(10, 55, 300, 380) style:UITableViewStylePlain];
    hideview3.delegate = self;
    hideview3.tag = 223;
    hideview3.dataSource = self;
    hideview3.backgroundColor = [UIColor whiteColor];
    hideview3.hidden = YES;
    [self.view addSubview:hideview3];

    hideview4 = [[UITableView alloc] initWithFrame:CGRectMake(10, 55, 300, 10) style:UITableViewStylePlain];
    hideview4.delegate = self;
    hideview4.tag = 224;
    hideview4.dataSource = self;
    hideview4.backgroundColor = [UIColor whiteColor];
    hideview4.hidden = YES;
    [self.view addSubview:hideview4];

    
     
}




-(void)viewWillAppear:(BOOL)animated
{
    

}




-(void)searcharea
{
    SearchViewController *search = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:NO];
}

-(void)levelview
{
    hideview1.hidden = YES;
     hideview2.hidden = YES;
    backview.hidden = NO;
     hideview3.hidden = NO;
}

-(void)yincangtwo:(UITapGestureRecognizer*) sender
{
    if (number2%2==0)
    {
        hideview1.hidden = YES;
        hideview2.hidden = YES;
        hideview3.hidden = YES;
        backview.hidden = YES;
    }
    else
    {
        hideview1.hidden = YES;
        hideview2.hidden = YES;
        hideview3.hidden = NO;
        backview.hidden = NO;
    }
   number2++;
}

-(void)yincang:(UITapGestureRecognizer*) sender
{
    
    if (number%2==0)
    {
        hideview1.hidden = YES;
        hideview2.hidden = YES;
        hideview3.hidden = YES;
        backview.hidden = YES;
    }
    else
    {
        hideview1.hidden = NO;
        hideview2.hidden = NO;
        hideview3.hidden = YES;
        backview.hidden = NO;
        UITapGestureRecognizer *tapSsImgView=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                    action:@selector(yincang:)];
        [backview addGestureRecognizer:tapSsImgView];

    }
    number++;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return 10;
    }
    else if (tableView.tag ==111)
        return arrayone.count;
    else if (tableView.tag == 222)
        return cityarrray.count;
    return 0;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        return 80;
    }
    else if (tableView.tag ==111)
        return 45;
    else if (tableView.tag == 222)
        return 45;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if (tableView.tag == 100) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 60)];
        imageview.backgroundColor = [UIColor redColor];
        [cell addSubview:imageview];
    }
    else if (tableView.tag == 111)
    {
        for (int i = 0; i<arrayone.count; i++)
        {
            if (indexPath.row ==i) {
                cell.textLabel.text = [arrayone objectAtIndex:i];
            }
            
        }
    }
    else if (tableView.tag == 222)
    {
        for (int i = 0; i<cityarrray.count; i++)
        {
            if (indexPath.row ==i) {
                cell.textLabel.text = [cityarrray objectAtIndex:i];
            }
            
        }
    }
  
     
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    [cityarrray removeAllObjects];
    if (tableView.tag == 100) {
       
    }
    else if (tableView.tag ==111)
    {
        switch (indexPath.row) {
            case 0:
                [cityarrray addObjectsFromArray:array1];
                NSLog(@"%@",cityarrray);
                [hideview2 reloadData];
                break;
            case 1:
                [cityarrray addObjectsFromArray:array2];
                [hideview2 reloadData];
            default:
                break;
        }
    }
    else if (tableView.tag ==222)
    {
       
    }
    else if (tableView.tag ==223)
    {
        
    }
    else if (tableView.tag == 224)
    {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
