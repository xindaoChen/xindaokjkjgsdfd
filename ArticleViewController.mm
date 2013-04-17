//
//  ArticleViewController.m
//  DevelopMent
//
//  Created by xin wang on 3/20/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import "ArticleViewController.h"
#import "AppDelegate.h"
#import "Data.h"
#import "MyCell.h"
#import "Introduce.h"
#import "WepViewController.h"
#import "MBProgressHUD.h"
#import "UITools.h"
#import "Yunju.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController
@synthesize myMapView,mysearch,myAnnotation;
@synthesize  myurl,dataview,idstring,viewapp;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (id)initWithurl:(NSDictionary *)array
{
    self = [super init];
    if (self)
    {
        idstring = [ array  objectForKey:@"id"];
        locationgs.longitude = [[ array  objectForKey:@"longitude"] floatValue];
        locationgs.latitude =  [[ array  objectForKey:@"latitude"] floatValue];
        namestring =[ array  objectForKey:@"developname"];
        self.title = namestring;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NetAccess *netAccess = [[NetAccess alloc] init];
    _gNetAccess = netAccess;
    
    _appNetAccess = [[NetAccess alloc] init];;
    _dataNetAccess = [[NetAccess alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_view_bg"]];
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
 
    AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
    _urlHost = delegate.domainName;

    
    sum = 0;
    introd = NO;
    app = YES;
    maps = YES;
    databool = YES;
    CGRect fram = self.view.frame;
    self.view.backgroundColor = [UIColor whiteColor];
    dataarray = [[NSMutableArray alloc] init];
    introducearray = [[NSMutableArray alloc] init ];
    introducearrytwo = [[NSMutableArray alloc] init];
    webview = [[UIWebView alloc] init];
    apparray = [[NSMutableArray alloc] init];
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 addTarget:self action:@selector(introduce) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = [UIColor grayColor];

    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 addTarget:self action:@selector(datamessage) forControlEvents:UIControlEventTouchUpInside];
    button2.backgroundColor = [UIColor grayColor];

    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 addTarget:self action:@selector(mapviewarea) forControlEvents:UIControlEventTouchUpInside];
    button3.backgroundColor = [UIColor grayColor];

    button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setTitle:@"APP" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(pushtospp) forControlEvents:UIControlEventTouchUpInside];
    button4.backgroundColor = [UIColor grayColor];

    float height = 54;
    float lenght_height = 450;
     if (fram.size.height>500) {
        firscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 455)];
        dataview = [[UITableView alloc] initWithFrame:CGRectMake(0,-30, 320,540 ) style:UITableViewStylePlain];
        myMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 505)];
        viewapp = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320,505 )];
        button1.frame = CGRectMake(0, lenght_height, 80, height);
        button2.frame = CGRectMake(80, lenght_height, 80, height);
        button3.frame = CGRectMake(160, lenght_height, 80, height);
        button4.frame = CGRectMake(240, lenght_height, 80, height);
    }
    else
    {
        firscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 375)];
        dataview = [[UITableView alloc] initWithFrame:CGRectMake(0,-30, 320,410 ) style:UITableViewStylePlain];
        myMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 415)];
        viewapp = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320,375 )];
        button1.frame = CGRectMake(0, 363, 80, height);
        button2.frame = CGRectMake(80, 363, 80, height);
        button3.frame = CGRectMake(160, 363, 80, height);
        button4.frame = CGRectMake(240, 363, 80, height);
    }
    if ([delegate.language isEqualToString:@"china"]) {
        [button1  setImage:[UIImage imageNamed:@"introducex.png"] forState:UIControlStateNormal];
        [button2  setImage:[UIImage imageNamed:@"data.png"] forState:UIControlStateNormal];
        [button3  setImage:[UIImage imageNamed:@"maps.png"] forState:UIControlStateNormal];
      
     }
    else
    {
        [button1  setImage:[UIImage imageNamed:@"eintroducex.png"] forState:UIControlStateNormal];
        [button2  setImage:[UIImage imageNamed:@"edata.png"] forState:UIControlStateNormal];
        [button3  setImage:[UIImage imageNamed:@"emaps.png"] forState:UIControlStateNormal];
//        [button4  setImage:[UIImage imageNamed:@"eapp.png"] forState:UIControlStateNormal];

    }
    [button4  setImage:[UIImage imageNamed:@"app.png"] forState:UIControlStateNormal];
    firscrollView.backgroundColor =   [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
    firscrollView.pagingEnabled = YES;
    firscrollView.tag = 100;
    firscrollView.showsHorizontalScrollIndicator = NO;//不显示水平滑动线
    firscrollView.showsVerticalScrollIndicator = NO;//不显示垂直滑动线
    firscrollView.delegate = self;
    [firscrollView setContentOffset:CGPointMake(0, 0)];
    UIImageView *insteadview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    [insteadview setImage:[UIImage imageNamed:@"instead_mes"]];
    [firscrollView addSubview:insteadview];
    [self.view addSubview:firscrollView];
    
 
  
    viewapp.backgroundColor =   [UIColor colorWithPatternImage:[UIImage imageNamed:@"di_wen.png"]];
    viewapp.hidden = YES;
     [self.view addSubview:viewapp];
     UIImageView *myimageview = [[UIImageView alloc] initWithFrame:CGRectMake(95, 10, 130, 100)];
    [myimageview setImage:[UIImage imageNamed:@"applogo.png"]];
    [viewapp addSubview:myimageview];
    
    loadbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loadbutton setBackgroundImage:[UIImage imageNamed:@"load.png"] forState:UIControlStateNormal];
    [loadbutton addTarget:self action:@selector(pushtoapp) forControlEvents:UIControlEventTouchUpInside];
    loadbutton.frame = CGRectMake(100, 130, 120, 40);
    [viewapp addSubview:loadbutton];
    loadlabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 80, 40)];
    loadlabel.backgroundColor = [UIColor clearColor];
    loadlabel.font = [UIFont systemFontOfSize:16];
    loadlabel.textColor = [UIColor whiteColor];
    [loadbutton addSubview:loadlabel];
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 180, 40, 40)];
    imageview1.backgroundColor = [UIColor clearColor];
    [imageview1 setImage:[UIImage imageNamed:@"phone.png"]];
    [viewapp addSubview:imageview1];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 180, 60, 40)];
    if ([delegate.language isEqualToString:@"china"]) {
        label1.text = @"电话 :";

    }
    else
    {
        label1.text = @"    Tel :";

    }

    label1.backgroundColor = [UIColor clearColor];
    //label1.text = @"电话 :";
    [viewapp addSubview:label1];

    mylable1 = [[UILabel alloc] initWithFrame:CGRectMake(125, 180, 160, 40)];
    mylable1.backgroundColor = [UIColor clearColor];
    [viewapp addSubview:mylable1];
    UIButton *phonebuton = [UIButton buttonWithType:UIButtonTypeCustom];
    phonebuton.backgroundColor = [UIColor clearColor];
    [phonebuton addTarget:self action:@selector(takephone) forControlEvents:UIControlEventTouchUpInside];
    phonebuton.frame = CGRectMake(120, 180, 230, 40);
    [viewapp addSubview:phonebuton];
    
    UIButton *phonebuton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    phonebuton2.backgroundColor = [UIColor clearColor];
    [phonebuton2 addTarget:self action:@selector(pushtosite) forControlEvents:UIControlEventTouchUpInside];
    phonebuton2.frame = CGRectMake(120, 315, 230, 40);
    [viewapp addSubview:phonebuton2];
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 225, 40, 40)];
    imageview2.backgroundColor = [UIColor clearColor];
     [imageview2 setImage:[UIImage imageNamed:@"fax.png"]];
    [viewapp addSubview:imageview2];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 225, 60, 40)];
    label2.backgroundColor = [UIColor clearColor];
    
    if ([delegate.language isEqualToString:@"china"]) {
        label2.text = @"传真 :";
    }
    else
    {
    label2.text = @"   Fax :";
    }
    
        [viewapp addSubview:label2];

    mylable2 = [[UILabel alloc] initWithFrame:CGRectMake(125, 225, 160, 40)];
    mylable2.backgroundColor = [UIColor clearColor];
    [viewapp addSubview:mylable2];
    
    UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 270, 40, 40)];
    imageview3.backgroundColor = [UIColor clearColor];
     [imageview3 setImage:[UIImage imageNamed:@"email.png"]];
    [viewapp addSubview:imageview3];

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(70, 270, 60, 40)];
    label3.backgroundColor = [UIColor clearColor];
    
      
    if ([delegate.language isEqualToString:@"china"]) {
         label3.text = @"邮件 :";
    }
    else
    {
        label3.text = @"Email :";
    }

    [viewapp addSubview:label3];

    mylable3 = [[UILabel alloc] initWithFrame:CGRectMake(125, 270, 160, 40)];
    mylable3.backgroundColor = [UIColor clearColor];
    [viewapp addSubview:mylable3];
    
    UIImageView *imageview4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 315, 40, 40)];
    imageview4.backgroundColor = [UIColor clearColor];
     [imageview4 setImage:[UIImage imageNamed:@"site.png"]];
    [viewapp addSubview:imageview4];

    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(70, 315, 60, 40)];
    label4.backgroundColor = [UIColor clearColor];
    
    if ([delegate.language isEqualToString:@"china"]) {
       label4.text = @"网址 :";
    }
    else
    {
        label4.text = @"  URL :";
    }

