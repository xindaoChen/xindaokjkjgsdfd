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
#import "ArticleViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "UITools.h"
#import "XDTabBarViewController.h"


#define UI_SCREEN_WIDTH                 320
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define UI_BLUE                    colorWithRed:24/255.0 green:134/255.0 blue:236/255.0 alpha:1.0

@interface ScanDevelopViewController ()

@end

@implementation ScanDevelopViewController

@synthesize searchfield,listarray,listarray2,listarray3,listarray4,listarray5, searchtable,showCityView,showIndustryView,showLevelView,allProvinceArray,allLevelArray,allIndustryArray,provinceView,levelView,IndustryView,cityView,getDevelopZoneInfo,inid,leid,cid,getCityName,provinceName;

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

-(id)initWithclassId:(NSString *)classid stringnum:(NSInteger)stringnum
{
    self = [super init];
    if (self) {
        num = stringnum;
        cid = classid;
    }
    return  self;
}

-(id)initWithcityname:(NSString *)name
{
    self = [super init];
    if (self) {
        self.provinceName = [NSString stringWithFormat:@"%@",name];
        NSLog(@"******(***%@",provinceName);
        cid = @"";
        flagForInit = 10000;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NetAccess *netAccess = [[NetAccess alloc] init];
     NetAccess *netAccess1 = [[NetAccess alloc] init];
     NetAccess *netAccess2 = [[NetAccess alloc] init];
     NetAccess *netAccess3 = [[NetAccess alloc] init];
    
    _gNetAccess = netAccess;
    _cityNetAccess = netAccess1;
    _levelNetAcess = netAccess2;
    _industryNetAcess = netAccess3;
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10, 2, 40, 40);
    [button2 setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(backtosuper) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnTopItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.leftBarButtonItem = leftBtnTopItem;    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_view_bg"]];

    allListArray = [[NSMutableArray alloc] init];
    imagesDictionary = [[NSMutableDictionary alloc] init];
    
    

    catchflag = 0;
    
    contectFlag = @"a";
    inid = @"";
    leid = @"";
    tempprovinceName = @"";
 
    developnumhasget = 0;
   // cid = @"";
    //	self.title = @"搜索";
    allProvinceArrayChina = [[NSMutableArray alloc] initWithObjects:@"全国",@"北京市",@"天津市",@"上海市",@"重庆市",@"河北省", @"山西省",@"辽宁省",@"吉林省",@"黑龙江省",@"江苏省",@"浙江省",@"安徽省",@"山东省",@"广东省",@"江西省",@"内蒙古",@"广西",@"西藏",@"宁夏",@"新疆",@"河南省",@"海南省",@"湖南省",@"福建省",@"贵州省",@"云南省",@"湖北省",@"甘肃省",@"四川省",@"青海省",@"陕西省",@"台湾省",@"香港",@"澳门",nil];
    
    allProvinceArrayEnglish = [[NSMutableArray alloc]initWithObjects:@"china",@"Beijing",@"Tianjing",@"Shanghai",@"Chongqing",@"Hebei",@"Shanxi",@"Liaoning",@"Jilin",@"Heilongjiang",@"Jiangsu",@"Zhejiang",@"Anhui",@"Shandong",@"Guangdong",@"Jiangxi",@"Neimenggu",@"Guangxi",@"Xizang",@"Ningxia",@"Xinjiang",@"Henan",@"Hainan",@"Hunan",@"Fujian",@"Guizhou",@"Yunnan",@"Hubei",@"Gansu",@"Sichuan",@"Qinghai",@"Shanxi",@"Taiwan",@"Hong Kong",@"Macau", nil];
    
    AppDelegate*mydelegate = [UIApplication sharedApplication].delegate;
    if ([mydelegate.language isEqualToString: @"english"]) {
        allProvinceArray = allProvinceArrayEnglish;
        languageFlag = @"english";
        levelName = @"level";
        industryName = @"industry";
        self.title = @" The DevelopeZone";
        
    }
    else if ([mydelegate.language isEqualToString:@"china"])
    {
        allProvinceArray = allProvinceArrayChina;
        languageFlag = @"china";
        levelName = @"级别";
        industryName = @"行业";
        self.title = @"开发区";
    }
    
    if (flagForInit != 10000) {   //判断上一个界面传的值是市名还是下标。若不是市名，从数组中提取市名。
        provinceName = [allProvinceArray objectAtIndex:num];
    }
   // provinceName = [allProvinceArray objectAtIndex:num];
  //  assAiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  //  assAiv.center = CGPointMake(160, 240);
  //  assAiv.color = [UIColor blackColor];
 //   [self.navigationController.navigationBar addSubview:assAiv];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGRect frame = self.view.frame;
    
    listarray = [[NSMutableArray alloc] init];
   //listarray2 = [[NSMutableArray alloc] init];
    listarray3 = [[NSMutableArray alloc] init];
    listarray4 = [[NSMutableArray alloc] init];
    listarray5 = [[NSMutableArray alloc] init];
    if (self.view.frame.size.height == 568) {
      //  searchtableheight =
    }
    searchtable = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, 320, self.view.frame.size.height-85)];
      searchtable.delegate = self;
    searchtable.dataSource = self;
    searchtable.tag = 1;
    [self.view addSubview:searchtable];    
   getDevelopZoneInfo = [[NSString alloc]initWithFormat: @"{\"type\":\"%@\",\"cityname\":\"%@\",\"levelid\":\"\",\"trade\":\"\",\"cid\":\"%@\"}",languageFlag,provinceName,cid];
   // NSLog(@"%@",getDevelopZoneInfo);
    if ([cid isEqualToString:@""]) {
        getCityName = [NSString stringWithFormat:getCityName = @"{\"type\":\"%@\",\"prov\":\"%@\"}",languageFlag,provinceName] ;
        [self showCityName];
      
    }
    
  

    [self showdevelopZone];
 
    [self showLevelList];
 
    [self showIndustryList];
 
    
    self.navigationItem.leftBarButtonItem = [UITools getNavButtonItem:self];
    
    provincebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    provincebutton.frame = CGRectMake(0, 0,106.5, 40);
    //[provincebutton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
  //  provincebutton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"buttonbackground1.png"]];
   // [provincebutton setTitle:[NSString stringWithFormat:@"%@",provinceName] forState:UIControlStateNormal];
     [provincebutton setBackgroundImage:[UIImage imageNamed:@"provincebutton1.png"] forState:UIControlStateNormal];
    
    [provincebutton addTarget:self action:@selector(showCity) forControlEvents:UIControlEventTouchUpInside];

    provinceLabel = [[UILabel alloc]initWithFrame:CGRectMake(2,5, 87, 30)];
    provinceLabel.backgroundColor = [UIColor clearColor];
    provinceLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    provinceLabel.text = provinceName;
    provinceLabel.textAlignment = UITextAlignmentCenter;
    provinceLabel.textColor = [UIColor grayColor];
    [provincebutton addSubview:provinceLabel];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/3, 0, 1, 40)];
    image.image = [UIImage imageNamed:@"sx"];
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(2*frame.size.width/3 + 1, 0, 1, 40)];
    image1.image = [UIImage imageNamed:@"sx"];
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(0,40,320,1)];
    image1.image = [UIImage imageNamed:@"hx"];

    levelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    levelbutton.frame = CGRectMake(106.5, 0,107, 40);
   // [levelbutton  setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    //levelbutton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"buttonbackground1.png"]];
   // [levelbutton setTitle:[NSString stringWithFormat:@"%@",levelName] forState:UIControlStateNormal];
      [levelbutton setBackgroundImage:[UIImage imageNamed:@"levelbutton1.png"] forState:UIControlStateNormal];
    [levelbutton addTarget:self action:@selector(showLevel) forControlEvents:UIControlEventTouchUpInside];
 
    levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(4,5, 93, 30)];
    levelLabel.backgroundColor = [UIColor clearColor];
    levelLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    levelLabel.text = levelName;
    levelLabel.textAlignment = UITextAlignmentCenter;
    levelLabel.textColor = [UIColor grayColor];
    [levelbutton addSubview:levelLabel];
    
    industrybutton = [UIButton buttonWithType:UIButtonTypeCustom];
    industrybutton.frame = CGRectMake(213.5, 0,106.5, 40);
    //[industrybutton  setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
   // industrybutton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"buttonbackground1.png"]];
   // [industrybutton setTitle:[NSString stringWithFormat:@"%@",industryName] forState:UIControlStateNormal];
    
    [industrybutton setBackgroundImage:[UIImage imageNamed:@"industrybutton1.png"] forState:UIControlStateNormal];
    [industrybutton addTarget:self action:@selector(showIndustry) forControlEvents:UIControlEventTouchUpInside];
    
    industryLabel = [[UILabel alloc]initWithFrame:CGRectMake(2,5, 85, 30)];
    industryLabel.backgroundColor = [UIColor clearColor];
    industryLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    industryLabel.textColor = [UIColor grayColor];
    industryLabel.text = industryName;
    industryLabel.textAlignment = UITextAlignmentCenter;
    [industrybutton addSubview:industryLabel];
    
    showCityView = [[UIView alloc]init];
    showCityView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, 320, frame.size.height-84);
    UIColor *bgColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0.8];
    showCityView.backgroundColor = bgColor;
 
   // showCityView.hidden = YES;
    [self.view addSubview:showCityView];
    
    showLevelView = [[UIView alloc]init];
    showLevelView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, 320,frame.size.height-84 );
  //  showLevelView.hidden = YES;
    [self.view addSubview:showLevelView];
    
    showIndustryView = [[UIView alloc]init];
    showIndustryView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, 320, frame.size.height-84);
   // showIndustryView.hidden = YES;
    [self.view addSubview:showIndustryView];
    
     
    provinceView = [[UITableView alloc]initWithFrame:CGRectMake(7, 4, 100, frame.size.height-129)];
    cityView = [[UITableView alloc]initWithFrame:CGRectMake(107, 4, 203, frame.size.height-129)];
    
    
    provinceView.delegate = self;
    provinceView.dataSource = self;
    provinceView.tag = 2;
    cityView.delegate = self;
    cityView.dataSource = self;
    cityView.tag = 3;
    [showCityView addSubview:provinceView];
    [showCityView addSubview:cityView];

    
    
    showLevelView.backgroundColor = bgColor;
    levelView = [[UITableView alloc]initWithFrame:CGRectMake(7, 4, 306, frame.size.height-129)];
    levelView.delegate = self;
    levelView.dataSource = self;
    levelView.tag = 4;
    [showLevelView addSubview:levelView];
    
    
    showIndustryView.backgroundColor = bgColor;
    IndustryView = [[UITableView alloc]initWithFrame:CGRectMake(7, 4, 306, frame.size.height-129)];
    IndustryView.delegate = self;
    IndustryView.dataSource = self;
    IndustryView.tag = 5;
    [showIndustryView addSubview:IndustryView];
    
    
    [self.view addSubview:industrybutton];
    [self.view addSubview:levelbutton];
    [self.view addSubview:provincebutton];
    [self.view addSubview:image];
    [self.view addSubview:image1];
    [self.view addSubview:image2];

    moveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,-3, self.view.frame.size.width/3,7 )];
    moveImageView.image = [UIImage  imageNamed:@"moveimage_pic"];
    moveImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3,-3,self.view.frame.size.width/3,7 )];
    moveImageView2.image = [UIImage  imageNamed:@"moveimage_pic"];
    moveImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(2*self.view.frame.size.width/3,-3, self.view.frame.size.width/3,7 )];
    moveImageView3.image = [UIImage  imageNamed:@"moveimage_pic"];

    [showCityView addSubview:moveImageView];
    [showIndustryView addSubview:moveImageView3];
    [showLevelView addSubview:moveImageView2];

    provinceButonStatue = 1;
    levelButonStatue = 1;
    industryButonStatue = 1;
    

    
}

