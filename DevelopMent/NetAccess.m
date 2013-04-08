//
//  NetAccess.m
//  Scrollview
//
//  Created by xin wang on 3/6/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import "NetAccess.h"
#import "Reachability.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AppDelegate.h"
#define kTimeOutseconds 10

@implementation NetAccess

//判断有无可用网络
+(BOOL)reachable
{
    NetworkStatus wifi = [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus];
    NetworkStatus gprs = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
     if(wifi==NotReachable && gprs==NotReachable)
    {
          return NO;
     }
    return YES;
}

 

//首页图片
-(void)theFirstviewPicture:(NSString*)string
{
   
    AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@",mydele.domainName,API_INDEXIMG]];
     NSLog(@"%@",mydele.domainName);
    NSLog(@"%@",url);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    _gRequest = request;

    NSLog(@"url:%@ params:%@", url, string);
}


//搜索页
-(void)searchthemessage:(NSString *)string
{
    AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mydele.domainName,API_SEARCH]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    _gRequest = request;

    NSLog(@"url:%@ params:%@", url, string);
}

//指数
-(void)thedatamessage:(NSString *)string
{
     AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mydele.domainName,API_GETINDEX]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    _gRequest = request;

    NSLog(@"url:%@ params:%@", url, string);
}

//分类
-(void)theclassmessage:(NSString *)string
{
     AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mydele.domainName,API_CLASS]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    _gRequest = request;

    NSLog(@"url:%@ params:%@", url, string);
}

//简介
-(void)theIntroducemessage:(NSString *)string
{
     AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mydele.domainName,API_INTRO]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    _gRequest = request;

    NSLog(@"url:%@ params:%@", url , string);
}
//APP
-(void)theAppmessage:(NSString *)string 
{
     AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mydele.domainName,API_APP]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    _gRequest = request;

    NSLog(@"url:%@ params:%@", url , string);

}


//..................................................................................................................
//开发区图片+名称+文字说明
-(void)thedevelopZone:(NSString *)string
{
     AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mydele.domainName,API_GETDEVELOP]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:kTimeOutseconds];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    _gRequest = request;

    NSLog(@"url:%@ params:%@", url , string);
}

-(void)thecityName:(NSString *)string           //获取城市列表
{
     AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mydele.domainName,API_GETCITY]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    _gRequest = request;

    NSLog(@"url:%@ params:%@", url , string);

}

-(void)thelevelList:(NSString *)string       //等级列表
{
     AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mydele.domainName,API_LEVEL]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    _gRequest = request;

    NSLog(@"url:%@ params:%@", url , string);

}

-(void)theindustryList:(NSString *)string           //行业列表
{
     AppDelegate *mydele = [UIApplication sharedApplication].delegate;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mydele.domainName,API_TRADECLASS]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    _gRequest = request;

    NSLog(@"url:%@ params:%@", url , string);
}



//获取版本号
-(void)getnewVersion
{
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.101:8010/index.php/index/domain"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setTimeOutSeconds:kTimeOutseconds];
    [request startAsynchronous];
    _gRequest = request;
}

- (void)cancelAsynchronousRequest
{
    [_gRequest cancel];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"ASIFinish request:%@",[[request.responseString JSONValue] JSONString]);
    [_delegate netAccess:self RequestFinished:[request.responseString JSONValue]];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"ASIFail request:%@",[[request.responseString JSONValue] JSONString]);
    [_delegate netAccess:self RequestFailed:[request.responseString JSONValue]];
}

@end

