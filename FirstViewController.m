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
#import "UITools.h"
#import "AppDelegate.h"
#import "XDTabBarViewController.h"
#import "Yunju.h"
#import "ASIFormDataRequest.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize gNetAccess = _gNetAccess;

@synthesize firscrollView,secscrollview,pageController,pageControllertwo,toolBar,maplistarray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
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
   AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
    _urlHost = delegate.domainName;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"]
                                                  forBarMetrics:UIBarMetricsDefault];
    NSUserDefaults *faflult = [NSUserDefaults standardUserDefaults];
    AppDelegate *appdele = [UIApplication sharedApplication].delegate;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = self.view.bounds;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"all_view_bg"]];
    [bgView addSubview:imageView];
    [self.view addSubview:bgView];
    
    NetAccess *netAccess = [[NetAccess alloc]init];
    _gNetAccess = netAccess;
   
    if(![faflult objectForKey:@"key"])
    {
        
        viewss = [[UIView alloc] initWithFrame:appdele.window.bounds];
        viewss.backgroundColor = [UIColor clearColor];
        viewss.hidden = NO;
        [appdele.window addSubview:viewss];
        
        scrollview = [[UIScrollView alloc] initWithFrame:viewss.frame];
        scrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen"]];
        scrollview.pagingEnabled = YES;
        scrollview.tag = 200;
        scrollview.showsHorizontalScrollIndicator = NO;//不显示水平滑动线
        scrollview.showsVerticalScrollIndicator = NO;//不显示垂直滑动线
        scrollview.delegate = self;
        [scrollview setContentOffset:CGPointMake(0, 0)];
        scrollview.contentSize = CGSizeMake(640, 120);
        [viewss addSubview:scrollview];
        
        CGRect fram = self.view.frame;
        NSMutableArray *array ;
        if (fram.size.height>500) {
             array = [[NSMutableArray alloc] initWithObjects:@"yindao1",@"yindao2",nil];
             }
        else
        {
            array = [[NSMutableArray alloc] initWithObjects:@"yindao11",@"yindao22",nil];
        }
        for (int i = 0; i<2; i++)
        {
            CGRect frame = scrollview.frame;
            UIImageView *firstview = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*i , 0, 320, frame.size.height)];
            [firstview setImage:[UIImage imageNamed:[array objectAtIndex:i]]];
            [scrollview addSubview:firstview];
            if (i==1)
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
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
    button2.frame = CGRectMake( 0, 8, 40, 40);
    [button2 setImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(mylocation) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnTopItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = leftBtnTopItem;
    
    mysearch = [[BMKSearch alloc] init];
    mysearch.delegate = self;
      
    secscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, 320, 408)];
    secscrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
    secscrollview.pagingEnabled = YES;
    secscrollview.tag =111;
    secscrollview.showsHorizontalScrollIndicator = NO;
    secscrollview.showsVerticalScrollIndicator = NO;
    secscrollview.delegate = self;
    [secscrollview setContentOffset:CGPointMake(0, 0)];
    [self.view addSubview:secscrollview];
       
    pageController = [[UIPageControl alloc ] initWithFrame:CGRectMake(220, 100, 100, 20)];
    pageController.currentPage=0;
    pageController.backgroundColor = [UIColor clearColor];
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
    pageControllertwo.userInteractionEnabled=NO;
    pageControllertwo.alpha=1;
    [self.view addSubview:pageControllertwo];

    firscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    firscrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
    firscrollView.pagingEnabled = YES;
    firscrollView.tag = 100;
    firscrollView.showsHorizontalScrollIndicator = NO;//不显示水平滑动线
    firscrollView.showsVerticalScrollIndicator = NO;//不显示垂直滑动线
    firscrollView.delegate = self;
    [firscrollView setContentOffset:CGPointMake(0, 0)];
    [self.view addSubview:firscrollView];
    [self.view addSubview:pageController];
    UIImageView *insteadview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    [insteadview setImage:[UIImage imageNamed:@"instead_fir"]];
    [firscrollView addSubview:insteadview];
     imagearray = [[NSMutableArray alloc] init];
    buttonarray = [[NSMutableArray alloc] init];
  
    myMapView = [[ BMKMapView alloc] init];
    myMapView.delegate =self;
    myMapView.showsUserLocation = YES;
 
    UIImageView *myview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 320, 42)];
    [myview setImage:[UIImage imageNamed:@"gray"]];
    [self.view addSubview:myview];
    
 
    
    searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(40, 120, 240, 40)];
    searchbar.delegate = self;
    UIView *searview = [searchbar.subviews objectAtIndex:0];
    [searview removeFromSuperview];
    [self.view addSubview:searchbar];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 122, 240, 40);
    [button addTarget:self action:@selector(pushtosearch) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:button];

     

    
 }

