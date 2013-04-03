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
#import "CooperaViewController.h"
#import "WepViewController.h"
#import "UITools.h"

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
        NSLog(@"%@",namestring);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_view_bg"]];

      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];
     NSUserDefaults *faflult = [NSUserDefaults standardUserDefaults];
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

//    if ([[faflult objectForKey:@"lange"] isEqualToString:@"english"]) {
//         
//        [button1 setTitle:@"Introduces" forState:UIControlStateNormal];
//        [button2 setTitle:@"Index" forState:UIControlStateNormal];
//        [button3 setTitle:@"Map" forState:UIControlStateNormal];
//
//    }
//    else
//    {
//         
//        [button1 setTitle:@"简介" forState:UIControlStateNormal];
//          [button2 setTitle:@"指数" forState:UIControlStateNormal];
//         [button3 setTitle:@"地图" forState:UIControlStateNormal];
//    }
//
    
    if (fram.size.height>500) {
        firscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 455)];
        dataview = [[UITableView alloc] initWithFrame:CGRectMake(0,-30, 320,540 ) style:UITableViewStylePlain];
         myMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 505)];
         viewapp = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320,505 )];
        button1.frame = CGRectMake(0, 456, 80, 48);
        button2.frame = CGRectMake(80, 456, 80, 48);
        button3.frame = CGRectMake(160, 456, 80, 48);
        button4.frame = CGRectMake(240, 456, 80, 48);
    }
    else
    {
        firscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 375)];
         dataview = [[UITableView alloc] initWithFrame:CGRectMake(0,-30, 320,410 ) style:UITableViewStylePlain];
         myMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 415)];
         viewapp = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320,375 )];
        button1.frame = CGRectMake(0, 370, 80, 46);
        button2.frame = CGRectMake(80, 370, 80, 46);
        button3.frame = CGRectMake(160, 370, 80, 46);
        button4.frame = CGRectMake(240, 370, 80, 46);
    }
    [button1  setImage:[UIImage imageNamed:@"introducex.png"] forState:UIControlStateNormal];
    [button2  setImage:[UIImage imageNamed:@"data.png"] forState:UIControlStateNormal];
    [button3  setImage:[UIImage imageNamed:@"maps.png"] forState:UIControlStateNormal];
    [button4  setImage:[UIImage imageNamed:@"app.png"] forState:UIControlStateNormal];
    
    firscrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    firscrollView.pagingEnabled = YES;
    firscrollView.tag = 100;
    firscrollView.showsHorizontalScrollIndicator = NO;//不显示水平滑动线
    firscrollView.showsVerticalScrollIndicator = NO;//不显示垂直滑动线
    firscrollView.delegate = self;
    [firscrollView setContentOffset:CGPointMake(0, 0)];
    [self.view addSubview:firscrollView];
    
//    APPview.delegate = self;
//    APPview.dataSource = self;
//    APPview.hidden = YES;
//    APPview.scrollEnabled = NO;
//    APPview.tag = 100;
//    APPview.backgroundView = nil;
//    APPview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:viewapp];
     viewapp.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    viewapp.hidden = YES;
    UIImageView *myview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 280, 225)];
    [myview setImage:[UIImage imageNamed:@"myview.png"]];
    
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 60, 35)];
    lable1.text = @"APP：";
    lable1.backgroundColor = [UIColor clearColor];
    [myview addSubview:lable1];
    mylable1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 180, 35)];
    mylable1.backgroundColor = [UIColor clearColor];
    [myview addSubview:mylable1];
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 60, 35)];
    lable2.text = @"电话：";
    lable2.backgroundColor = [UIColor clearColor];
    [myview addSubview:lable2];
    mylable2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 180, 35)];
    mylable2.backgroundColor = [UIColor clearColor];
    [myview addSubview:mylable2];


    
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(50, 95, 60, 35)];
    lable3.text = @"传真：";
    lable3.backgroundColor = [UIColor clearColor];
    [myview addSubview:lable3];
    mylable3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 95, 180, 35)];
    mylable3.backgroundColor = [UIColor clearColor];
    [myview addSubview:mylable3];


    
    UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(50, 140, 60, 35)];
    lable4.text = @"邮件：";
    lable4.backgroundColor = [UIColor clearColor];
    [myview addSubview:lable4];
    mylable4 = [[UILabel alloc] initWithFrame:CGRectMake(100, 140, 180, 35)];
    mylable4.backgroundColor = [UIColor clearColor];
    [myview addSubview:mylable4];


    UILabel *lable5 = [[UILabel alloc] initWithFrame:CGRectMake(50, 185, 60, 35)];
    lable5.text = @"网址：";
    lable5.backgroundColor = [UIColor clearColor];
    [myview addSubview:lable5];
   [viewapp addSubview:myview];
    mylable5= [[UILabel alloc] initWithFrame:CGRectMake(100, 185, 180, 35)];
    mylable5.backgroundColor = [UIColor clearColor];
    [myview addSubview:mylable5];

    [lable1 release];
    [lable2 release];
    [lable3 release];
    [lable4 release];
    [lable5 release];
    

    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [dataview setBackgroundView:imageview];
    dataview.delegate = self;
    dataview.dataSource = self;
    dataview.hidden = YES;
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
    
    assAiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    assAiv.center = CGPointMake(160, 240);
    assAiv.color = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:assAiv];