-(void)backtosuper
{
    [self canRequest];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)canRequest
{
    [_gNetAccess cancelAsynchronousRequest];
    [_cityNetAccess cancelAsynchronousRequest];
    [_levelNetAcess cancelAsynchronousRequest];
    [_industryNetAcess cancelAsynchronousRequest];
}

-(void)showdevelopZone
{
    
    if([NetAccess reachable])
    {
        _gNetAccess.delegate = self;
        _gNetAccess.tag = 100;
        [_gNetAccess thedevelopZone:getDevelopZoneInfo];
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //  [getDevelopZoneInfo release];
    }
    else
    {
        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:@"对不起,没有网络\n请检查网络网络是否打开"];
        
        NSArray*pathss=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString*pat=[pathss objectAtIndex:0];
        NSString *filenames=[pat stringByAppendingPathComponent:@"developZone.plist"];
        listarray=[[NSMutableArray alloc]initWithContentsOfFile:filenames];
        if (listarray.count > 1) {
            NSString *name = [listarray objectAtIndex:listarray.count  -1];
            if ([name isEqualToString:provinceName]) {
                [listarray removeLastObject];
                for (id obj in listarray) {
                    [allListArray addObject:obj];
                }
                [searchtable reloadData];
            }
        
        
        }
        
    

        
    }
    

    
}


