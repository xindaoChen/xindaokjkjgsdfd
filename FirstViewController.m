//
//  FirstViewController.m
//  DevelopMent
//
//  Created by xin wang on 3/20/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//




#import "FirstViewController.h"
#import "SearchViewController.h"
#import "ScanDevelopViewController.h"
#import "DiscussViewController.h"
#import "DevelopViewController.h"
#import "AppDelegate.h"
#import "ArticleViewController.h"
#import "DevelopViewController.h"
#import "ClassViewController.h"
#import "GrayPageControl.h"
#import "MBProgressHUD.h"
#import "UITools.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize firscrollView,secscrollview,pageController,pageControllertwo,toolBar,maplistarray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//         self.hidesBottomBarWhenPushed = YES;
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
     NSUserDefaults *faflult = [NSUserDefaults standardUserDefaults];
      AppDelegate *appdele = [UIApplication sharedApplication].delegate;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = self.view.bounds;
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"all_view_bg"] ] autorelease];
    [bgView addSubview:imageView];
    [self.view addSubview:bgView];
    
    if(![faflult objectForKey:@"key"])
    {
        
        viewss = [[UIView alloc] initWithFrame:appdele.window.frame];
        viewss.backgroundColor = [UIColor clearColor];
        viewss.hidden = NO;
        [appdele.window addSubview:viewss];
        
        scrollview = [[UIScrollView alloc] initWithFrame:viewss.frame];
        scrollview.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        scrollview.pagingEnabled = YES;
        scrollview.tag = 200;
        scrollview.showsHorizontalScrollIndicator = NO;//不显示水平滑动线
        scrollview.showsVerticalScrollIndicator = NO;//不显示垂直滑动线
        scrollview.delegate = self;
        [scrollview setContentOffset:CGPointMake(0, 0)];
        scrollview.contentSize = CGSizeMake(640, 120);
        [viewss addSubview:scrollview];
        
        CGRect fram = self.view.frame;
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"yindao1.png",@"yindao2.png",nil];
        for (int i = 0; i<2; i++)
        {
            CGRect frame = scrollview.frame;
            UIImageView *firstview = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*i , 0, 320, frame.size.height)];
            [firstview setImage:[UIImage imageNamed:[array objectAtIndex:i]]];
            [scrollview addSubview:firstview];
            [firstview release];
            if (i==1)
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//                [button setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
 
                if (fram.size.height>500) {
                     button.frame = CGRectMake( frame.size.width*i+110 , 510, 100, 40);
                 }
                else
                {
 
                    button.frame = CGRectMake( frame.size.width*i+100 , 410, 100, 40);
 
                }
 
                [scrollview addSubview:button];
            }
        }
        [array release];
        [scrollview release];
        
    }
    else
    {
        [self englishorching];
    }

        Snumber = 0;
    CGRect fram = self.view.frame;
    listarray = [[NSMutableArray alloc] init];
    buttonbars = [[UILabel alloc]  init];
    maplistarray = [[NSMutableArray alloc] init];
    idaray = [[NSMutableArray alloc] init];
    arrayone = [[NSMutableArray alloc] initWithObjects:@"北京市",@"天津市",@"上海市",@"重庆市",@"河北省", @"山西省",@"辽宁省",@"吉林省",@"黑龙江省",@"江苏省",@"浙江省",@"安徽省",@"山东省",@"广东省",@"江西省",@"内蒙古",@"广西自治区",@"西藏自治区",@"宁夏自治区",@"新疆自治区",@"河南省",@"海南省",@"湖南省",@"福建省",@"贵州省",@"云南省",@"湖北省",@"甘肃省",@"四川省",@"青海省",@"陕西省",@"台湾省",@"香港",@"澳门",nil];
     arrayonetwo = [[NSMutableArray alloc] initWithObjects:@"Beijing",@"Tianjing",@"Shanghai",@"Chongqing",@"Hebei", @"Shanxi",@"Liaoning",@"Jilin",@"Heilongjiang",@"Jiangsu",@"Zhejiang",@"Anhui",@"Shandong",@"Guangdong",@"Jiangxi",@"Neimenggu",@"Guangxi",@"Xizang",@"Ningxia",@"Xinjiang",@"Henan",@"Hainan",@"Hunan",@"Fujian",@"Guizhou",@"Yunnan",@"Hubei",@"Gansu",@"Sichuan",@"Qinghai",@"Shanxi",@"Taiwan",@"Hong Kong",@"Macau",nil];
    picturearray = [[NSMutableArray alloc] initWithObjects:@"0.png", @"1.png",@"2.png",@"3.png",@"4.png",@"5.png",@"6.png",@"7.png",@"8.png",@"9.png",@"10.png",@"11.png",@"12.png",@"13.png",@"14.png",@"15.png",@"16.png",@"17.png",@"18.png",@"19.png",@"20.png",@"21.png",@"22.png",@"23.png",@"24.png",@"25.png",@"26.png",@"27.png",@"28.png",@"29.png",@"30.png",@"31.png",@"32.png",@"33.png",@"34.png",nil];
    

    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(20, 8, 40, 40);
    [button2 setImage:[UIImage imageNamed:@"map.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(mylocation) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnTopItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = leftBtnTopItem;
    [leftBtnTopItem release];
    
    
    mysearch = [[BMKSearch alloc] init];
    mysearch.delegate = self;
      
    secscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, 320, 408)];
    secscrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    secscrollview.pagingEnabled = YES;
    secscrollview.tag =111;
    secscrollview.showsHorizontalScrollIndicator = NO;
    secscrollview.showsVerticalScrollIndicator = NO;
    secscrollview.delegate = self;
    [secscrollview setContentOffset:CGPointMake(0, 0)];
    [self.view addSubview:secscrollview];
       
    pageController = [[UIPageControl alloc ] initWithFrame:CGRectMake(200, 100, 100, 20)];
    pageController.currentPage=0;
    pageController.userInteractionEnabled=NO;
    pageController.alpha=1;
    if (fram.size.height>500) {
         pageControllertwo = [[GrayPageControl alloc ] initWithFrame:CGRectMake(100, 425, 100, 20)];
         pageControllertwo.numberOfPages=3;
         secscrollview.contentSize = CGSizeMake(960, 120);
    }
    else
    {
         pageControllertwo = [[GrayPageControl alloc ] initWithFrame:CGRectMake(100, 345, 100, 20)];
         pageControllertwo.numberOfPages=5;
         secscrollview.contentSize = CGSizeMake(1600, 120);
    }
    
    pageControllertwo.backgroundColor = [UIColor clearColor];
    pageControllertwo.currentPage=0;