//    label4.text = @"网址 :";
    [viewapp addSubview:label4];

    mylable4 = [[UILabel alloc] initWithFrame:CGRectMake(125, 315, 160, 40)];
    mylable4.backgroundColor = [UIColor clearColor];
    [viewapp addSubview:mylable4];
    
    

    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"di_wen.png"]];
    [dataview setBackgroundView:imageview];
    dataview.delegate = self;
    dataview.dataSource = self;
    dataview.hidden = YES;
    dataview.userInteractionEnabled = NO;
    dataview.tag = 200;
    dataview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:dataview];
    
    myMapView.backgroundColor = [UIColor clearColor];
    myMapView.delegate =self;
    myMapView.hidden = YES;
    [myMapView setScrollEnabled:YES];          //可滑动
    myMapView.zoomEnabled = YES;             //多点放缩
    myMapView.showsUserLocation = NO;        //显示自己位置
    [self.view addSubview:myMapView];
    myAnnotation = [[BMKPointAnnotation alloc] init];
//    UIButton *buttonmap = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    buttonmap.frame = CGRectMake(10, 10, 40, 40);
//    buttonmap.backgroundColor = [UIColor clearColor];
//    [buttonmap addTarget:self action:@selector(mapselect) forControlEvents:UIControlEventTouchUpInside];
//    [myMapView addSubview:buttonmap];
    
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
    [self.view addSubview:button4];
    
    leftbutton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    leftbutton.frame = CGRectMake(0,0,20,40);
    leftbutton.backgroundColor = [UIColor blueColor];
    [leftbutton addTarget:self action:@selector(leftfunction) forControlEvents:UIControlEventTouchUpInside];
    
    rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(0,0,20,40);
    rightbutton.backgroundColor = [UIColor redColor];
    [rightbutton addTarget:self action:@selector(rightfunction) forControlEvents:UIControlEventTouchUpInside];

    
    self.navigationItem.leftBarButtonItem = [UITools getNavButtonItem:self];
    
    NSUserDefaults *faflult = [NSUserDefaults standardUserDefaults];
 
    if ([[faflult objectForKey:idstring] isEqualToString:delegate.language]) {
           introducearrytwo = [self getthedatatwo];
        if (introducearrytwo.count != 0) {
            sum = 1;
            firscrollView.contentSize = CGSizeMake(320*(introducearrytwo.count), 120);
            [self  introduceviewtwo];
            
        }
        

    }
    
}