-(void)showCityName
{
    
   
 //   getCityName = @"{\"type\":\"china\",\"prov\":\"辽宁\"}";
    if([NetAccess reachable])
    {
        _cityNetAccess.delegate = self;
        _cityNetAccess.tag = 150;
        [_cityNetAccess thecityName:getCityName];
        
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       
       // [getCityName release];
    }
    else
    {
        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:@"对不起,没有网络\n请检查网络网络是否打开"];
    }
    
   
    
}

-(void)showLevelList
{
    if ([languageFlag isEqualToString:@"china"]) {
        NSString *getLevelList = @"{\"type\":\"china\"}";

    
    if([NetAccess reachable])
    {
        _levelNetAcess.delegate = self;
        _levelNetAcess.tag = 151;    //tag = 151 ,levellist
        [_levelNetAcess thelevelList:getLevelList];
        
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    else
    {
        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:@"对不起,没有网络\n请检查网络网络是否打开"];
    }
    
    }
    
else if([languageFlag isEqualToString:@"english"])
{
    NSString *getLevelList = @"{\"type\":\"english\"}";
    
    if([NetAccess reachable])
    {
        _levelNetAcess.delegate = self;
        _levelNetAcess.tag = 151;    //tag = 151 ,levellist
        [_levelNetAcess thelevelList:getLevelList];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    else
    {
        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:@"对不起,没有网络\n请检查网络网络是否打开"];
    }

}

}