//    [pageControllertwo setCurrentPageIndicatorTintColor:[UIColor redColor]];
//    [pageControllertwo setPageIndicatorTintColor:[UIColor grayColor]];
    pageControllertwo.userInteractionEnabled=NO;
    pageControllertwo.alpha=1;
    [self.view addSubview:pageControllertwo];

    firscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    firscrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    firscrollView.pagingEnabled = YES;
    firscrollView.tag = 100;
    firscrollView.showsHorizontalScrollIndicator = NO;//不显示水平滑动线
    firscrollView.showsVerticalScrollIndicator = NO;//不显示垂直滑动线
    firscrollView.delegate = self;
    [firscrollView setContentOffset:CGPointMake(0, 0)];
    firscrollView.contentSize = CGSizeMake(1600, 120);
    [self.view addSubview:firscrollView];
    [self.view addSubview:pageController];
     imagearray = [[NSMutableArray alloc] init];
 
  
    myMapView = [[ BMKMapView alloc] init];
    myMapView.delegate =self;
    myMapView.showsUserLocation = YES;
 
    UIImageView *myview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 320, 42)];
    [myview setImage:[UIImage imageNamed:@"gray.png"]];
    [self.view addSubview:myview];
    [myview release];
    
 
    
    UISearchBar* searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(40, 120, 240, 40)];
    searchbar.delegate = self;
    searchbar.placeholder = @"搜索";
     UIView *searview = [searchbar.subviews objectAtIndex:0];
    [searview removeFromSuperview];
    [self.view addSubview:searchbar];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 122, 240, 40);
    [button addTarget:self action:@selector(pushtosearch) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:button];

     
   
    NSArray*pathss=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString*pat=[pathss objectAtIndex:0];
    NSString *filenames=[pat stringByAppendingPathComponent:@"Picture.plist"];
    listarray=[[NSMutableArray alloc]initWithContentsOfFile:filenames];
    if (listarray.count != 0) {
        [self setfirstimagetwo];
    }
   
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tablemessage) userInfo:nil repeats:YES];
    timer2 = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tablemessagetwo) userInfo:nil repeats:YES];
   [timer2 setFireDate:[NSDate distantFuture]];
    [self makethebutton];
    [self maketitle];
    
 }

-(void)pushtosearch
{
    SearchViewController *seachview = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:seachview animated:YES];
 }

 