//    dataarray = [self getthedata];
    
    self.navigationItem.leftBarButtonItem = [UITools getNavButtonItem:self];
    
    introducearrytwo = [self getthedatatwo];
    NSLog(@"%d",introducearrytwo.count);
    if (introducearrytwo.count != 0) {
        firscrollView.contentSize = CGSizeMake(320*(introducearrytwo.count), 120);
        [self  introduceviewtwo];
    }
}

-(void)backtosuper
{
    [self.navigationController  popViewControllerAnimated:YES];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [assAiv stopAnimating];
}



 
-(void)viewWillAppear:(BOOL)animated
{
   
    if([NetAccess reachable])
    {
        [assAiv startAnimating];
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
            NetAccess *netAccess = [[NetAccess alloc] init];
            netAccess.delegate = self;
            netAccess.tag = 110;
            [netAccess theIntroducemessage:allstring];
            [allstring release];
            
        }
    }
    else
    {
//        introducearrytwo = [self getthedatatwo];
//        if (introducearrytwo.count != 0) {
//            firscrollView.contentSize = CGSizeMake(320*(introducearrytwo.count), 120);
//            [self  introduceviewtwo];
//        }

        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        [alertV release];
    }

}
 
 
 

- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    if (error == 0) {
   
        NSString *addr;
        if(result.addressComponent.city!=nil)
        {
            addr= [NSString stringWithFormat:@"%@",result.addressComponent.city];
             NSLog(@" 11111111 %@ ",addr);            //市
        }
        if(result.addressComponent.district!=nil)
        {
            addr= [NSString stringWithFormat:@"%@%@",addr,result.addressComponent.district];
             NSLog(@" 222222 %@ ",addr);             //区
        }       
        if(result.addressComponent.streetName!=nil)
        {
            addr= [NSString stringWithFormat:@"%@%@",addr,result.addressComponent.streetName];
             NSLog(@" 33333 %@ ",addr);                 //街
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
    
    if (app ==YES) {
        [button1  setImage:[UIImage imageNamed:@"introduce.png"] forState:UIControlStateNormal];
        [button2  setImage:[UIImage imageNamed:@"data.png"] forState:UIControlStateNormal];
        [button3  setImage:[UIImage imageNamed:@"maps.png"] forState:UIControlStateNormal];
        [button4 setImage:[UIImage imageNamed:@"appx.png"] forState:UIControlStateNormal];
        introd = YES;
        databool = YES;
        maps = YES;
        app = !app;
    }

    
    if([NetAccess reachable])
    {
        [assAiv startAnimating];
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
            NetAccess *netAccess = [[NetAccess alloc]init];
            netAccess.delegate = self;
            netAccess.tag = 111;
            [netAccess theAppmessage:allstring];
            [allstring release];
        }
    }
    else
    {
        dataarray =   [self getthedata];
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        [alertV release];
    }

}