-(void)showIndustryList
{     if ([languageFlag isEqualToString:@"china"]) {
    NSString *getIndustryList = @"{\"type\":\"china\"}";
    if([NetAccess reachable])
    {
        _industryNetAcess.delegate = self;
        _industryNetAcess.tag = 152;    //tag = 151 ,levellist
        [_industryNetAcess theindustryList:getIndustryList];
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    else
    {
       [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:@"对不起,没有网络\n请检查网络网络是否打开"];
    }
}
    
else if([languageFlag isEqualToString:@"english"])
{
    if([NetAccess reachable])
    {
        NSString *getIndustryList = @"{\"type\":\"english\"}";

        _industryNetAcess.delegate = self;
        _industryNetAcess.tag = 152;    //tag = 151 ,levellist
        [_industryNetAcess theindustryList:getIndustryList];
      [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
    else
    {
        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:@"对不起,没有网络\n请检查网络网络是否打开"];
    }
}
    
}




-(void)showCity
{
    if(levelButonStatue == -1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            showLevelView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
            [levelbutton setBackgroundImage:[UIImage imageNamed:@"levelbutton1.png"] forState:UIControlStateNormal];
            levelLabel.textColor = [UIColor grayColor];
        }];
        levelButonStatue = 1;
    }
    if(industryButonStatue == -1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            showIndustryView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
            [industrybutton setBackgroundImage:[UIImage imageNamed:@"industrybutton1.png"] forState:UIControlStateNormal];
            industryLabel.textColor = [UIColor grayColor];
           

        }];
        levelButonStatue = 1;
    }
    
    
   
    
    
    if (provinceButonStatue == 1) {
        [UIView animateWithDuration:0.3 animations:^{
            showCityView.frame =CGRectMake(0, 40, 320, UI_SCREEN_HEIGHT-84);
                [provincebutton setBackgroundImage:[UIImage imageNamed:@"provincebutton2.png"] forState:UIControlStateNormal];
          //  moveImageView.frame = CGRectMake(0, 38, self.view.frame.size.width/3 + 1, 7);
        provinceLabel.textColor =  [UIColor colorWithRed:24/255.0 green:134/255.0 blue:236/255.0 alpha:1];
        }];
        provinceButonStatue = -1;
        
    }
    else if(provinceButonStatue == -1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            showCityView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
            [provincebutton setBackgroundImage:[UIImage imageNamed:@"provincebutton1.png"] forState:UIControlStateNormal];
            
            provinceLabel.textColor = [UIColor grayColor];
        }];
        provinceButonStatue = 1;
    }
    int x=0 ;
 //   NSLog(@"111111%@",provinceName);
     NSLog(@"##%@",tempprovinceName);
    for (int i = 0; i < allProvinceArray.count; i++) {
        NSLog(@"%@",tempprovinceName);

        if ([tempprovinceName isEqualToString:@""]) {
            NSLog(@"%@",tempprovinceName);
            if ([provinceName isEqualToString:[allProvinceArray objectAtIndex:i]]) {
                x = i;
                break;
        }
        }
        
        
        else if([tempprovinceName isEqualToString:[allProvinceArray objectAtIndex:i]]) {
            x = i;
            break;
        }
    }
    [provinceView selectRowAtIndexPath:[NSIndexPath indexPathForRow:x inSection:0]animated:NO scrollPosition:UITableViewScrollPositionTop];
    

    [cityView reloadData];
    
}

