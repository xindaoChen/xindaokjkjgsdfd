//
//  ScanDevelopViewController.m
//  DevelopMent
//
//  Created by xindaoapp on 13-3-26.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import "ScanDevelopViewController.h"
#import "MyCell.h"
#import "SearchViewController.h"
//#import "SearchViewController.h"
#import "ArticleViewController.h"
//#import "PopTableView.h"
@interface ScanDevelopViewController ()

@end

@implementation ScanDevelopViewController

@synthesize searchfield,listarray,listarray2,listarray3,listarray4,listarray5, searchtable,assAiv,showCityView,showIndustryView,showLevelView,allProvinceArray,allLevelArray,allIndustryArray,provinceView,levelView,IndustryView,cityView,getDevelopZoneInfo,inid,leid,cid,getCityName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


-(id)initWithnumber:( NSInteger)stringnum
{
    self = [super init];
    if (self) {
        num = stringnum + 1;
        cid = @"";
    }
    return self;
}

-(id)initwithclassId:(NSString *)classid stringnum:(NSInteger)stringnum
{
    self = [super init];
    if (self) {
        num = stringnum;
        cid = classid;
    }
    return  self;
}

-(id)initwithcityname:(NSString *)name
{
    self = [super init];
    if (self) {
        provinceName = name;
        cid = @"";
        flagForInit = 10000;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"开发区";
    allListArray = [[NSMutableArray alloc]init];
    
    levelName = @"全部";
    
    industryName = @"全部";
    contectFlag = @"a";
    inid = @"";
    leid = @"";
    tempprovinceName = @"";
 //   pagenum = 1;
    developnumhasget = 0;
   // cid = @"";
    //	self.title = @"搜索";
    allProvinceArray = [[NSMutableArray alloc] initWithObjects:@"全国",@"北京",@"天津",@"上海",@"重庆",@"河北", @"山西",@"辽宁",@"吉林",@"黑龙江",@"江苏",@"浙江",@"安徽",@"山东",@"广东",@"江西",@"内蒙古",@"广西",@"西藏",@"宁夏",@"新疆",@"河南",@"海南",@"湖南",@"福建",@"贵州",@"云南",@"湖北",@"甘肃",@"四川",@"青海",@"陕西",@"台湾",@"香港",@"澳门",nil];
//    allLevelArray = [[NSArray alloc]initWithObjects:@"国家级",@"省级",@"市级",@"全部", nil];
//    allIndustryArray =[[NSMutableArray alloc]initWithObjects:@"计算机",@"生物",@"航空",@"图形识别", nil];
    if (flagForInit != 10000) {   //判断上一个界面传的值是市名还是下标。若不是市名，从数组中提取市名。
        provinceName = [allProvinceArray objectAtIndex:num];
    }
   // provinceName = [allProvinceArray objectAtIndex:num];
    assAiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    assAiv.center = CGPointMake(160, 240);
    assAiv.color = [UIColor blackColor];
    [self.navigationController.navigationBar addSubview:assAiv];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGRect frame = self.view.frame;
    
    listarray = [[NSMutableArray alloc] init];
   //listarray2 = [[NSMutableArray alloc] init];
    listarray3 = [[NSMutableArray alloc] init];
    listarray4 = [[NSMutableArray alloc] init];
    listarray5 = [[NSMutableArray alloc] init];
    
    searchtable = [[PullTableView alloc]initWithFrame:CGRectMake(0, 40, 320, self.view.frame.size.height-84)];
    searchtable.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    searchtable.pullBackgroundColor = [UIColor redColor];
    searchtable.pullTextColor = [UIColor whiteColor];
    
 // searchtable.rowHeight = 100;
    searchtable.pullDelegate = self;
    searchtable.delegate = self;
    searchtable.dataSource = self;
    searchtable.tag = 1;
    [self.view addSubview:searchtable];    
   getDevelopZoneInfo = [[NSString alloc]initWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\",\"levelid\":\"\",\"trade\":\"\",\"cid\":\"%@\"}",provinceName,cid];
   // NSLog(@"%@",getDevelopZoneInfo);
    if ([cid isEqualToString:@""]) {
        getCityName = [NSString stringWithFormat:getCityName = @"{\"type\":\"china\",\"prov\":\"%@\"}",provinceName] ;
        [self showCityName];
    }
//    getCityName = [NSString stringWithFormat:getCityName = @"{\"type\":\"china\",\"prov\":\"%@\"}",provinceName] ;
//    [self showCityName];
    [self showdevelopZone];
    [self showLevelList];
    [self showIndustryList];

    
 
    
    provincebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    provincebutton.frame = CGRectMake(0, 0,frame.size.width/3, 40);
    provincebutton.backgroundColor = [UIColor grayColor];
    [provincebutton setTitle:[NSString stringWithFormat:@"%@",provinceName] forState:UIControlStateNormal];
   
    [provincebutton addTarget:self action:@selector(showCity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:provincebutton];
    
    levelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    levelbutton.frame = CGRectMake(frame.size.width/3+1, 0,frame.size.width/3-1, 40);
    levelbutton.backgroundColor = [UIColor grayColor];
    [levelbutton setTitle:[NSString stringWithFormat:@"%@",levelName] forState:UIControlStateNormal];
    [levelbutton addTarget:self action:@selector(showLevel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:levelbutton];
    
    
    industrybutton = [UIButton buttonWithType:UIButtonTypeCustom];
    industrybutton.frame = CGRectMake(2*frame.size.width/3+1, 0,frame.size.width/3, 40);

    industrybutton.backgroundColor = [UIColor grayColor];
    [industrybutton setTitle:[NSString stringWithFormat:@"%@",industryName] forState:UIControlStateNormal];
    [industrybutton addTarget:self action:@selector(showIndustry) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:industrybutton];
    
    showCityView = [[UIView alloc]init];
    showCityView.frame = CGRectMake(0,40, 320, frame.size.height-84);
    UIColor *bgColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0.8];
    showCityView.backgroundColor = bgColor;
    
    showCityView.hidden = YES;
    [self.view addSubview:showCityView];
    
    showLevelView = [[UIView alloc]init];
    showLevelView.frame = CGRectMake(0, 40, 320,frame.size.height-84 );
    showLevelView.hidden = YES;
    [self.view addSubview:showLevelView];
    
    showIndustryView = [[UIView alloc]init];
    showIndustryView.frame = CGRectMake(0, 40, 320, frame.size.height-84);
    showIndustryView.hidden = YES;
    [self.view addSubview:showIndustryView];
    
    
    provinceView = [[UITableView alloc]initWithFrame:CGRectMake(10, 5, 100, frame.size.height-109)];
    cityView = [[UITableView alloc]initWithFrame:CGRectMake(112, 5, 198, frame.size.height-109)];
    
    
    provinceView.delegate = self;
    provinceView.dataSource = self;
    provinceView.tag = 2;
    cityView.delegate = self;
    cityView.dataSource = self;
    cityView.tag = 3;
    [showCityView addSubview:provinceView];
    [showCityView addSubview:cityView];

    
    
    showLevelView.backgroundColor = bgColor;
    levelView = [[UITableView alloc]initWithFrame:CGRectMake(10, 5, 300, frame.size.height-109)];
    levelView.delegate = self;
    levelView.dataSource = self;
    levelView.tag = 4;
    [showLevelView addSubview:levelView];
    
    
    showIndustryView.backgroundColor = bgColor;
    IndustryView = [[UITableView alloc]initWithFrame:CGRectMake(10, 5, 300, frame.size.height-109)];
    IndustryView.delegate = self;
    IndustryView.dataSource = self;
    IndustryView.tag = 5;
    [showIndustryView addSubview:IndustryView];
    
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10, 2, 40, 40);
    [button2 setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(backtosuper) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnTopItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.leftBarButtonItem = leftBtnTopItem;
    [leftBtnTopItem release];
    
}


-(void)backtosuper
{
    [self.navigationController   popViewControllerAnimated:YES];
}

 
-(void)showdevelopZone
{
    
    if([NetAccess reachable])
    {
        NetAccess *netAccess = [[NetAccess alloc]init];
        netAccess.delegate = self;
        netAccess.tag = 100;
        [netAccess thedevelopZone:getDevelopZoneInfo];
        [assAiv startAnimating];
        
        //  [getDevelopZoneInfo release];
    }
    else
    {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        [alertV release];
    }
    
    
}


-(void)showCityName
{
    
   
 //   getCityName = @"{\"type\":\"china\",\"prov\":\"辽宁\"}";
    if([NetAccess reachable])
    {
        NetAccess *netAccess2 = [[NetAccess alloc]init];
        netAccess2.delegate = self;
        netAccess2.tag = 150;
        [netAccess2 thecityName:getCityName];
        NSLog(@"!!!!!!!!!!!!!!");
        [assAiv startAnimating];
       
       // [getCityName release];
    }
    else
    {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"!!!!!!!!!!无网络可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        [alertV release];
    }
    
   
    
}

-(void)showLevelList
{
    NSString *getLevelList = @"{\"type\":\"china\"}";
    if([NetAccess reachable])
    {
        NetAccess *netAccess3 = [[NetAccess alloc]init];
        netAccess3.delegate = self;
        netAccess3.tag = 151;    //tag = 151 ,levellist
        [netAccess3 thelevelList:getLevelList];
        
        [assAiv startAnimating];
        [getLevelList release];
    }
    else
    {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        [alertV release];
    }
    
    
}

-(void)showIndustryList
{
    NSString *getIndustryList = @"{\"type\":\"china\"}";
    if([NetAccess reachable])
    {
        NetAccess *netAccess4 = [[NetAccess alloc]init];
        netAccess4.delegate = self;
        netAccess4.tag = 152;    //tag = 151 ,levellist
        [netAccess4 theindustryList:getIndustryList];
        [assAiv startAnimating];
        
        [getIndustryList release];
       
    }
    else
    {
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        [alertV release];
    }

    
}




-(void)showCity
{

    showLevelView.hidden = YES;
    showIndustryView.hidden = YES;
    if (showCityView.hidden == YES) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
        [UIView setAnimationDelegate:self];
        // 动画完毕后调用某个方法
        //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
        [UIView commitAnimations];

    }
    else if(showCityView.hidden == NO)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        [UIView setAnimationDelegate:self];
        // 动画完毕后调用某个方法
        //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
        [UIView commitAnimations];

    }
   
    [provinceView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    showCityView.hidden = !showCityView.hidden;

    int x=0 ;
    NSLog(@"111111%@",provinceName);
    for (int i = 0; i < allProvinceArray.count; i++) {
        if ([tempprovinceName isEqualToString:@""]) {
            if ([provinceName isEqualToString:[allProvinceArray objectAtIndex:i]]) {
                x = i;
                break;
            }
        }
       else if ([tempprovinceName isEqualToString:[allProvinceArray objectAtIndex:i]]) {
            x = i;
            break;
        }
    }
    [provinceView selectRowAtIndexPath:[NSIndexPath indexPathForRow:x inSection:0]animated:NO scrollPosition:UITableViewScrollPositionTop];
    [cityView reloadData];
    
}

-(void)showLevel
{showCityView.hidden = YES;
    showIndustryView.hidden = YES;
    
    if (showLevelView.hidden == YES) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
        [UIView setAnimationDelegate:self];
        // 动画完毕后调用某个方法
        //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
        [UIView commitAnimations];
        
    }
    else if(showLevelView.hidden == NO)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        [UIView setAnimationDelegate:self];
        // 动画完毕后调用某个方法
        //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
        [UIView commitAnimations];
        
    }

    
    showLevelView.hidden = !showLevelView.hidden;
    [levelView reloadData];