-(void)pushtosearch
{
    SearchViewController *seachview = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:seachview animated:YES];
//    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:YES];
 }

 

-(void)makethebutton
{
    AppDelegate*mydelegate = [UIApplication sharedApplication].delegate;
    CGRect fram = mydelegate.window.frame;
    int num = 0;
 
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
                        lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
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
                       
                        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake(16*(s+1)+60*s+frame.size.width*i, 85*j+55, 60, 60);
                        [button setImage:[UIImage imageNamed:[picturearray objectAtIndex:num]] forState:UIControlStateNormal];
                        button.tag = num;
                        [button addTarget:self action:@selector(PushtoDevelopview:) forControlEvents:UIControlEventTouchUpInside];
                        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake( 8+76*s+frame.size.width*i, 85*j+113, 76, 20)];
                        lable.font = [UIFont systemFontOfSize:12];
                        lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
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
//    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:YES];

}

-(void)gitnewversion
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST_URL,@"index.php/index/domain"]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:10];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
 
    AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSString *string = [[request.responseString JSONValue] objectForKey:@"version"];
    mydele.compsite = [[request.responseString JSONValue] objectForKey:@"site"];
    mydele.applink = [[request.responseString JSONValue] objectForKey:@"applink"];
    if  ([string intValue]>mydele.version.intValue) {
        mydele.version = [ [request.responseString JSONValue]   objectForKey:@"version"];
         mydele.domainName = [[request.responseString JSONValue] objectForKey:@"domain"];
        _urlHost = mydele.domainName;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:mydele.version forKey:KEY_FOR_VERSION];
        [defaults setValue:mydele.domainName forKey:KEY_FOR_HOST_URL];
        [self changefirstview];
    }
}

-(void)changefirstview
{
     AppDelegate*mydelegate = [UIApplication sharedApplication].delegate;
    if([NetAccess reachable])
    {
        NSString*string1 = @"{\"type\":\"";
        NSString*string2 = [NSString stringWithFormat:@"%@\"}",mydelegate.language];
        NSMutableString*alltring = [[NSMutableString alloc] init];
        [alltring appendString:string1];
        [alltring appendString:string2];
        _gNetAccess.delegate = self;
        _gNetAccess.tag = 100;
        [_gNetAccess theFirstviewPicture:alltring];
    }
    else
    {
        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:ErrorInternet];
    }

}