-(void)datamessage
{
    firscrollView.hidden = YES;
    myMapView.hidden = YES;
    viewapp.hidden = YES;
    dataview.hidden = NO;
    assAiv.color = [UIColor blackColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (databool ==YES) {
        [button1  setImage:[UIImage imageNamed:@"introduce.png"] forState:UIControlStateNormal];
        [button2  setImage:[UIImage imageNamed:@"datax.png"] forState:UIControlStateNormal];
        [button3  setImage:[UIImage imageNamed:@"maps.png"] forState:UIControlStateNormal];
        [button4 setImage:[UIImage imageNamed:@"app.png"] forState:UIControlStateNormal];
        introd = YES;
        databool = !databool;
        maps = YES;
        app = YES;
    }

    if (sum ==0)
    {
        if([NetAccess reachable])
        {
            [assAiv startAnimating];
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
                NetAccess *netAccess = [[NetAccess alloc]init];
                netAccess.delegate = self;
                netAccess.tag = 100;
                [netAccess thedatamessage:allstring];
                [allstring release];
            }
        }
        else
        {
            dataarray =   [self getthedata];
            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];
            [alertV release];
        }

    }
    sum = 1;
}

 
-(void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
   
    if (na.tag ==100)
    {
        [assAiv stopAnimating];
        dataarray = resultSet;
        [dataarray retain];
       
        if (dataarray.count !=0) {
             [dataview reloadData];
        }
        [self clearmessage];
        [self savedatamessage];
        
    }
    else if (na.tag ==110)
    {
        [assAiv stopAnimating];
        introducearray = resultSet;
        NSLog(@"%@",introducearray);
        firscrollView.contentSize = CGSizeMake(320*(introducearray.count), 120);
//         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{   [self  clearmessagetwo];});
        for (UIView *subView in firscrollView.subviews)
        {
             [subView removeFromSuperview];
        }
        [introducearrytwo removeAllObjects];
        if (introducearray.count != 0) {
             [self introduceview];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    
        
    }
    else if (na.tag ==111)
    {
        [assAiv stopAnimating];
        apparray = resultSet;
        [apparray retain];
        if ([[apparray objectAtIndex:0] objectForKey:@"link"]) {
             mylable1.text = [[apparray objectAtIndex:0] objectForKey:@"link"];
        }
       else
       {
           mylable1.text = @"暂无数据";
       }
        
        if ([[apparray objectAtIndex:0] objectForKey:@"tel"]) {
            mylable2.text = [[apparray objectAtIndex:0] objectForKey:@"tel"];
        }
        else
        {
            mylable2.text = @"暂无数据";
        }

        if ([[apparray objectAtIndex:0] objectForKey:@"fax"]) {
            mylable3.text = [[apparray objectAtIndex:0] objectForKey:@"fax"];
        }
        else
        {
            mylable3.text = @"暂无数据";
        }

        if ( [[apparray objectAtIndex:0] objectForKey:@"email"]) {
            mylable4.text = [[apparray objectAtIndex:0] objectForKey:@"email"];
        }
        else
        {
            mylable4.text = @"暂无数据";
        }

        if ([[apparray objectAtIndex:0] objectForKey:@"site"]) {
            mylable5.text = [[apparray objectAtIndex:0] objectForKey:@"site"];
        }
        else
        {
            mylable5.text = @"暂无数据";
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
         label.textColor =  [UIColor colorWithRed:0.0f green:0.812f blue:0.882f alpha:1.0f];
         if (fram.size.height>500) {
                imageview.frame = CGRectMake(frame.size.width*i, 0, 320, 200);
                textview.frame = CGRectMake(frame.size.width*i +10, 240, 300, 210);
               label.frame = CGRectMake( frame.size.width*i +10, 210, 300, 30);
         }
       else
       {
           imageview.frame = CGRectMake(frame.size.width*i, 0, 320, 200);
           textview.frame = CGRectMake(frame.size.width*i +10, 235, 300, 140);
            label.frame = CGRectMake( frame.size.width*i +10, 205, 300, 30);
       }
         imageview.backgroundColor = [UIColor blueColor];
         label.text = [[introducearray objectAtIndex:i] objectForKey:@"title"];
//         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{   
             NSString *url = [NSString stringWithFormat:@"http://192.168.1.101:8010/assets/developimage/%@",[[introducearray objectAtIndex:i] objectForKey:@"img"]];
             NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
             UIImage *image = [[UIImage alloc]initWithData:data];
           
            
//            if (data != nil)
//            {
//                 dispatch_async(dispatch_get_main_queue(), ^{   
                     [imageview setImage:image];
                     NSDictionary *diction = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[[introducearray objectAtIndex:i] objectForKey:@"content"]],@"content",data,@"data", idstring,@"did",[NSString stringWithFormat:@"%d",i] ,@"fid",[[introducearray objectAtIndex:i] objectForKey:@"title"],@"title",nil];
           
                     [introducearrytwo addObject:diction];
         
         
//                 });
//             }
//         });
 
     
      textview.backgroundColor = [UIColor clearColor];
      textview.editable = NO;
      textview.textColor = [UIColor lightGrayColor];
       textview.text = [NSString stringWithFormat:@"       %@",[[introducearrytwo objectAtIndex:i] objectForKey:@"content"]];   
      textview.font =[UIFont systemFontOfSize:16];
      [firscrollView addSubview:imageview];
      [firscrollView addSubview:textview];
      [firscrollView addSubview:label];
         [data release];
         [label release];
         [image release];
         [diction release];
         [imageview release];
         [textview release];
         
      }
     NSUserDefaults *faflult = [NSUserDefaults standardUserDefaults];
    if (![faflult objectForKey:idstring] ) {
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{   [self savedatamessagetwo];});
    }
    [faflult setObject:@"s" forKey:idstring];
 
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
         label.textColor =  [UIColor colorWithRed:0.0f green:0.812f blue:0.882f alpha:1.0f];
         if (fram.size.height>500) {
             imageview.frame = CGRectMake(frame.size.width*i, 0, 320, 200);
             textview.frame = CGRectMake(frame.size.width*i +10, 240, 300, 210);
             label.frame = CGRectMake( frame.size.width*i +10, 210, 300, 30);         }
         else
         {
             imageview.frame = CGRectMake(frame.size.width*i, 0, 320, 200);
             textview.frame = CGRectMake(frame.size.width*i +10, 235, 300, 140);
             label.frame = CGRectMake( frame.size.width*i +10, 205, 300, 30);
         }
         imageview.backgroundColor = [UIColor blueColor];
         label.text = [[introducearrytwo objectAtIndex:i] objectForKey:@"title"];
         NSData *aData = [[introducearrytwo objectAtIndex:i] objectForKey:@"data"];
         UIImage *image = [[UIImage alloc]initWithData:aData];
         [imageview setImage:image];
 
                
         textview.backgroundColor = [UIColor clearColor];
         textview.editable = NO;
         textview.textColor = [UIColor lightGrayColor];
         textview.text = [NSString stringWithFormat:@"       %@",[[introducearrytwo objectAtIndex:i] objectForKey:@"content"]];
         textview.font =[UIFont systemFontOfSize:16];
         [firscrollView addSubview:imageview];
         [firscrollView addSubview:textview];
         [firscrollView addSubview:label];
          
         [label release];
         [image release];
        
         [imageview release];
         [textview release];
         
     }
     

 }
 