-(void)makethebutton
{
    AppDelegate*mydelegate = [UIApplication sharedApplication].delegate;
    CGRect fram = mydelegate.window.frame;
    int num = 0;
    NSLog(@"%@",mydelegate.language);
    if (fram.size.height>500)
    {
        for (int i = 0; i<3; i++)
        {
            CGRect frame = secscrollview.frame;
            
            for (int j = 0; j<3; j++)
            {
                for (int s = 0; s<4; s++)
                {
                    if (num<34)
                    {
                       
                        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake(16*(s+1)+60*s+frame.size.width*i, 85*j+55, 60, 60);
                         [button setImage:[UIImage imageNamed:[picturearray objectAtIndex:num]] forState:UIControlStateNormal];
                        button.tag = num;
                        [button addTarget:self action:@selector(PushtoDevelopview:) forControlEvents:UIControlEventTouchUpInside];
                       UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake( 8+76*s+frame.size.width*i, 85*j+113, 76, 20)];
                        lable.font = [UIFont systemFontOfSize:12];
                        lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
                        lable.textAlignment = NSTextAlignmentCenter;
                        if ([mydelegate.language isEqualToString:@"english"]) {
                            lable.text = [arrayonetwo objectAtIndex:num];
                        }
                        else if([mydelegate.language isEqualToString:@"china"] )
                        {
                            lable.text = [arrayone objectAtIndex:num];
                        }
                        num++;
                        [secscrollview addSubview:lable];
                        [secscrollview addSubview:button];
                        [lable release];
                        
                    }
                }
            }
        }
    }
    else
    {
        for (int i = 0; i<5; i++)
        {
            CGRect frame = secscrollview.frame;
            for (int j = 0; j<2; j++)
            {
                for (int s = 0; s<4; s++)
                {
                    if (num<34)
                    {
                         NSLog(@"%@",mydelegate.language);
                        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake(16*(s+1)+60*s+frame.size.width*i, 85*j+55, 60, 60);
                        [button setImage:[UIImage imageNamed:[picturearray objectAtIndex:num]] forState:UIControlStateNormal];
                        button.tag = num;
                        [button addTarget:self action:@selector(PushtoDevelopview:) forControlEvents:UIControlEventTouchUpInside];
                        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake( 8+76*s+frame.size.width*i, 85*j+113, 76, 20)];
                        lable.font = [UIFont systemFontOfSize:12];
                        lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
                        lable.textAlignment = NSTextAlignmentCenter;
                        if ([mydelegate.language isEqualToString:@"english"]) {
                            lable.text = [arrayonetwo objectAtIndex:num];
                        }
                       else if([mydelegate.language isEqualToString:@"china"] )
                        {
                            lable.text = [arrayone objectAtIndex:num];
                        }
                        
                        num++;
                        [secscrollview addSubview:lable];
                        [secscrollview addSubview:button];
                        [lable release];
                    }
                }
            }
        }
    }
    
   
}


- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    [mysearch reverseGeocode:userLocation.location.coordinate];
    myMapView.showsUserLocation = NO;
}


-(void)yincang:(UIButton *)button
{
    ArticleViewController *artiview = [[ArticleViewController alloc] initWithurl:[listarray objectAtIndex:button.tag]];
    [self.navigationController pushViewController:artiview animated:YES];

}

-(void)EngorChaing:(UIButton *)sender
{
    AppDelegate*mydelegate = [UIApplication sharedApplication].delegate;
    if (sender.tag == 100) {
        mydelegate.language = @"english";
    }
    else if (sender.tag == 200)
    {
        mydelegate.language = @"china";
    }
       
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
        [netAccess theFirstviewPicture:alltring];
        [alltring release];
    }
    else
    {
        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:@"对不起,没有网络\n请检查网络网络是否打开"];
    }
    
    [self makethebutton];
    [self maketitle];
    if ([mydelegate.language isEqualToString:@"china"]) {
        [mydelegate.naviga2 setTitle:@"分类"];
        [mydelegate.naviga3 setTitle:@"云聚"];
        mydelegate.classview.title = @"分类";
        mydelegate.disview.title = @"云聚";
    }
    else
    {
        [mydelegate.naviga2 setTitle:@"Classification"];
        [mydelegate.naviga3 setTitle:@"Relation"];
        mydelegate.classview.title = @"Classification";
        mydelegate.disview.title = @"Relation";

    }
    

    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                            selectview.alpha = 0.0;
                        }completion:^(BOOL finished){
                        }];

   
}