-(void)showLevel
{
    
    if(industryButonStatue == -1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            showIndustryView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
         [industrybutton setBackgroundImage:[UIImage imageNamed:@"industrybutton1.png"] forState:UIControlStateNormal];
            industryLabel.textColor = [UIColor grayColor];

        }];
        industryButonStatue = 1;
    }
    if(provinceButonStatue == -1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            showCityView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
             [provincebutton setBackgroundImage:[UIImage imageNamed:@"provincebutton1.png"] forState:UIControlStateNormal];
            provinceLabel.textColor = [UIColor grayColor];
        }];
        provinceButonStatue = 1;
    }
    
    
    
    if (levelButonStatue == 1) {
        [UIView animateWithDuration:0.3 animations:^{
            showLevelView.frame =CGRectMake(0, 40, 320, UI_SCREEN_HEIGHT-84);
             [levelbutton setBackgroundImage:[UIImage imageNamed:@"levelbutton2.png"] forState:UIControlStateNormal];
        //    moveImageView.frame = CGRectMake(self.view.frame.size.width/3, 38, self.view.frame.size.width/3+1, 7);
            levelLabel.textColor = [UIColor colorWithRed:24/255.0 green:134/255.0 blue:236/255.0 alpha:1];

        }];
        levelButonStatue = -1;
        
    }
    else if(levelButonStatue == -1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            showLevelView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
         [levelbutton setBackgroundImage:[UIImage imageNamed:@"levelbutton1.png"] forState:UIControlStateNormal];
          //  moveImageView.frame = CGRectMake(-100, 35, 100, 10);
            levelLabel.textColor = [UIColor grayColor];
        }];
        levelButonStatue = 1;
    }


    [levelView reloadData];
//    if(showLevelView.hidden == NO)
//    {
//        [self showLevelList];
//    }
    // [levelView release];

}
-(void)showIndustry
{
    
    if(levelButonStatue == -1)
     {
         [UIView animateWithDuration:0.3 animations:^{
             showLevelView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
             [levelbutton setBackgroundImage:[UIImage imageNamed:@"levelbutton1.png"] forState:UIControlStateNormal];
             levelLabel.textColor = [UIColor grayColor];
          }];
         levelButonStatue = 1;
     }
    if(provinceButonStatue == -1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            showCityView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
        [provincebutton setBackgroundImage:[UIImage imageNamed:@"provincebutton1.png"] forState:UIControlStateNormal];
            provinceLabel.textColor = [UIColor grayColor];
        }];
        provinceButonStatue = 1;
    }

    
    
    if (industryButonStatue == 1) {
        [UIView animateWithDuration:0.3 animations:^{
            showIndustryView.frame =CGRectMake(0, 40, 320, UI_SCREEN_HEIGHT-84);
    [industrybutton setBackgroundImage:[UIImage imageNamed:@"industrybutton2.png"] forState:UIControlStateNormal];
     //       moveImageView.frame = CGRectMake(self.view.frame.size.width*2/3, 38, self.view.frame.size.width/3 + 1, 7);
       industryLabel.textColor = [UIColor colorWithRed:24/255.0 green:134/255.0 blue:236/255.0 alpha:1];
        }];
        industryButonStatue = -1;
        
    }
    else if(industryButonStatue == -1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            showIndustryView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
           [industrybutton setBackgroundImage:[UIImage imageNamed:@"industrybutton1.png"] forState:UIControlStateNormal];
       //     moveImageView.frame = CGRectMake(-100, 35, 100, 10);
            industryLabel.textColor = [UIColor grayColor];

        }];
        industryButonStatue = 1;
    }

    
    
    [IndustryView reloadData];
    

}
#pragma mark -- NetAccessDelegate