//    if(showLevelView.hidden == NO)
//    {
//        [self showLevelList];
//    }
    // [levelView release];
    
}
-(void)showIndustry
{ showCityView.hidden = YES;
    showLevelView.hidden = YES;
    if (showIndustryView.hidden == YES) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
        [UIView setAnimationDelegate:self];
        // 动画完毕后调用某个方法
        //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
        [UIView commitAnimations];
        
    }
    else if(showIndustryView.hidden == NO)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        [UIView setAnimationDelegate:self];
        // 动画完毕后调用某个方法
        //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
        [UIView commitAnimations];
        
    }
     showIndustryView.hidden = !showIndustryView.hidden;
    [IndustryView reloadData];
    
//    if (showIndustryView.hidden == NO) {
//        [self showIndustryList];
//    }
    // [IndustryView release];
}
-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    [assAiv stopAnimating];
    if (na.tag ==100) {
        [listarray removeAllObjects];
        listarray = resultSet;
        [listarray retain];
        if (listarray.count != 0) {
            for (id obj in listarray) {
                [allListArray addObject:obj];
            }
        }
       // developnumhasget = developnumhasget + listarray.count;
        [searchtable reloadData];
        
    }
    if (na.tag == 150) {
        
     
        [listarray3 removeAllObjects];
        
        listarray3 = resultSet;
        [listarray3 retain];
        
        [cityView reloadData];
    }
    if (na.tag == 151) {
        
       
        [listarray4 removeAllObjects];
        
        listarray4 = resultSet;
        [listarray4 retain];
       
       // [levelView reloadData];
    }
    if (na.tag == 152) {
         
       
        [listarray5 removeAllObjects];
       
        listarray5 = resultSet;
        [listarray5 retain];
       
       // [IndustryView reloadData];
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [searchfield resignFirstResponder];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (tableView.tag == 1) {
//        return listarray.count;
//    }
    
    switch (tableView.tag) {
        case 1:
//            if (listarray.count ==2) {
//                return developnumhasget + 1;
//            }
//            else{
          //  return developnumhasget ;
          //  }
            return allListArray.count;
                break;
        case 2:
            return allProvinceArray.count;
            break;
        case 3:
            return listarray3.count;
            break;
        case 4:
            return listarray4.count + 1;
            break;
        case 5:
            return listarray5.count + 1;
            break;
        default:
            return  1;
            break;
    }
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   if(tableView.tag == 1)
         return 80;
    else if (tableView.tag == 2)
        return 40;
    else if(tableView.tag == 3)
        return  40;
    else if (tableView.tag == 4)
        return 40;
    else if(tableView.tag == 5)
        return 40;
    else
        return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    switch (tableView.tag) {
        case 1:   //主界面tableview
            
            if (cell == nil) {
                cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
           // if (developnumhasget-listarray.count < developnumhasget) {   //防止listarray.count == 0 的情况
                
            
            for (int i = 0 ; i< allListArray.count; i++)
            {
                if (indexPath.row == i )
                { NSLog(@"1");
                    cell.label.text = [[allListArray objectAtIndex:i] objectForKey:@"developname"];
                    cell.labeltwo.text = [[allListArray objectAtIndex:i] objectForKey:@"content"];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSString *url = [NSString stringWithFormat:@"http://192.168.1.105:8010/assets/cityimage/%@",[[allListArray objectAtIndex:i] objectForKey:@"deveimage"]];
                        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
                        UIImage *image = [[UIImage alloc]initWithData:data];
                        if (data != nil) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [cell.imageview setImage:image];
                            });
                        }
                        [data release];
                        [image release];
                    });
                }
            }
         //   }
       
            //            if (indexPath.row == developnumhasget)