-(void)takephone
{
  AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
    if ([[apparray objectAtIndex:0] objectForKey:@"tel"]) {
        if ([delegate.language isEqualToString:@"china"])
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:nil
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:[NSString stringWithFormat:@"拨打 %@",[[apparray objectAtIndex:0] objectForKey:@"tel"]],nil];
            [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        }
        else
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:nil
                                          delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:[NSString stringWithFormat:@"Call %@",[[apparray objectAtIndex:0] objectForKey:@"tel"]],nil];
            [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        }

    }
   
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:nil
//                                  delegate:self
//                                  cancelButtonTitle:@"取消"
//                                  destructiveButtonTitle:nil
//                                  otherButtonTitles:[NSString stringWithFormat:@"拨打 %@",[[apparray objectAtIndex:0] objectForKey:@"tel"]],nil];
  
//    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];

}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
         if (buttonIndex == 0)     //打电话
        {
               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[[apparray objectAtIndex:0] objectForKey:@"tel"]]]];
        }
 }

 

-(void)pushtosite
{
    if ([[apparray objectAtIndex:0] objectForKey:@"site"]) {
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[[apparray objectAtIndex:0] objectForKey:@"site"]]]];
    }
   
}

-(void)pushtoapp
{
    
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/moxtra-jing-cai.-fen-cheng/id590571587?mt=8"]];
}


-(void)backtosuper
{
    [self canRequest];
    [self.navigationController  popViewControllerAnimated:YES];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}



 
-(void)viewWillAppear:(BOOL)animated
{
   
    if([NetAccess reachable] && sum == 0 )
    {
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         AppDelegate *delega =[UIApplication sharedApplication].delegate;
        if (delega.language && idstring)
        {
 
            NSString *string1 = @"{\"type\":\"";
            NSString *string2 = [NSString stringWithFormat:@"%@\",",delega.language];
            NSString *string3 =@"\"did\":\"";
            NSString *string4 =[NSString stringWithFormat:@"%@\"}",idstring];
            NSMutableString *allstring = [[NSMutableString alloc] init];
            [allstring appendString:string1];
            [allstring appendString:string2];
            [allstring appendString:string3];
            [allstring appendString:string4];
            _gNetAccess.delegate = self;
            _gNetAccess.tag = 110;
            [_gNetAccess theIntroducemessage:allstring];

        }
    }
    else if(![NetAccess reachable])
    {
//        introducearrytwo = [self getthedatatwo];
//        if (introducearrytwo.count != 0) {
//            firscrollView.contentSize = CGSizeMake(320*(introducearrytwo.count), 120);
//            [self  introduceviewtwo];
//        }
        
        
        AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
        if ([delegate.language isEqualToString:@"china"])
        {
             [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:ErrorInternet];
        }
        else
        {
              [UITools showPopMessage:self titleInfo:@"Internet Contact" messageInfo:ErrorInternetEnglish];
        }

    
//        [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:ErrorInternet];

    }

}
 
 
 

- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    if (error == 0) {
   
        NSString *addr;
        if(result.addressComponent.city!=nil)
        {
            addr= [NSString stringWithFormat:@"%@",result.addressComponent.city];
             
        }
 
     }
}