- (void)netAccess:(NetAccess *)netAccess RequestFailed:(NSMutableArray *)resultSet
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if (na.tag ==100) {
        
        [listarray removeAllObjects];
        listarray = resultSet;
        if (listarray.count != 0) {
            for (id obj in listarray) {
                [allListArray addObject:obj];
            }
            
            if (catchflag == 0) {
                [listarray addObject:provinceName];
                NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString*path=[paths objectAtIndex:0];
                NSString *filename=[path stringByAppendingPathComponent:@"developZone.plist"];
                [listarray writeToFile:filename atomically:YES];
                catchflag = 1;
                [listarray removeLastObject];

            }
            
            
        }
        if (allListArray.count == 0) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

             [UITools showPopMessage:self titleInfo:@"提示" messageInfo:@"对不起,暂无数据"];
            
        }
        
        [searchtable reloadData];
        
    }
    if (na.tag == 150) {

     
        [listarray3 removeAllObjects];
        
        listarray3 = resultSet;
        
        [cityView reloadData];
    }
    if (na.tag == 151) {
        [listarray4 removeAllObjects];
        
        listarray4 = resultSet;
       
    }
    if (na.tag == 152) {
         
      //  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        [listarray5 removeAllObjects];
       
        listarray5 = resultSet;
       
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

    
    switch (tableView.tag) {
        case 1:
            return allListArray.count;
                break;
        case 2:
            return allProvinceArray.count;
            break;
        case 3:
            return listarray3.count + 1;
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
       {
       
            return 70;
        }
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
        case 1:
        {
            //主界面tableview
           // [MBProgressHUD hideAllHUDsForView:self.view animated:YES]; 
            if (cell == nil) {
                cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            NSLog(@"allListArray:%@",allListArray);
        
            cell.label.font = [UIFont fontWithName:@"Helvetica" size:15.0];
            cell.label.text = [[allListArray objectAtIndex:indexPath.row] objectForKey:@"developname"];
            
            NSLog(@"allListArray Count:%d",allListArray.count);
            cell.labeltwo.text = [[allListArray objectAtIndex:indexPath.row] objectForKey:@"content"];
            
            
            NSString *index_row = [NSString stringWithFormat:@"%d", indexPath.row];

            if ([imagesDictionary valueForKey:index_row] != nil) {
                [cell.imageview setImage:[imagesDictionary valueForKey:index_row]];
            }else{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 
                    NSString *url = [NSString stringWithFormat:
                                     @"%@%@%@",
                                     HOST_URL, API_DEVELOPIAMGE,
                                     [[allListArray objectAtIndex:indexPath.row] objectForKey:@"deveimage"]];
                    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    if (image != nil) {
                        [imagesDictionary setObject:image forKey:index_row];
                    }
                    if (image != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell.imageview setImage:image];
                        });
                    }
                });
            }
             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            return cell;
        }
        case 2: //provinceVIew
        {
            if (cell == nil) {
                cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            }
//            UIImageView *imageview = [[[UIImageView alloc] initWithFrame:cell.frame] autorelease];
//            imageview.image = [UIImage imageNamed:@"provinceCell1"];
            cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"provinceCell1"]];
            
        //    cell.selectedBackgroundView = imageview;