//            {
//                cell.label.text = @"点击继续加载";
//            }
            return cell;
        case 2: //provinceVIew
            if (cell == nil) {
                cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            }
            cell.textLabel.text = [allProvinceArray objectAtIndex:indexPath.row];
      
                 
            return cell;
            break;
        case 3: //  cityView
            if (cell == nil) {
                cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            }
            cell.textLabel.text = [[listarray3 objectAtIndex:indexPath.row] objectForKey:@"cityname"];
            return cell;
            break;
        case 4:   //levelVIew
            if (cell == nil) {
                cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            }
            if (indexPath.row == 0) {
                 cell.textLabel.text = @"全部";
                 return cell;
            }
            else{
            cell.textLabel.text = [[listarray4 objectAtIndex:indexPath.row-1] objectForKey:@"levelname"];
            }
            return cell;
            break;
        case 5:   //industry view
            if (cell == nil) {
                cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            }
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"全部";
                return cell;
            }
            else{

            cell.textLabel.text = [[listarray5 objectAtIndex:indexPath.row - 1] objectForKey:@"name"];
            }
           
            return cell;
            break;
            
        default:
            if (cell == nil) {
                cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            }
            return cell;
            break;
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    for (int i =0 ; i<listarray.count; i++)
    //    {
    //        if (indexPath.row == i )
    //        {
    //            cell.label.text = [[listarray objectAtIndex:i] objectForKey:@"developname"];
    //            cell.labeltwo.text = [[listarray objectAtIndex:i] objectForKey:@"content"];
    //              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //                 NSString *url = [NSString stringWithFormat:@"http://192.168.1.113:8010/assets/cityimage/%@",[[listarray objectAtIndex:i] objectForKey:@"deveimage"]];
    //                  NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    //                 UIImage *image = [[UIImage alloc]initWithData:data];
    //                 if (data != nil) {
    //                     dispatch_async(dispatch_get_main_queue(), ^{
    //                        [cell.imageview setImage:image];
    //                     });
    //                 }
    //             });
    //         }
    //     }
    //     return cell;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [assAiv stopAnimating];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 1:
            [searchtable deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
            ArticleViewController *artiview = [[ArticleViewController alloc] initWithurl:[allListArray objectAtIndex:indexPath.row]];
            [self.navigationController pushViewController:artiview animated:YES];
            break;
        case 2:
       [provinceView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
            if ([[allProvinceArray objectAtIndex:indexPath.row] isEqualToString:@"全国"]) {
                provinceName = [allProvinceArray objectAtIndex:indexPath.row];
                [provincebutton setTitle:provinceName forState:UIControlStateNormal];
                getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\"}",provinceName];
                levelbutton.titleLabel.text = @"全部";
                industrybutton.titleLabel.text = @"全部";
                inid= @"";
                leid = @"";
                tempprovinceName =@"";
                
                [provinceName retain];
                
                    CGContextRef context2 = UIGraphicsGetCurrentContext();
                    [UIView beginAnimations:nil context:context2];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                    [UIView setAnimationDuration:0.7];
                    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
                    [UIView setAnimationDelegate:self];
                    // 动画完毕后调用某个方法
                    //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
                    [UIView commitAnimations];
              
                developnumhasget = 0;
                [allListArray release];
          allListArray  = [[NSMutableArray alloc]init];
           //     pagenum = 1;
                showCityView.hidden = !showCityView.hidden;
                [self showdevelopZone];


            }
            else{
            getCityName = [NSString stringWithFormat:getCityName = @"{\"type\":\"china\",\"prov\":\"%@\"}",[allProvinceArray objectAtIndex:indexPath.row]] ;
                provinceName = [allProvinceArray objectAtIndex:indexPath.row] ;
            [self showCityName];
            }
            break;
        case 3:
        [cityView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
            tempprovinceName = provinceName;
            provinceName = [[listarray3 objectAtIndex:indexPath.row] objectForKey:@"cityname"];
           [provincebutton setTitle:provinceName forState:UIControlStateNormal];
        
            getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\"}",provinceName];
            levelbutton.titleLabel.text = @"全部";
            industrybutton.titleLabel.text = @"全部";
            inid= @"";
            leid = @"";
            
            [provinceName retain];
            CGContextRef context3 = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:nil context:context3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.7];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
            [UIView setAnimationDelegate:self];
            // 动画完毕后调用某个方法
            //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
            [UIView commitAnimations];
            
           // [provinceView init];
            developnumhasget = 0;
            [allListArray release];
            allListArray  = [[NSMutableArray alloc]init];

            showCityView.hidden = !showCityView.hidden;