-(void)pushtospp
{
    firscrollView.hidden = YES;
    myMapView.hidden = YES;
    dataview.hidden = YES;
    viewapp.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    AppDelegate *mydelega = [UIApplication sharedApplication].delegate;
    if ([mydelega.language isEqualToString:@"china"]) {
        if (app ==YES) {
            [button1  setImage:[UIImage imageNamed:@"introduce.png"] forState:UIControlStateNormal];
            [button2  setImage:[UIImage imageNamed:@"data.png"] forState:UIControlStateNormal];
            [button3  setImage:[UIImage imageNamed:@"maps.png"] forState:UIControlStateNormal];
           
            introd = YES;
            databool = YES;
            maps = YES;
            app = !app;
        }
     }
    else
    {
        if (app ==YES) {
            [button1  setImage:[UIImage imageNamed:@"eintroduce.png"] forState:UIControlStateNormal];
            [button2  setImage:[UIImage imageNamed:@"edata.png"] forState:UIControlStateNormal];
            [button3  setImage:[UIImage imageNamed:@"emaps.png"] forState:UIControlStateNormal];
           
            introd = YES;
            databool = YES;
            maps = YES;
            app = !app;
        }

    }
   [button4 setImage:[UIImage imageNamed:@"appx.png"] forState:UIControlStateNormal];
    
    if([NetAccess reachable])
    {
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        AppDelegate *delega =[UIApplication sharedApplication].delegate;
        if (delega.language && idstring) {
            NSString *string1 = @"{\"type\":\"";
            NSString *string2 = [NSString stringWithFormat:@"%@\",",delega.language];
            NSString *string3 =@"\"did\":\"";
            NSString *string4 =[NSString stringWithFormat:@"%@\"}",idstring];
            NSMutableString *allstring = [[NSMutableString alloc] init];
            [allstring appendString:string1];
            [allstring appendString:string2];
            [allstring appendString:string3];
            [allstring appendString:string4];
            _appNetAccess.delegate = self;
            _appNetAccess.tag = 111;
            [_appNetAccess theAppmessage:allstring];

        }
    }
    else
    {
      
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

}

-(void)datamessage
{
    firscrollView.hidden = YES;
    myMapView.hidden = YES;
    viewapp.hidden = YES;
    dataview.hidden = NO;
   // assAiv.color = [UIColor blackColor];
    
    dataarray =   [self getthedata];
    [dataview reloadData];
    self.view.backgroundColor = [UIColor whiteColor];
    AppDelegate *mydelega = [UIApplication sharedApplication].delegate;
    if ([mydelega.language isEqualToString:@"china"])
    {
        if (databool ==YES) {
            [button1  setImage:[UIImage imageNamed:@"introduce.png"] forState:UIControlStateNormal];
            [button2  setImage:[UIImage imageNamed:@"datax.png"] forState:UIControlStateNormal];
            [button3  setImage:[UIImage imageNamed:@"maps.png"] forState:UIControlStateNormal];
           
            introd = YES;
            databool = !databool;
            maps = YES;
            app = YES;
        }

    }
    else
    {
        if (databool ==YES) {
            [button1  setImage:[UIImage imageNamed:@"eintroduce.png"] forState:UIControlStateNormal];
            [button2  setImage:[UIImage imageNamed:@"edatax.png"] forState:UIControlStateNormal];
            [button3  setImage:[UIImage imageNamed:@"emaps.png"] forState:UIControlStateNormal];
//            [button4 setImage:[UIImage imageNamed:@"eapp.png"] forState:UIControlStateNormal];
            introd = YES;
            databool = !databool;
            maps = YES;
            app = YES;
        }
     [button4 setImage:[UIImage imageNamed:@"app.png"] forState:UIControlStateNormal];
    }
   
//    if (sum == 0 || sum == 1)
//    {
        if([NetAccess reachable])
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            AppDelegate *delega =[UIApplication sharedApplication].delegate;
            if (delega.language && idstring) {
                NSString *string1 = @"{\"type\":\"";
                NSString *string2 = [NSString stringWithFormat:@"%@\",",delega.language];
                NSString *string3 =@"\"did\":\"";
                NSString *string4 =[NSString stringWithFormat:@"%@\"}",idstring];
                NSMutableString *allstring = [[NSMutableString alloc] init];
                [allstring appendString:string1];
                [allstring appendString:string2];
                [allstring appendString:string3];
                [allstring appendString:string4];
                _dataNetAccess.delegate = self;
                _dataNetAccess.tag = 100;
                [_dataNetAccess thedatamessage:allstring];

            }
        }
        else
        {

//            [UITools showPopMessage:self titleInfo:@"网络提示" messageInfo:ErrorInternet];
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

//    }
//    sum = 1;
}

#pragma mark -- NetAccessDelegate

- (void)netAccess:(NetAccess *)netAccess RequestFailed:(NSMutableArray *)resultSet
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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

-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if (na.tag ==100)
    {
        dataarray = resultSet;
        if (dataarray.count !=0) {
             [dataview reloadData];
            [self clearmessage];
            [self savedatamessage];
        }
        else{
//            [UITools showPopMessage:self titleInfo:@"提示" messageInfo:WithoutData];
            AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
            if ([delegate.language isEqualToString:@"china"])
            {
                [UITools showPopMessage:self titleInfo:@"提示" messageInfo:WithoutData];
            }
            else
            {
               [UITools showPopMessage:self titleInfo:@"Contact" messageInfo:WithoutDataEnglish];
            }
            

        }
       
        
    }
    else if (na.tag ==110)
    {
        introducearray = resultSet;
        firscrollView.contentSize = CGSizeMake(320*(introducearray.count), 120);
//         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{   [self  clearmessagetwo];});
        [introducearrytwo removeAllObjects];
        if (introducearray.count != 0) {
            for (UIView *subView in firscrollView.subviews)
            {
                [subView removeFromSuperview];
            }

             [self introduceview];
        }
        else
        {   AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
            if ([delegate.language isEqualToString:@"china"])
            {
                [UITools showPopMessage:self titleInfo:@"提示" messageInfo:WithoutData];
            }
            else
            {
                [UITools showPopMessage:self titleInfo:@"Contact" messageInfo:WithoutDataEnglish];
            }

        }
    }
    else if (na.tag ==111)
    {
         apparray = resultSet;
         if ([[[apparray objectAtIndex:0] objectForKey:@"link"] isEqualToString:@""] ||  resultSet ==nil) {
            
             AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
             if ([delegate.language isEqualToString:@"china"])
             {
                 loadlabel.text = @"暂无APP";

             }
             else
             {
                 loadlabel.text = @"No APP";

             }

//             loadlabel.text = @"暂无APP";
             loadbutton.userInteractionEnabled = NO;
         }
        else
        {
            
            AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
            if ([delegate.language isEqualToString:@"china"])
            {
               loadlabel.text = @"点击下载";
                
            }
            else
            {
              loadlabel.text = @"Download";
                
            }

//             loadlabel.text = @"点击下载";
             loadbutton.userInteractionEnabled = YES;
         }
        
       
        if ([[[apparray objectAtIndex:0] objectForKey:@"tel"]  isEqualToString:@""]  ||  resultSet ==nil) {
           
            AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
            if ([delegate.language isEqualToString:@"china"])
            {
                mylable1.text = @"暂无数据";
                
            }
            else
            {
              mylable1.text = @"Empty";
                
            }
         }
       else
       {
             mylable1.text = [[apparray objectAtIndex:0] objectForKey:@"tel"];
       }
        
        if ([[[apparray objectAtIndex:0] objectForKey:@"fax"] isEqualToString:@""] ||  resultSet ==nil) {
            
            AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
            if ([delegate.language isEqualToString:@"china"])
            {
                mylable2.text = @"暂无数据";
                
            }
            else
            {
                mylable2.text = @"Empty";
                
            }

        }
        else
        {
           mylable2.text = [[apparray objectAtIndex:0] objectForKey:@"fax"];
        }

        if ([[[apparray objectAtIndex:0] objectForKey:@"email"] isEqualToString:@""] ||  resultSet ==nil) {
            
            AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
            if ([delegate.language isEqualToString:@"china"])
            {
                mylable3.text = @"暂无数据";
                
            }
            else
            {
                mylable3.text = @"Empty";
                
            }

        }
        else
        {
           mylable3.text = [[apparray objectAtIndex:0] objectForKey:@"email"];
        }

        if ( [[[apparray objectAtIndex:0] objectForKey:@"site"] isEqualToString:@""] ||  resultSet ==nil) {
           
            AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
            if ([delegate.language isEqualToString:@"china"])
            {
                mylable4.text = @"暂无数据";
                
            }
            else
            {
                mylable4.text = @"Empty";
                
            }
        }
        else
        {
            mylable4.text = [[apparray objectAtIndex:0] objectForKey:@"site"];
        }
 
        
    }
}