-(void)maketitle
{
    AppDelegate *mydelegat = [UIApplication sharedApplication].delegate;
    if (  [mydelegat.language  isEqualToString: @"china"]) {
        self.title = @"首页";
    }
    else
    {
        self.title = @"Homepage";
    }

}
-(void)push
{
    
    NSUserDefaults *faflult = [NSUserDefaults standardUserDefaults];
    [faflult setObject:@"2" forKey:@"keytwo"];
    [faflult setObject:@"1" forKey:@"key"];
    [faflult synchronize];

    [self englishorching];
    [self changeUIView];
}



-(void)englishorching
{
    AppDelegate *appdele = [UIApplication sharedApplication].delegate;
    CGRect fram = appdele.window.frame;
    selectview = [[UIView alloc] initWithFrame:appdele.window.frame];
    UIImageView *images = [[UIImageView alloc] initWithFrame:selectview.frame];
    [images setImage:[UIImage imageNamed:@"yindao3.png"]];
    [selectview addSubview:images];
    [images release];
    [appdele.window addSubview:selectview];
    
    UIButton *buttonnext = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonnext setImage:[UIImage imageNamed:@"english.png"] forState:UIControlStateNormal];
    buttonnext.tag =100;
    [buttonnext addTarget:self action:@selector(EngorChaing:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonnext2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonnext2 setImage:[UIImage imageNamed:@"china.png"] forState:UIControlStateNormal];
    buttonnext2.tag =200;
    [buttonnext2 addTarget:self action:@selector(EngorChaing:) forControlEvents:UIControlEventTouchUpInside];
   
    if (fram.size.height>500) {
        buttonnext.frame = CGRectMake(  160.5 , 520, 100, 40);
        
        buttonnext2.frame = CGRectMake(  60 , 520, 99.5, 40);
        
    }
    else
    {
        buttonnext.frame = CGRectMake(  160.5 , 410, 100, 40);
        buttonnext2.frame = CGRectMake(  60 , 410, 99.5, 40);
    }
    [selectview addSubview:buttonnext];
    [selectview addSubview:buttonnext2];
}


- (void)changeUIView       
{
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                            viewss.alpha = 0.0;
                        }completion:^(BOOL finished){
                        }];

}

-(void)tablemessage
{
   
        CGRect frame = firscrollView.frame;
        CGPoint posit = CGPointMake(frame.size.width * Snumber , 0 );
        [firscrollView setContentOffset:posit animated:YES];
        Snumber++;
    if (Snumber == 5){
        Snumber = 4;
        [timer setFireDate:[NSDate distantFuture]];
        [timer2 setFireDate:[NSDate distantPast]];
    }
     
}

-(void)tablemessagetwo
{
    CGRect frame = firscrollView.frame;
    CGPoint posit = CGPointMake(frame.size.width * Snumber  , 0 );
    [firscrollView setContentOffset:posit animated:YES];
    Snumber--;
    if (Snumber == -1) {
        Snumber =0;
        [timer setFireDate:[NSDate distantPast]];
        [timer2 setFireDate:[NSDate distantFuture]];
    }
}



 
 
-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    if (na.tag == 100){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if (resultSet.count !=0) {
//            [listarray removeAllObjects];
            listarray = resultSet;
            [listarray retain];
            NSLog(@"%@",listarray);
            for (UIView *subView in firscrollView.subviews)
            {
                [subView removeFromSuperview];
            }
            
            [self setfirstimage];
             
            pageController.numberOfPages=listarray.count;

        }
        else
        {
        [UITools showPopMessage:self titleInfo:@"提示" messageInfo:@"暂无数据"];

        }
   
      }
}

-(void)setfirstimage
{
//    [idaray removeAllObjects];
     CGRect frame = firscrollView.frame;
     for (int i = 0; i<5; i++)
    {
        [idaray  addObject:[[listarray objectAtIndex:i] objectForKey:@"id"]];
        UIButton*buttongs = [UIButton buttonWithType:UIButtonTypeCustom];
        buttongs.tag = i;
        [buttongs addTarget:self action:@selector(yincang:) forControlEvents:UIControlEventTouchUpInside];
        buttongs.frame = CGRectMake(frame.size.width*i , 0, 320, 120);
        [firscrollView addSubview:buttongs];
        
        
        NSString *url = [NSString stringWithFormat:getImageUrl,[[listarray objectAtIndex:i] objectForKey:@"deveimage"]];
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image = [UIImage imageWithData:data];
        UIImage *resImage = [UITools reSizeImage:image toSize:CGSizeMake(640, 238)];
        [buttongs setImage:resImage forState:UIControlStateNormal];
        
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*i+10, 95, 200, 20)];
        lable.backgroundColor = [UIColor clearColor];
        lable.textColor = [UIColor whiteColor];
        lable.text = [[listarray objectAtIndex:i] objectForKey:@"developname"];
        [firscrollView addSubview:lable];
        NSDictionary *diction = [[NSDictionary alloc] initWithObjectsAndKeys:data,@"data", [[listarray objectAtIndex:i] objectForKey:@"developname"],@"developname",[[listarray objectAtIndex:i] objectForKey:@"id"],@"id",[[listarray objectAtIndex:i] objectForKey:@"latitude"],@"latitude",[[listarray objectAtIndex:i] objectForKey:@"longitude"],@"longitude",nil];
         [maplistarray addObject:diction];
        [data release];
        [lable release];
        [diction release];
        
    }
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString*path=[paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"Picture.plist"];
    [maplistarray writeToFile:filename atomically:YES];
    
}