-(void)introduce
{
    firscrollView.hidden = NO;
    dataview.hidden = YES;
    viewapp.hidden = YES;
    myMapView.hidden = YES;
//    self.view.backgroundColor = [UIColor blackColor];
    
    if (introd ==YES) {
        [button1  setImage:[UIImage imageNamed:@"introducex.png"] forState:UIControlStateNormal];
        [button2  setImage:[UIImage imageNamed:@"data.png"] forState:UIControlStateNormal];
        [button3  setImage:[UIImage imageNamed:@"maps.png"] forState:UIControlStateNormal];
        [button4 setImage:[UIImage imageNamed:@"app.png"] forState:UIControlStateNormal];
        introd = !introd;
        databool = YES;
        maps = YES;
        app = YES;
    }
}

 
-(void)mapviewarea
{
    firscrollView.hidden = YES;
    dataview.hidden = YES;
    viewapp.hidden = YES;
    myMapView.hidden = NO;
     assAiv.color = [UIColor whiteColor];
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.1,0.1);
    BMKCoordinateRegion reg = BMKCoordinateRegionMake(locationgs, span);
    [myMapView setRegion:reg animated:YES];
    myAnnotation.coordinate = locationgs;
//    myAnnotation.title = namestring;
    [myMapView addAnnotation:myAnnotation];
    if (maps ==YES) {
        [button1  setImage:[UIImage imageNamed:@"introduce.png"] forState:UIControlStateNormal];
        [button2  setImage:[UIImage imageNamed:@"data.png"] forState:UIControlStateNormal];
        [button3  setImage:[UIImage imageNamed:@"mapsx.png"] forState:UIControlStateNormal];
        [button4 setImage:[UIImage imageNamed:@"app.png"] forState:UIControlStateNormal];
        databool = YES;
        introd = YES;
        maps = !maps;
        app = YES;
    }
 
}




- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
//        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: @"myAnnotation"];
//         newAnnotationView.pinColor =BMKPinAnnotationColorRed;
//         newAnnotationView.animatesDrop = YES;
//          return newAnnotationView;
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: @"myAnnotation"];
        newAnnotationView.pinColor =BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;
        [newAnnotationView setImage:[UIImage imageNamed:@"tubiao.png"]];
        CGSize textSize = [namestring sizeWithFont:[UIFont systemFontOfSize:13]
                                 constrainedToSize:CGSizeMake(200, 9999)
                                     lineBreakMode:NSLineBreakByCharWrapping];
         
        UIImageView *view  = [[UIImageView alloc] initWithFrame:CGRectMake(-textSize.width/2+2, -35, textSize.width+20, 35)];
        [view setBackgroundColor:[UIColor clearColor]];
        [view setImage:[UIImage imageNamed:@"heikuang.png"]];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5,textSize.width+10, 20)];
        lable.textColor = [UIColor whiteColor];
        lable.backgroundColor = [UIColor clearColor];
         lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:14];
        lable.text = namestring;
        [view addSubview:lable];
        [newAnnotationView addSubview:view];
        [view release];
        [lable release];
        
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
    return 40;
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
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
        else
        {
            NSArray*subviews = [[NSArray alloc]initWithArray:cell.subviews];
            for (UIView *subview in subviews){
                [subview removeFromSuperview];
            }
            [subviews release];
        }
   
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 120, 40)];
        lable.font = [UIFont systemFontOfSize:19];
        lable.backgroundColor = [UIColor clearColor];
        UILabel *labletwo = [[UILabel alloc] initWithFrame:CGRectMake(185, 0, 80, 40)];
        labletwo.backgroundColor = [UIColor clearColor];
        labletwo.textColor =  [UIColor colorWithRed:0.0f green:0.812f blue:0.882f alpha:1.0f];
        [cell addSubview:lable];
        [cell addSubview:labletwo];
        [lable release];
        [labletwo release];
        for (int i = 0; i<dataarray.count; i++)
        {
            if ((indexPath.row-1) ==i )
            {      
                lable.text = [NSString stringWithFormat:@"%@:",[[dataarray objectAtIndex:i]objectForKey:@"indexname" ]];
                
                labletwo.text = [NSString stringWithFormat:@"%@ 分",[[dataarray objectAtIndex:i] objectForKey:@"num"]];
            }
        }
    }
   
// else if(tableView.tag ==100 )
//    {
//        if (cell == nil) {
//            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
//        }
//        else
//        {
////            NSArray*subviews = [[NSArray alloc]initWithArray:cell.subviews];
////            for (UIView *subview in subviews){
////                [subview removeFromSuperview];
////            }
////            [subviews release];
//        }
//
//        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 50, 50)];
//        imageview.layer.cornerRadius = 4;
//        imageview.layer.masksToBounds = YES;
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(75, 5, 240, 20)];
//        label.backgroundColor = [UIColor clearColor];
//        UILabel *labeltwo = [[UILabel alloc] initWithFrame:CGRectMake(75, 27, 240, 30)];
//        labeltwo.backgroundColor = [UIColor clearColor];
//        labeltwo.font = [UIFont systemFontOfSize:13];
//        labeltwo.numberOfLines = 2;
//        [cell addSubview:label];
//        [cell addSubview:labeltwo];
//        [cell addSubview:imageview];
//        [label release];
//        [labeltwo release];
//        [imageview release];
//        
//         switch (indexPath.row)
//        {
//                NSLog(@"%@",apparray);
//            case 0:
//                    if (apparray.count != 0) {
//                     label.text = @"APP下载链接";
//                     labeltwo.text = [[apparray objectAtIndex:0] objectForKey:@"link"];
//                   }
//                  else
//                  {
//                      label.text = @"APP下载链接";
//                     labeltwo.text = @"";
//                  }
//                
//                  [imageview setImage:[UIImage imageNamed:@"appxia.png"]];
//                  break;
//            case 1:
//               
//                if (apparray.count != 0) {
//                    labeltwo.text = [[apparray objectAtIndex:0] objectForKey:@"tel"];
//                      label.text = @"电话";
//                }
//                else
//                {
//                    labeltwo.text = @"";
//                }
//
//                 [imageview setImage:[UIImage imageNamed:@"dianhua.png"]];
//                break;
//            case 2:
//                
//                if (apparray.count != 0) {
//                    labeltwo.text = [[apparray objectAtIndex:0] objectForKey:@"fax"];
//                     label.text = @"传真";
//                }
//                else
//                {
//                    labeltwo.text = @" ";
//                }
//               [imageview setImage:[UIImage imageNamed:@"chuanzhen.png"]];
//                break;
//            case 3:
//               
//                if (apparray.count != 0) {
//                    labeltwo.text = [[apparray objectAtIndex:0] objectForKey:@"fax"];
//                      label.text = @"邮件";
//                }
//                else
//                {
//                    labeltwo.text = @" ";
//                }
//                [imageview setImage:[UIImage imageNamed:@"youjian.png"]];
//                break;
//            case 4:
//                
//                if (apparray.count != 0) {
//                    labeltwo.text = [[apparray objectAtIndex:0] objectForKey:@"site"];
//                     label.text = @"网址";
//                }
//                else
//                {
//                    labeltwo.text = @" ";
//                }
//                  [imageview setImage:[UIImage imageNamed:@"wangzhi.png"]];
//                break;
//                
//            default:
//                break;
//        }
//        return  cell;
//    }
     return cell;
}