-(void)introduceview
{
    CGRect fram = self.view.frame;
    CGRect frame = firscrollView.frame;
    for (int i = 0; i<introducearray.count; i++)
     {
         UIImageView *imageview = [[UIImageView alloc] init];
         UITextView*   textview = [[UITextView alloc] init];
         UILabel *label = [[UILabel alloc] init];
         label.backgroundColor = [UIColor clearColor];
         label.font = [UIFont boldSystemFontOfSize:18];
         label.textColor = [UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0];
         UILabel *numlabel = [[UILabel alloc] init];
         numlabel.textAlignment = NSTextAlignmentCenter;
          numlabel.textColor = [UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0];
         if (fram.size.height>500) {
                imageview.frame = CGRectMake(frame.size.width*i, 0, 320, 150);
                textview.frame = CGRectMake(frame.size.width*i +10, 190, 300, 262);
               label.frame = CGRectMake( frame.size.width*i +10, 160, 300, 30);
             numlabel.frame = CGRectMake(frame.size.width*i+250 , 160, 60, 30);
         }
       else
       {
           imageview.frame = CGRectMake(frame.size.width*i, 0, 320, 150);
           textview.frame = CGRectMake(frame.size.width*i +10, 185, 300, 185);
            label.frame = CGRectMake( frame.size.width*i +10, 155, 230, 30);
           numlabel.frame = CGRectMake( frame.size.width*i +250, 155, 60, 30);
       }
         [imageview setImage:[UIImage imageNamed:@"instead_mes"]];
         numlabel.backgroundColor = [UIColor clearColor];
         numlabel.text = [NSString stringWithFormat:@"%d/%d",(i+1),introducearray.count];
         imageview.backgroundColor = [UIColor clearColor];
         label.text = [[introducearray objectAtIndex:i] objectForKey:@"title"];
//         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{   
           NSString *url = [NSString stringWithFormat:
                            @"%@%@%@",
                            _urlHost, API_DEVELOPIAMGE,
                            [[introducearray objectAtIndex:i] objectForKey:@"img"]];
         
             NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
             UIImage *image = [[UIImage alloc]initWithData:data];
           
            
            if (data != nil)
            {
//                 dispatch_async(dispatch_get_main_queue(), ^{
                     [imageview setImage:image];
                    
         
//                 });
             }
//         });
         NSDictionary *diction = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[[introducearray objectAtIndex:i] objectForKey:@"content"]],@"content",data,@"data", idstring,@"did",[NSString stringWithFormat:@"%d",i] ,@"fid",[[introducearray objectAtIndex:i] objectForKey:@"title"],@"title",nil];
         
      [introducearrytwo addObject:diction];

     
      textview.backgroundColor = [UIColor clearColor];
      textview.editable = NO;
     textview.textAlignment = NSTextAlignmentLeft;
      textview.textColor = [UIColor blackColor];
      textview.text = [NSString stringWithFormat:@"       %@",[[introducearray objectAtIndex:i] objectForKey:@"content"]];   
      textview.font =[UIFont systemFontOfSize:16];
      [firscrollView addSubview:imageview];
      [firscrollView addSubview:textview];
      [firscrollView addSubview:label];
      [firscrollView addSubview:numlabel];
         
      }
     NSUserDefaults *faflult = [NSUserDefaults standardUserDefaults];
    AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    if (![faflult objectForKey:idstring] ) {
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self savedatamessagetwo];
          });
        [faflult setObject:mydele.language forKey:idstring];
     }
    else
    {
        if ([[faflult objectForKey:idstring] isEqualToString: mydele.language]) {
           
        }
        else
        {
            [self clearmessagetwo];
            [self savedatamessagetwo];
            [faflult setObject:mydele.language forKey:idstring];
        }
    }
       
 
}

 -(void)introduceviewtwo
 {
       CGRect fram = self.view.frame;
     CGRect frame = firscrollView.frame;
     for (int i = 0; i<introducearrytwo.count; i++)
     {
         UIImageView *imageview = [[UIImageView alloc] init];
         UITextView*   textview = [[UITextView alloc] init];
         UILabel *label = [[UILabel alloc] init];
         label.backgroundColor = [UIColor clearColor];
         label.font = [UIFont boldSystemFontOfSize:18];
         label.textColor = [UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0];
         UILabel *numlabel = [[UILabel alloc] init];
         numlabel.textAlignment = NSTextAlignmentCenter;
         numlabel.textColor = [UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0];

         if (fram.size.height>500) {
             imageview.frame = CGRectMake(frame.size.width*i, 0, 320, 150);
             textview.frame = CGRectMake(frame.size.width*i +10, 190, 300, 262);
             label.frame = CGRectMake( frame.size.width*i +10, 160, 300, 30);
             numlabel.frame = CGRectMake(frame.size.width*i+250 , 160, 60, 30);

         }
         else
         {
             imageview.frame = CGRectMake(frame.size.width*i, 0, 320, 150);
             textview.frame = CGRectMake(frame.size.width*i +10, 185, 300, 185);
             label.frame = CGRectMake( frame.size.width*i +10, 155, 300, 30);
                 numlabel.frame = CGRectMake( frame.size.width*i +250, 155, 60, 30);
         }
         [imageview setImage:[UIImage imageNamed:@"instead_mes"]];
         numlabel.backgroundColor = [UIColor clearColor];
         numlabel.text = [NSString stringWithFormat:@"%d/%d",(i+1),introducearrytwo.count];

         imageview.backgroundColor = [UIColor clearColor];
         label.text = [[introducearrytwo objectAtIndex:i] objectForKey:@"title"];
         NSData *aData = [[introducearrytwo objectAtIndex:i] objectForKey:@"data"];
         UIImage *image = [[UIImage alloc]initWithData:aData];
         if (aData !=nil) {
              [imageview setImage:image];
         }
        textview.backgroundColor = [UIColor clearColor];
         textview.editable = NO;
          textview.textAlignment = NSTextAlignmentLeft;
         textview.textColor = [UIColor blackColor];
         textview.text = [NSString stringWithFormat:@"       %@",[[introducearrytwo objectAtIndex:i] objectForKey:@"content"]];
         textview.font =[UIFont systemFontOfSize:16];
         [firscrollView addSubview:imageview];
         [firscrollView addSubview:textview];
         [firscrollView addSubview:label];
         [firscrollView addSubview:numlabel];
     }
     
     [introducearrytwo removeAllObjects];
 }
 