-(void)EngorChaing:(UIButton *)sender
{
    AppDelegate*mydelegate = [UIApplication sharedApplication].delegate;
     
    if (sender.tag == 100) {
        mydelegate.language = @"english";
             searchbar.placeholder = @"Search";
    }
    else if (sender.tag == 200)
    {
        mydelegate.language = @"china";
         searchbar.placeholder = @"搜索";
    }
    
    NSArray*pathss=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString*pat=[pathss objectAtIndex:0];
   
    if ([ mydelegate.language isEqualToString:@"china"]) {
        NSString *filenames=[pat stringByAppendingPathComponent:@"Picture.plist"];
        listarray=[[NSMutableArray alloc]initWithContentsOfFile:filenames];
        
    }
    else
    {
        NSString *filenames=[pat stringByAppendingPathComponent:@"PictureCopy.plist"];
        listarray=[[NSMutableArray alloc]initWithContentsOfFile:filenames];
        
    }
    if (listarray.count != 0) {
        [self setfirstimagetwo];
    }
    [self makethebutton];
    [self maketitle];
    
      if([NetAccess reachable])
    {
        NSString*string1 = @"{\"type\":\"";
        NSString*string2 = [NSString stringWithFormat:@"%@\"}",mydelegate.language];
        NSMutableString*alltring = [[NSMutableString alloc] init];
        [alltring appendString:string1];
        [alltring appendString:string2];
        _gNetAccess.delegate = self;
        _gNetAccess.tag = 100;
        [_gNetAccess theFirstviewPicture:alltring];
    }
    else
    {
//        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:ErrorInternet];
        
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
    
     [self gitnewversion];
    
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
        [mydelegate.naviga2 setTitle:@"Category"];
        [mydelegate.naviga3 setTitle:@"about"];
        mydelegate.classview.title = @"Category";
        mydelegate.disview.title = @"about";

    }
    

    [UIView animateWithDuration:0.5
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
    if (fram.size.height>520) {
        [images setImage:[UIImage imageNamed:@"yindao3"]];
    }
    else
    {
         [images setImage:[UIImage imageNamed:@"yindao31"]];
    }
   
    [selectview addSubview:images];
    [appdele.window addSubview:selectview];
    
    UIButton *buttonnext = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonnext.tag =100;
    [buttonnext addTarget:self action:@selector(EngorChaing:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonnext2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonnext2.tag =200;
    [buttonnext2 addTarget:self action:@selector(EngorChaing:) forControlEvents:UIControlEventTouchUpInside];
   
    if (fram.size.height>500) {
        buttonnext.frame = CGRectMake(  170 , 500, 120, 50);
        
        buttonnext2.frame = CGRectMake(  30 , 500, 120, 50);
        
    }
    else
    {
        buttonnext.frame = CGRectMake(  170 , 405, 120, 60);
        buttonnext2.frame = CGRectMake(  30 , 405, 120, 60);
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
    if (Snumber == listarray.count){
        Snumber = (listarray.count -1);
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


-(void)setfirstimage
{
     CGRect frame = firscrollView.frame;
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     dispatch_group_t group = dispatch_group_create();
    [maplistarray removeAllObjects];
     for (int i = 0; i<listarray.count; i++)
     {
      
         if (buttonarray.count ==0 || buttonarray.count !=listarray.count)
         {
             UIButton*buttongs = [UIButton buttonWithType:UIButtonTypeCustom];
             buttongs.tag = i;
             [buttongs addTarget:self action:@selector(yincang:) forControlEvents:UIControlEventTouchUpInside];
             buttongs.frame = CGRectMake(frame.size.width*i , 0, 320, 120);
             [buttongs setImage:[UIImage imageNamed:@"instead_fir"] forState:UIControlStateNormal];
             [firscrollView addSubview:buttongs];
             
             [idaray  addObject:[[listarray objectAtIndex:i] objectForKey:@"id"]];
             dispatch_group_async(group, queue, ^{
                 
                 NSString *url = [NSString stringWithFormat:
                                  @"%@%@%@",
                                  _urlHost, API_DEVELOPIAMGE,
                                  [[listarray objectAtIndex:i] objectForKey:@"deveimage"]];
                 
                 NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
                 UIImage *image = [UIImage imageWithData:data];
                 UIImage *resImage = [UITools reSizeImage:image toSize:CGSizeMake(640, 238)];
                 if (data !=nil){
                     NSDictionary *diction = [[NSDictionary alloc] initWithObjectsAndKeys:data,@"data", [[listarray objectAtIndex:i] objectForKey:@"developname"],@"developname",[[listarray objectAtIndex:i] objectForKey:@"id"],@"id",[[listarray objectAtIndex:i] objectForKey:@"latitude"],@"latitude",[[listarray objectAtIndex:i] objectForKey:@"longitude"],@"longitude",nil];
                     [maplistarray addObject:diction];
                 }
                 
                 if (data != nil) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [buttongs setImage:resImage forState:UIControlStateNormal];
                     });
                 }
                 
             });
         AppDelegate *mydelega = [UIApplication sharedApplication].delegate;
             UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*i+10, 85, 200, 30)];
             lable.backgroundColor = [UIColor clearColor];
             lable.textColor = [UIColor whiteColor];
            if ([mydelega.language isEqualToString:@"english"]) {
             lable.numberOfLines = 2;
             lable.font = [UIFont systemFontOfSize:13];
             }
             
             lable.text = [[listarray objectAtIndex:i] objectForKey:@"developname"];
             [firscrollView addSubview:lable];

         }
         else
         {
             
             [firscrollView addSubview:[buttonarray objectAtIndex:i]];
             
             [idaray  addObject:[[listarray objectAtIndex:i] objectForKey:@"id"]];
             dispatch_group_async(group, queue, ^{
                 
                 NSString *url = [NSString stringWithFormat:
                                  @"%@%@%@",
                                  _urlHost, API_DEVELOPIAMGE,
                                  [[listarray objectAtIndex:i] objectForKey:@"deveimage"]];
                 
                 NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
                 UIImage *image = [UIImage imageWithData:data];
                 UIImage *resImage = [UITools reSizeImage:image toSize:CGSizeMake(640, 238)];
                 if (data !=nil){
                     NSDictionary *diction = [[NSDictionary alloc] initWithObjectsAndKeys:data,@"data", [[listarray objectAtIndex:i] objectForKey:@"developname"],@"developname",[[listarray objectAtIndex:i] objectForKey:@"id"],@"id",[[listarray objectAtIndex:i] objectForKey:@"latitude"],@"latitude",[[listarray objectAtIndex:i] objectForKey:@"longitude"],@"longitude",nil];
                     [maplistarray addObject:diction];
                 }
                 
                 if (data != nil) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [[buttonarray objectAtIndex:i] setImage:resImage forState:UIControlStateNormal];
                     });
                 }
                 
             });
             
             AppDelegate *mydelega = [UIApplication sharedApplication].delegate;
             UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*i+10, 85, 200, 30)];
             lable.backgroundColor = [UIColor clearColor];
             lable.textColor = [UIColor whiteColor];
             if ([mydelega.language isEqualToString:@"english"]) {
                 lable.numberOfLines = 2;
                 lable.font = [UIFont systemFontOfSize:13];
             }
             
             lable.text = [[listarray objectAtIndex:i] objectForKey:@"developname"];
             [firscrollView addSubview:lable];
         }
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"updateUi");
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tablemessage) userInfo:nil repeats:YES];
        timer2 = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tablemessagetwo) userInfo:nil repeats:YES];
        [timer2 setFireDate:[NSDate distantFuture]];
        
        NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString*path=[paths objectAtIndex:0];
        AppDelegate *mydelega = [UIApplication sharedApplication].delegate;
      
        if ([mydelega.language isEqualToString:@"china"]) {
            NSString *filename=[path stringByAppendingPathComponent:@"Picture.plist"];
            [maplistarray writeToFile:filename atomically:YES];
           
        }
       else
       {
           NSString *filename=[path stringByAppendingPathComponent:@"PictureCopy.plist"];
           [maplistarray writeToFile:filename atomically:YES];
          
       }
        
    });
    dispatch_release(group);

}

