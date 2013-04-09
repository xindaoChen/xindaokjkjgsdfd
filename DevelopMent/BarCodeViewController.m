//
//  BarCodeViewController.m
//  DevelopMent
//
//  Created by 容芳志 on 13-4-7.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import "BarCodeViewController.h"
#import "UITools.h"
#import "NetAccess.h"
#import "AppDelegate.h"
#import "Yunju.h"
#import "UITools.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
@interface BarCodeViewController ()

@end

@implementation BarCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
             
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
    _urlHost = delegate.domainName;
    if ([delegate.language isEqualToString:@"china"]) {
        self.title = @"二维码";
    }
    else
    {
        self.title = @"QR Code";
    }

    
    
    UIImage  *resultimage = [[UIImage alloc]init];
    UIImageView *barImageView = [[UIImageView alloc] initWithImage:resultimage];
    barImageView.frame = CGRectMake(90, 70, 140, 140);
    

    self.navigationItem.leftBarButtonItem = [UITools getNavButtonItem:self];
    NSArray*pathss=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString*pat=[pathss objectAtIndex:0];
    NSString *filenames=[pat stringByAppendingPathComponent:@"2Dimage.plist"];
   NSMutableArray  *imageArray=[[NSMutableArray alloc]initWithContentsOfFile:filenames];
    if (imageArray.count > 0) {
        NSData *data = [imageArray objectAtIndex:0];
        resultimage = [UIImage imageWithData:data];
        barImageView.image = resultimage;
        NSData * data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:
                                                                            @"%@%@",
                                                                            _urlHost, API_2DIMAGE]]];
        NSMutableArray *imageArry2 = [[NSMutableArray alloc]initWithObjects:data2, nil];
        NSArray*paths2=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString*path2=[paths2 objectAtIndex:0];
        NSString *filename2=[path2 stringByAppendingPathComponent:@"2Dimage.plist"];
        [imageArry2 writeToFile:filename2 atomically:YES];
        imageArry2 = nil;
        data = nil;
        path2 = nil;
        paths2 = nil;

    }
    
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//              [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:
                                                @"%@%@",
                                                _urlHost, API_2DIMAGE]];
            
            NSData * data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc]initWithData:data];
            NSMutableArray *imageArry2 = [[NSMutableArray alloc]initWithObjects:data, nil];
            NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString*path=[paths objectAtIndex:0];
            NSString *filename=[path stringByAppendingPathComponent:@"2Dimage.plist"];
            [imageArry2 writeToFile:filename atomically:YES];
            
            if (data != nil) {

                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    barImageView.image = image;
                });

            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                });
                AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
                if ([delegate.language isEqualToString:@"china"])
                {
                    [UITools showPopMessage:self titleInfo:@"提示" messageInfo:WithoutData];
                    
                }
                else
                {
                    [UITools showPopMessage:self titleInfo:@"Contect" messageInfo:WithoutDataEnglish];
                    
                }

                
            }
        });

        
        
//        NSMutableArray *imageArry2 = [[NSMutableArray alloc]initWithObjects:data, nil];
//    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString*path=[paths objectAtIndex:0];
//    NSString *filename=[path stringByAppendingPathComponent:@"2Dimage.plist"];
//    [imageArry2 writeToFile:filename atomically:YES];
//    
//    resultimage = [UIImage imageWithData:data];
        
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 220, 240, 20)];
    if ([delegate.language isEqualToString:@"china"]) {
         label.text = @"扫描即可下载";
    }
   else
   {
        label.text = @"Scanning can be downloaded";
   }
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    [self.view addSubview:barImageView];
    resultimage = nil;
    _urlHost = nil;
	// Do any additional setup after loading the view.
}

-(void)backtosuper
{
    [self.navigationController   popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