-(void)savedatamessagetwo
{
    for (int i = 0; i<introducearrytwo.count; i++)
    {
        Introduce *entry = (Introduce *)[NSEntityDescription insertNewObjectForEntityForName:@"Introduce" inManagedObjectContext:[[self appDelegate ]managedObjectContext]];
        [ entry setDid:[[introducearrytwo objectAtIndex:i] objectForKey:@"did"]];
        [entry  setFid:[[introducearrytwo objectAtIndex:i]objectForKey:@"fid"]];
        [entry setTitle:[[introducearrytwo objectAtIndex:i]objectForKey:@"title"]];
        [entry setContent:[[introducearrytwo objectAtIndex:i] objectForKey:@"content"]];
        [ entry setData:[[introducearrytwo objectAtIndex:i] objectForKey:@"data"]];
      }
    NSError *error;
    //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
    BOOL isSaveSuccess = [[[self appDelegate] managedObjectContext]save:&error];
    if (!isSaveSuccess){
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        NSLog(@"huancun Save successful!");
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
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        NSLog(@"Save successful!");
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
    [request release];
    [sortDescriptions release];
    [sortDescriptor release];
    return array;
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
  
    [sortDescriptor release];
    [sortDescriptions release];
    [request release];
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
    if(error){
        
        for(Data*object in results) {
            [[self appDelegate].managedObjectContext deleteObject:object];
        }
    }
     if([[self appDelegate ].managedObjectContext hasChanges]) {
        
        [[self appDelegate ].managedObjectContext save:&error];
    }
    
    [request release];
   
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
    if(error){
        
        for(Data*object in results) {
            [[self appDelegate].managedObjectContext deleteObject:object];
        }
    }
    
    if([[self appDelegate ].managedObjectContext hasChanges]) {
        
        [[self appDelegate ].managedObjectContext save:&error];
    }
    [request release];
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
            NSURL *URL = [NSURL URLWithString:@"http://www.sina.com.cn/"];
            WepViewController *views = [[WepViewController alloc] initWithurl:URL];
            [self.navigationController pushViewController:views animated:YES];


        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 
 
-(void)dealloc
{
    [introducearrytwo release];introducearrytwo = nil;
    [introducearray release];introducearray = nil;
    [dataarray release];dataarray = nil;
    [myAnnotation release];myAnnotation = nil;
    [myMapView release];myMapView = nil;
    [assAiv release];assAiv = nil;
    [firscrollView release];firscrollView = nil;
    [dataview release];dataview = nil;
    [viewapp release];viewapp = nil;
    [webview release];webview = nil;
    [mylable1 release];mylable1 = nil;
     [mylable2 release];mylable2 = nil;
     [mylable3 release];mylable3 = nil;
     [mylable4 release];mylable4 = nil;
     [mylable5 release];mylable5 = nil;
    
    [super dealloc];
}



@end