//        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"provinceCell1"]];
            
            cell.textLabel.highlightedTextColor = [UIColor blackColor];
            [cell.textLabel setTextColor:[UIColor blackColor]];
        
            cell.textLabel.text = [allProvinceArray objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];

         
        
        
            return cell;
        }
        //  cityView
        case 3:
        {
        //    [assAiv stopAnimating];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            if (cell == nil) {
                cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            
            if (indexPath.row == 0) {
                if ([languageFlag isEqualToString:@"china"]) {
                    cell.textLabel.text = @"   全部";
                    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
                }
                else if([languageFlag isEqualToString:@"english"])
                {
                    cell.textLabel.text = @"   all";
                    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
                }
                return  cell;
            }
            else
            {
                cell.textLabel.text = [NSString stringWithFormat:@" %@",[[listarray3 objectAtIndex:indexPath.row -1] objectForKey:@"cityname"]];
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
            
            }
            
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
//            cell.textLabel.text = [NSString stringWithFormat:@" %@",[[listarray3 objectAtIndex:indexPath.row -1] objectForKey:@"cityname"]];
//             cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
            return cell;
        }
        case 4:   //levelVIew
        {
            if (cell == nil) {
                cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
            if (indexPath.row == 0) {
                if ([languageFlag isEqualToString:@"china"]) {
                    cell.textLabel.text = @"   全部";
                    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
                }
                else if([languageFlag isEqualToString:@"english"])
                {
                cell.textLabel.text = @"   all";
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
                }
                 return cell;
            }
            else{
            cell.textLabel.text = [NSString stringWithFormat:@"   %@",[[listarray4 objectAtIndex:indexPath.row-1] objectForKey:@"levelname"]];
            }
             cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
            return cell;
        }
        case 5:   //industry view
        {
            if (cell == nil) {
                cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
            if (indexPath.row == 0) {
                if ([languageFlag isEqualToString:@"china"]) {
                    cell.textLabel.text = @"   全部";
                    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
                }
                else if([languageFlag isEqualToString:@"english"])
                {
                    cell.textLabel.text = @"   all";
                    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
                }

                
                return cell;
            }
            else{

            cell.textLabel.text = [NSString stringWithFormat:@"   %@",[[listarray5 objectAtIndex:indexPath.row - 1] objectForKey:@"name"]];
            }
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
            return cell;
        }
        default:
        {
            if (cell == nil) {
                cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
             cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
            return cell;
        }
    }
 
}

-(void)viewDidDisappear:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 1:
        {
            
            [searchtable deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
            ArticleViewController *artiview = [[ArticleViewController alloc] initWithurl:[allListArray objectAtIndex:indexPath.row]];
            [self.navigationController pushViewController:artiview animated:YES];
            break;
        }
        case 2:
        {
     //  [provinceView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
            if ([[allProvinceArray objectAtIndex:indexPath.row] isEqualToString:@"全国"] || [[allProvinceArray objectAtIndex:indexPath.row] isEqualToString:@"北京市"] || [[allProvinceArray objectAtIndex:indexPath.row] isEqualToString:@"天津市"] || [[allProvinceArray objectAtIndex:indexPath.row] isEqualToString:@"上海市" ]||[[allProvinceArray objectAtIndex:indexPath.row] isEqualToString:@"重庆市"]) {
                provinceName = [allProvinceArray objectAtIndex:indexPath.row];
             //  [provincebutton setTitle:provinceName forState:UIControlStateNormal];
                provinceLabel.text = provinceName;
                tempprovinceName = provinceName;
                getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\"}",provinceName];
                levelbutton.titleLabel.text = @"全部";
                industrybutton.titleLabel.text = @"全部";
                [listarray3 removeAllObjects];
                inid= @"";
                leid = @"";
                
                if(provinceButonStatue == -1)
                {
                    [UIView animateWithDuration:0.3 animations:^{
                        showCityView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
                       [provincebutton setBackgroundImage:[UIImage imageNamed:@"provincebutton1.png"] forState:UIControlStateNormal];
                        provinceLabel.textColor = [UIColor grayColor];
                        // [provincebutton  setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
                    }];
                    provinceButonStatue = 1;
                }
                developnumhasget = 0;
                [imagesDictionary removeAllObjects];

                [allListArray  removeAllObjects];
                          
                [self showdevelopZone];


            }
            else{
            getCityName = [NSString stringWithFormat:getCityName = @"{\"type\":\"china\",\"prov\":\"%@\"}",[allProvinceArray objectAtIndex:indexPath.row]] ;
                tempprovinceName = [allProvinceArray objectAtIndex:indexPath.row];
               
               
            [self showCityName];
            }
            break;
        }
        case 3:
        {
        [cityView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
            if ([tempprovinceName isEqualToString:@""]) {
                tempprovinceName = provinceName;
            }
          //  tempprovinceName = provinceName;
            
            
            if (indexPath.row >0 && indexPath.row <= listarray3.count) {
                provinceLabel.text = [[listarray3 objectAtIndex:indexPath.row - 1] objectForKey:@"cityname"] ;
                provinceName = [[listarray3 objectAtIndex:indexPath.row - 1] objectForKey:@"cityname"];

               // leid = [[listarray4 objectAtIndex:indexPath.row-1] objectForKey:@"id"];
            }
            else
            {
                provinceLabel.text = tempprovinceName;
                provinceName = tempprovinceName;
                // [levelbutton setTitle:@"全部" forState:UIControlStateNormal];
              //  leid = @"";
            }

            
            
            
         //   provinceName = [[listarray3 objectAtIndex:indexPath.row] objectForKey:@"cityname"];
          //  [provincebutton setTitle:provinceName forState:UIControlStateNormal];
         //   provinceLabel.text = provinceName;
            
            getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\"}",provinceName];
            levelbutton.titleLabel.text = @"全部";
            industrybutton.titleLabel.text = @"全部";
            inid= @"";
            leid = @"";
            
            if(provinceButonStatue == -1)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    showCityView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
                   [provincebutton setBackgroundImage:[UIImage imageNamed:@"provincebutton1.png"] forState:UIControlStateNormal];
                    //      moveImageView.frame = CGRectMake(-100, 35, 100, 8);
               //     [provincebutton  setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
                    provinceLabel.textColor = [UIColor grayColor];

                }];
                provinceButonStatue = 1;
            }

            
           // [provinceView init];
            developnumhasget = 0;
            [imagesDictionary removeAllObjects];

           [allListArray  removeAllObjects];

            

            [self showdevelopZone];
            
            break;
        }
        case 4:
        {
         [levelView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
            if (indexPath.row >0 && indexPath.row <= listarray4.count) {
                levelLabel.text = [[listarray4 objectAtIndex:indexPath.row - 1] objectForKey:@"levelname"] ;
                leid = [[listarray4 objectAtIndex:indexPath.row-1] objectForKey:@"id"];
            }
            else
            {
                levelLabel.text = @"全部";
              // [levelbutton setTitle:@"全部" forState:UIControlStateNormal];
                leid = @"";
            }
            
            getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\",\"levelid\":\"%@\",\"trade\":\"%@\",\"cid\":\"%@\"}",provinceName,leid,inid,cid];

        
            if(levelButonStatue == -1)
            { [UIView animateWithDuration:0.3 animations:^{
                showLevelView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
             [levelbutton setBackgroundImage:[UIImage imageNamed:@"levelbutton1.png"] forState:UIControlStateNormal];
                //  moveImageView.frame = CGRectMake(-100, 35, 100, 10);
               
                levelLabel.textColor = [UIColor grayColor];
                //[levelbutton  setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
            }];
                levelButonStatue = 1;
            }
            
           // [provinceView init];
            developnumhasget = 0;
            [imagesDictionary removeAllObjects];

            [allListArray  removeAllObjects];
            [self showdevelopZone];
            break;
        }
        case 5:
        {
        [IndustryView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
            if (indexPath.row >0 && indexPath.row <= listarray5.count) {
               industryLabel.text = [[listarray5 objectAtIndex:indexPath.row-1] objectForKey:@"name"];
               
                inid = [[listarray5 objectAtIndex:indexPath.row-1] objectForKey:@"id"];
            }
            else
            {
             industryLabel.text = @"全部";
                //[industrybutton setTitle:@"全部" forState:UIControlStateNormal];
                inid = @"";
            }

            
            
         
            getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\",\"levelid\":\"%@\",\"trade\":\"%@\",\"cid\":\"%@\"}",provinceName,leid,inid,cid];
           
            if(industryButonStatue == -1)
            {[UIView animateWithDuration:0.3 animations:^{
                showIndustryView.frame =CGRectMake(0, -480, 320, UI_SCREEN_HEIGHT-84);
               [industrybutton setBackgroundImage:[UIImage imageNamed:@"industrybutton1.png"] forState:UIControlStateNormal];
                //     moveImageView.frame = CGRectMake(-100, 35, 100, 10);
                industryLabel.textColor = [UIColor grayColor];
                
            }];
                industryButonStatue = 1;
            }
            

            
                    developnumhasget = 0;
            
            [imagesDictionary removeAllObjects];

          [allListArray  removeAllObjects];

                     
            [self showdevelopZone];
            break;
        }
        default:
          
            break;
    }
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 2) {
        [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"provinceCell2.png"]]];