-(void)introduce
{
    firscrollView.hidden = NO;
    dataview.hidden = YES;
    viewapp.hidden = YES;
    myMapView.hidden = YES;
    AppDelegate *mydelega = [UIApplication sharedApplication].delegate;
    if ([mydelega.language isEqualToString:@"china"])
    {
        if (introd ==YES)
        {
            [button1  setImage:[UIImage imageNamed:@"introducex.png"] forState:UIControlStateNormal];
            [button2  setImage:[UIImage imageNamed:@"data.png"] forState:UIControlStateNormal];
            [button3  setImage:[UIImage imageNamed:@"maps.png"] forState:UIControlStateNormal];
           
            introd = !introd;
            databool = YES;
            maps = YES;
            app = YES;
        }
     }
    else
    {
        if (introd ==YES)
        {
            [button1  setImage:[UIImage imageNamed:@"eintroducex.png"] forState:UIControlStateNormal];
            [button2  setImage:[UIImage imageNamed:@"edata.png"] forState:UIControlStateNormal];
            [button3  setImage:[UIImage imageNamed:@"emaps.png"] forState:UIControlStateNormal];
//            [button4 setImage:[UIImage imageNamed:@"eapp.png"] forState:UIControlStateNormal];
            introd = !introd;
            databool = YES;
            maps = YES;
            app = YES;
        }

    }
     [button4 setImage:[UIImage imageNamed:@"app.png"] forState:UIControlStateNormal];
}

 
-(void)mapviewarea
{
    firscrollView.hidden = YES;
    dataview.hidden = YES;
    viewapp.hidden = YES;
    myMapView.hidden = NO;
 //    assAiv.color = [UIColor whiteColor];
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.1,0.1);
    BMKCoordinateRegion reg = BMKCoordinateRegionMake(locationgs, span);
    [myMapView setRegion:reg animated:NO];
    myAnnotation.coordinate = locationgs;