-(void)setfirstimagetwo
{
    pageController.numberOfPages=listarray.count;
    CGRect frame = firscrollView.frame;
    firscrollView.contentSize = CGSizeMake(320*listarray.count, 120);
    for (int i = 0; i<listarray.count; i++)
    {
        
        UIButton*buttongs = [UIButton buttonWithType:UIButtonTypeCustom];
        buttongs.tag = i;
        [buttongs addTarget:self action:@selector(yincang:) forControlEvents:UIControlEventTouchUpInside];
        buttongs.frame = CGRectMake(frame.size.width*i , 0, 320, 120);
//        [buttongs setImage:[UIImage imageNamed:@"instead_fir"] forState:UIControlStateNormal];
        [firscrollView addSubview:buttongs];
        [buttonarray addObject:buttongs];
        
        UIImage *image = [UIImage imageWithData:[[listarray objectAtIndex:i]objectForKey:@"data"]];
        UIImage *resImage = [UITools reSizeImage:image toSize:CGSizeMake(640, 238)];
        [buttongs setImage:resImage forState:UIControlStateNormal];
      
        AppDelegate *mydelega = [UIApplication sharedApplication].delegate;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*i+10, 85, 200, 30)];
        lable.backgroundColor = [UIColor clearColor];
        lable.textColor = [UIColor whiteColor];
        if ([mydelega.language isEqualToString:@"english"]) {
            lable.numberOfLines = 2;
            lable.font = [UIFont systemFontOfSize:13];
        }
        
        lable.text = [[listarray objectAtIndex:i] objectForKey:@"developname"];
        [firscrollView addSubview:lable];    }

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
          }
        if (result.addressComponent.province !=nil) {
            addr= [NSString stringWithFormat:@"%@",result.addressComponent.province];
            province = addr;
        }
    
    }
}