//            [provinceView init];
//            developnumhasget = 0;
            [self showdevelopZone];
            
            break;
        case 4:
         [levelView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
            if (indexPath.row >0 && indexPath.row <= listarray4.count) {
                [levelbutton setTitle:[[listarray4 objectAtIndex:indexPath.row - 1] objectForKey:@"levelname"] forState:UIControlStateNormal];
                leid = [[listarray4 objectAtIndex:indexPath.row-1] objectForKey:@"id"];
            }
            else
            {
               [levelbutton setTitle:@"全部" forState:UIControlStateNormal];
                leid = @"";
            }
            
            getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\",\"levelid\":\"%@\",\"trade\":\"%@\",\"cid\":\"%@\"}",provinceName,leid,inid,cid];

         //   leid = [[listarray4 objectAtIndex:indexPath.row] objectForKey:@"id"];
            [leid retain];
            CGContextRef context4 = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:nil context:context4];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.7];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
            [UIView setAnimationDelegate:self];
            // 动画完毕后调用某个方法
            //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
            [UIView commitAnimations];
            
           // [provinceView init];
            developnumhasget = 0;
            [allListArray release];
            allListArray  = [[NSMutableArray alloc]init];


            showLevelView.hidden = !showLevelView.hidden;
            [self showdevelopZone];
            break;
            
        case 5:
        [IndustryView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
            if (indexPath.row >0 && indexPath.row <= listarray5.count) {
               [industrybutton setTitle:[[listarray5 objectAtIndex:indexPath.row-1] objectForKey:@"name"] forState:UIControlStateNormal];
                inid = [[listarray5 objectAtIndex:indexPath.row-1] objectForKey:@"id"];
            }
            else
            {
                [industrybutton setTitle:@"全部" forState:UIControlStateNormal];
                inid = @"";
            }

            
            
         //   [industrybutton setTitle:[[listarray5 objectAtIndex:indexPath.row] objectForKey:@"name"] forState:UIControlStateNormal];
            getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\",\"levelid\":\"%@\",\"trade\":\"%@\",\"cid\":\"%@\"}",provinceName,leid,inid,cid];
           
           // inid = [[listarray5 objectAtIndex:indexPath.row] objectForKey:@"id"];
            [inid retain];
            
            CGContextRef context5 = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:nil context:context5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.7];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
            [UIView setAnimationDelegate:self];
            // 动画完毕后调用某个方法
            //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
            [UIView commitAnimations];
            
          //  [provinceView init];
            developnumhasget = 0;
            [allListArray release];
            allListArray  = [[NSMutableArray alloc]init];

            showIndustryView.hidden = !showIndustryView.hidden;
          
            [self showdevelopZone];
                    break;
        default:
          
            break;
    }
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    
//    [super viewWillAppear:animated];
//    if(searchtable.pullTableIsRefreshing) {
//        searchtable.pullTableIsRefreshing = YES;
//        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
//    }
//}