//    myAnnotation.title = namestring;
    [myMapView addAnnotation:myAnnotation];
    AppDelegate *mydelage = [UIApplication sharedApplication].delegate;
    if ([mydelage.language isEqualToString:@"china"]) {
        if (maps ==YES) {
            [button1  setImage:[UIImage imageNamed:@"introduce.png"] forState:UIControlStateNormal];
            [button2  setImage:[UIImage imageNamed:@"data.png"] forState:UIControlStateNormal];
            [button3  setImage:[UIImage imageNamed:@"mapsx.png"] forState:UIControlStateNormal];
          
            databool = YES;
            introd = YES;
            maps = !maps;
            app = YES;
        }
    }
   else
   {
       if (maps ==YES) {
           [button1  setImage:[UIImage imageNamed:@"eintroduce.png"] forState:UIControlStateNormal];
           [button2  setImage:[UIImage imageNamed:@"edata.png"] forState:UIControlStateNormal];
           [button3  setImage:[UIImage imageNamed:@"emapsx.png"] forState:UIControlStateNormal];
//           [button4 setImage:[UIImage imageNamed:@"eapp.png"] forState:UIControlStateNormal];
           databool = YES;
           introd = YES;
           maps = !maps;
           app = YES;
       }

   }
      [button4 setImage:[UIImage imageNamed:@"app.png"] forState:UIControlStateNormal];
}




- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
         BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: @"myAnnotation"];
        newAnnotationView.pinColor =BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;
        [newAnnotationView setImage:[UIImage imageNamed:@"tubiao"]];
        CGSize textSize = [namestring sizeWithFont:[UIFont systemFontOfSize:14]
                                 constrainedToSize:CGSizeMake(260, 9999)
                                     lineBreakMode:NSLineBreakByCharWrapping];
        
        
        UIImageView *view  = [[UIImageView alloc] initWithFrame:CGRectMake(-textSize.width/2+2 , -35, textSize.width+20, 35)];
        [view setBackgroundColor:[UIColor clearColor]];
        [view setImage:[UIImage imageNamed:@"heikuang"]];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5,textSize.width+10, 20)];
        lable.textColor = [UIColor whiteColor];
        lable.backgroundColor = [UIColor clearColor];
         lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:14];
        lable.text = namestring;
        [view addSubview:lable];
        [newAnnotationView addSubview:view];
        
        return newAnnotationView;

    }
    return nil;
}

 

 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag ==100) {
        return 1;
    }
    else
    {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag ==200) {
         return dataarray.count +1;
    }
    else
    {
        return 5;
    }
    return 0;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==100) {
         return 60;
    }
    return 35;
}


-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return 20;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
     if (tableView.tag ==200)
    {
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        else
        {
            NSArray*subviews = [[NSArray alloc]initWithArray:cell.subviews];
            for (UIView *subview in subviews){
                [subview removeFromSuperview];
            }
        }
   
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 120, 40)];
        lable.font = [UIFont systemFontOfSize:19];
        lable.backgroundColor = [UIColor clearColor];
        UILabel *labletwo = [[UILabel alloc] initWithFrame:CGRectMake(185, 0, 80, 40)];
        labletwo.backgroundColor = [UIColor clearColor];
        labletwo.textColor =  [UIColor colorWithRed:0.0/255.0  green:157.0 /255.0  blue:244.0/255.0 alpha:1.0]; 
        [cell addSubview:lable];
        [cell addSubview:labletwo];
  
        for (int i = 0; i<dataarray.count; i++)
        {
            if ((indexPath.row-1) ==i )
            {      
                lable.text = [NSString stringWithFormat:@"%@:",[[dataarray objectAtIndex:i]objectForKey:@"indexname" ]];
                
                labletwo.text = [NSString stringWithFormat:@"%@ 分",[[dataarray objectAtIndex:i] objectForKey:@"num"]];
            }
        }
    }
   
      return cell;
}