//        cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
//        cell.selectedBackgroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"provinceCell1.png"]];
    }
    
    if (allListArray.count != 0 && tableView.tag == 1) {
        
        
       int count = [[[allListArray objectAtIndex:0] objectForKey:@"count"] intValue];
          
        if (indexPath.row == [allListArray count] - 1 && indexPath.row < count -1)
        {  UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
            NSLog(@"$%d,%d,%d",indexPath.row,[allListArray count]-1,count -1);
//            footactive = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//            
//            footactive.center = CGPointMake(160, 30);
//            footactive.color = [UIColor blackColor];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
           [button setTitle:@"加载更多" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
            button.frame = footview.frame;
            button.backgroundColor = [UIColor clearColor];
       //     [button setBackgroundImage:[UIImage imageNamed:@"levelbutton1.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(getMoreInfo) forControlEvents:UIControlEventTouchUpInside];
            [footview addSubview:button];
            //[footactive startAnimating];
            tableView.tableFooterView = footview;
            
                       
//            getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\",\"levelid\":\"%@\",\"trade\":\"%@\",\"cid\":\"%@\",\"time\":\"%@\"}",provinceName,leid,inid,cid,[[listarray objectAtIndex:(listarray.count - 1)]objectForKey:@"time"] ];
//            
//            NSLog(@"$$$$$%@",[listarray objectAtIndex:listarray.count -1]);
//            NSLog(@"^^%@",getDevelopZoneInfo);
//            [provinceName retain];
//            [self showdevelopZone];
            

       //     tableView.tableFooterView = nil;
            
        }
        
    }
    
}



-(void)getMoreInfo
{
    getDevelopZoneInfo = [NSString stringWithFormat: @"{\"type\":\"china\",\"cityname\":\"%@\",\"levelid\":\"%@\",\"trade\":\"%@\",\"cid\":\"%@\",\"time\":\"%@\"}",provinceName,leid,inid,cid,[[listarray objectAtIndex:(listarray.count - 1)]objectForKey:@"time"] ];
    
    NSLog(@"$$$$$%@",[listarray objectAtIndex:listarray.count -1]);
    NSLog(@"^^%@",getDevelopZoneInfo);
    [self showdevelopZone];
    searchtable.tableFooterView = nil;

}


- (void)didReceiveMemoryWarning
{
   
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