-(void)viewDidUnload
{
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    
//    [super viewWillAppear:animated];
//    if(!searchtable.pullTableIsRefreshing) {
//        searchtable.pullTableIsRefreshing = YES;
//        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
//    }
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//- (void) refreshTable
//{
//    /*
//     
//     Code to actually refresh goes here.
//     
//     */
//    searchtable.pullLastRefreshDate = [NSDate date];
//   searchtable.pullTableIsRefreshing = NO;
//}


- (void) loadMoreDataToTable
{
    /*
     
     Code to actually load more data goes here.
    */
    if (listarray.count == 0) {
        //提醒没有数据了
    }
    else{
            getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\",\"levelid\":\"%@\",\"trade\":\"%@\",\"cid\":\"%@\",\"time\":\"%@\"}",provinceName,leid,inid,cid,[[listarray objectAtIndex:(listarray.count - 1)]objectForKey:@"time"] ];
    
    NSLog(@"%@",getDevelopZoneInfo);
        
    
        //pagenum = allListArray.count/5 + 1;
        
        [provinceName retain];
        [self showdevelopZone];
    
    }
  searchtable.pullTableIsLoadingMore = NO;
}


//- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
//{
//    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
//}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:0.0f];
}




-(void)dealloc
{   [allProvinceArray release];allProvinceArray = nil;
    [allListArray release];allListArray = nil;
    [listarray release];listarray = nil;
    [listarray3 release];listarray3 = nil;
    [listarray4 release];listarray4 = nil;
    [listarray5 release];listarray5 = nil;
    [assAiv release]; assAiv = nil;
    [showCityView release];showCityView = nil;
    [showIndustryView release];showIndustryView = nil;
    [showLevelView release];showLevelView = nil;
    [provinceView release];provinceView = nil;
    [cityView release];cityView = nil;
    [levelView release];levelView = nil;
    [IndustryView release];IndustryView = nil;
    [getDevelopZoneInfo release];getDevelopZoneInfo = nil;
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
   
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