-(void)PushtoDevelopview:(UIButton*)button
{
 
    ScanDevelopViewController *dview = [[ScanDevelopViewController alloc] initWithnumber:button.tag];
    [self.navigationController pushViewController:dview animated:YES];
//    [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:YES];
    
}

-(void)mylocation
{
     
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"特别行政区"];
    NSString *trimmedString = [buttonbars.text stringByTrimmingCharactersInSet:set];
    
    NSCharacterSet *setnext = [NSCharacterSet characterSetWithCharactersInString:@"壮族自治区""自治区""回族自治区""维吾尔自治区""特别行政区"];
    NSString *trimmedStringext = [province stringByTrimmingCharactersInSet:setnext];

    if (!trimmedString) {
        
        AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
        if ([delegate.language isEqualToString:@"china"])
        {
            [UITools showPopMessage:self titleInfo:@"提示" messageInfo:CannotLocate];

        }
        else
        {
            [UITools showPopMessage:self titleInfo:@"Contect" messageInfo:CannotLocateEnglish];

        }
        
 
//       [UITools showPopMessage:self titleInfo:@"提示" messageInfo:CannotLocate];
    }
    else
    {
        ScanDevelopViewController *searchview = [[ScanDevelopViewController alloc] initWithcityname:trimmedString andprovince:trimmedStringext];
        [self.navigationController pushViewController:searchview animated:YES];
//        [[AppDelegate sharedDelegate].xdTabbar setHideCustomButton:YES];

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


#pragma mark -- NetAccessDelegate

- (void)netAccess:(NetAccess *)netAccess RequestFailed:(NSMutableArray *)resultSet
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
      [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:ErrorConnect];
}

-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
     
    if (na.tag == 100){
              
        if (resultSet.count !=0) {
            listarray = resultSet;
            
            firscrollView.contentSize = CGSizeMake(320*listarray.count, 120);
            for (UIView *subView in firscrollView.subviews)
            {
                [subView removeFromSuperview];
            }
            
            [self setfirstimage];
            
            pageController.numberOfPages=listarray.count;
            
        }
        else
        {
//            [UITools showPopMessage:self titleInfo:@"提示" messageInfo:WithoutData];
             
            
        }
        
    }
}


@end