-(void)setfirstimagetwo
{
    pageController.numberOfPages=listarray.count;
    CGRect frame = firscrollView.frame;
     
    for (int i = 0; i<5; i++)
    {
        
        UIButton*buttongs = [UIButton buttonWithType:UIButtonTypeCustom];
        buttongs.tag = i;
        [buttongs addTarget:self action:@selector(yincang:) forControlEvents:UIControlEventTouchUpInside];
        buttongs.frame = CGRectMake(frame.size.width*i , 0, 320, 120);
        [firscrollView addSubview:buttongs];
//        [idaray addObject:[[listarray objectAtIndex:i]objectForKey:@"id"]];
        UIImage *image = [UIImage imageWithData:[[listarray objectAtIndex:i]objectForKey:@"data"]];
        [buttongs setImage:image forState:UIControlStateNormal];
      
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*i+10, 95, 200, 20)];
        lable.backgroundColor = [UIColor clearColor];
        lable.textColor = [UIColor whiteColor];
        lable.text = [[listarray objectAtIndex:i] objectForKey:@"developname"];
         [firscrollView addSubview:lable];
        [lable release];
    }

}


 

- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    if (error == 0) {
        
        NSString *addr;
        if(result.addressComponent.city!=nil)
        {
            addr= [NSString stringWithFormat:@"%@",result.addressComponent.city];
                     //市
            buttonbars.text = addr;
            NSLog(@"%@",addr);
         }
        if(result.addressComponent.district!=nil)
        {
            addr= [NSString stringWithFormat:@"%@%@",addr,result.addressComponent.district];
                        //区
        }
        if(result.addressComponent.streetName!=nil)
        {
            addr= [NSString stringWithFormat:@"%@%@",addr,result.addressComponent.streetName];
                            //街
        }
    }
}


-(void)PushtoDevelopview:(UIButton*)button
{
 
    ScanDevelopViewController *dview = [[ScanDevelopViewController alloc] initWithnumber:button.tag];
    [self.navigationController pushViewController:dview animated:YES];

    
}

-(void)mylocation
{
     
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"市"];
    NSString *trimmedString = [buttonbars.text stringByTrimmingCharactersInSet:set];
    if (!trimmedString) {
       [UITools showPopMessage:self titleInfo:@"提示" messageInfo:@"对不起,无法定位您当前的位置"];
    }
    else
    {
        ScanDevelopViewController *searchview = [[ScanDevelopViewController alloc] initwithcityname:trimmedString];
        [self.navigationController pushViewController:searchview animated:YES];
    }
  
}
 
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (sender.tag ==100) {
        CGFloat pageWidth = firscrollView.frame.size.width;
        int page = floor((firscrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageController.currentPage = page;
        Snumber = page;
    }
    else if(sender.tag ==111)
    {
        CGFloat pageWidth = secscrollview.frame.size.width;
        int page = floor((secscrollview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControllertwo.currentPage = page;
    }
    else if (sender.tag ==200)
    {
         CGFloat pageWidth = scrollview.frame.size.width;
        int page = floor((scrollview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pagecon.currentPage = page;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)dealloc
{
    [firscrollView release];firscrollView = nil;
    [secscrollview release];secscrollview = nil;
    [pageController release];pageController = nil;
    [pageControllertwo release];pageControllertwo = nil;
    [listarray release];listarray = nil;
    [maplistarray release];maplistarray = nil;
    [buttonbars release];buttonbars = nil;
    [toolBar release];toolBar = nil;
    [arrayone release];arrayone = nil;
    [imagearray release];imagearray = nil;
    [mysearch release];mysearch = nil;
    [super dealloc];
    
}



@end