-(void)savedatamessagetwo
{
    if (introducearrytwo.count != 0) {
        for (int i = 0; i<introducearrytwo.count; i++)
        {
            Introduce *entry = (Introduce *)[NSEntityDescription insertNewObjectForEntityForName:@"Introduce" inManagedObjectContext:[[self appDelegate ]managedObjectContext]];
            [ entry setDid:[[introducearrytwo objectAtIndex:i] objectForKey:@"did"]];
            [entry  setFid:[[introducearrytwo objectAtIndex:i]objectForKey:@"fid"]];
            [entry setTitle:[[introducearrytwo objectAtIndex:i]objectForKey:@"title"]];
            [entry setContent:[[introducearrytwo objectAtIndex:i] objectForKey:@"content"]];
            [ entry setData:[[introducearrytwo objectAtIndex:i] objectForKey:@"data"]];
            
        }

    }
      NSError *error;
    //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
    BOOL isSaveSuccess = [[[self appDelegate] managedObjectContext]save:&error];
    if (!isSaveSuccess){
        
    }else {
        
    }
    [introducearrytwo removeAllObjects];
}


-(void)savedatamessage
{
    for (int i = 0; i<dataarray.count; i++)
    {
        Data *entry = (Data *)[NSEntityDescription insertNewObjectForEntityForName:@"Data" inManagedObjectContext:[[self appDelegate ]managedObjectContext]];
        [ entry setDid:[[dataarray objectAtIndex:i] objectForKey:@"id"]];
        [ entry setIndexname:[[dataarray objectAtIndex:i] objectForKey:@"indexname"]];
        [entry setNum:[[dataarray objectAtIndex:i]objectForKey:@"num"]];
        [entry setFid:[NSString stringWithFormat:@"%d",i]];
        [entry setDevelopname:[[dataarray objectAtIndex:i]objectForKey:@"developname"]];

        
    }
    NSError *error;
    //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
    BOOL isSaveSuccess = [[[self appDelegate] managedObjectContext]save:&error];
    if (!isSaveSuccess){
        
    }else {
        
    }
}


-(NSMutableArray *)getthedatatwo
{
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Introduce" inManagedObjectContext:[self appDelegate ].managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    
    //根据fid查询数据
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fid" ascending:YES];
    
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    
    [request setSortDescriptors:sortDescriptions];
 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"did == %@",idstring];
    [request setPredicate:predicate];
    NSArray *results = [[self appDelegate ].managedObjectContext executeFetchRequest:request error:nil];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (Introduce *entry in results) {
        NSDictionary *glossary =
        [NSDictionary dictionaryWithObjectsAndKeys:entry.fid,@"fid",entry.content,@"content",entry.did,@"did",entry.data,@"data",entry.title,@"title",nil];
        
        [array addObject:glossary];
        
    }
    return array;
}

- (void)canRequest
{
    [_gNetAccess cancelAsynchronousRequest];
    [_appNetAccess cancelAsynchronousRequest];
    [_dataNetAccess cancelAsynchronousRequest];
}


-(NSMutableArray *)getthedata 
{
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Data" inManagedObjectContext:[self appDelegate ].managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    
    //根据fid查询数据
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fid" ascending:YES];
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"did == %@",idstring];
    [request setPredicate:predicate];
    NSArray *results = [[self appDelegate ].managedObjectContext executeFetchRequest:request error:nil];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (Data *entry in results) {
        NSDictionary *glossary =
        [NSDictionary dictionaryWithObjectsAndKeys: entry.did,@"id",entry.indexname,@"indexname",entry.num,@"num",entry.developname,@"developname",nil];
           [array addObject:glossary];
       }

    return array;
}

-(void)clearmessagetwo                  //删除数据
{
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Introduce" inManagedObjectContext:[self appDelegate ].managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    NSError *error ;
    //根据fid查询数据
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"did == %@",idstring];
    [request setPredicate:predicate];
    NSArray *results = [[self appDelegate ].managedObjectContext executeFetchRequest:request error:&error];
   
//    if(error){
    
        for(Introduce*object in results)
        {
            [[self appDelegate].managedObjectContext deleteObject:object];
        }
//    }
    if([[self appDelegate ].managedObjectContext hasChanges]) {
        
        [[self appDelegate ].managedObjectContext save:&error];
    }

}



-(void)clearmessage                  //删除数据
{
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Data" inManagedObjectContext:[self appDelegate ].managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    NSError *error ;
    //根据fid查询数据
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"did == %@",idstring];
    
    [request setPredicate:predicate];
    NSArray *results = [[self appDelegate ].managedObjectContext executeFetchRequest:request error:&error];
//    if(error){
    
        for(Data*object in results) {
            [[self appDelegate].managedObjectContext deleteObject:object];
        }
//    }
    
    if([[self appDelegate ].managedObjectContext hasChanges]) {
        
        [[self appDelegate ].managedObjectContext save:&error];
    }
}


-(AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    if (tableView.tag ==200) {
        
    }
    else
    {
        if (indexPath.row == 0) {
            NSURL *URL = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/moxtra-jing-cai.-fen-cheng/id590571587?mt=8"];
             [webview loadRequest:[NSURLRequest requestWithURL:URL]];
 
        }
        else if(indexPath.row ==4)

        {
//            NSURL *URL = [NSURL URLWithString:@"http://www.sina.com.cn/"];
//            WepViewController *views = [[WepViewController alloc] initWithurl:URL];
//            [self.navigationController pushViewController:views animated:YES];
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
