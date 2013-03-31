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
@implementation NetAccess
@synthesize delegate,tag;

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
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString: Firstviewimage]];
    request.delegate = self;
     [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
}


//搜索页
-(void)searchthemessage:(NSString *)string
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:Searchinterface]];
    request.delegate = self;
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];

}

//指数
-(void)thedatamessage:(NSString *)string
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:DataInterface]];
    request.delegate = self;
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
}

//分类
-(void)theclassmessage:(NSString *)string
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:Classinterface]];
    request.delegate = self;
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
}

//简介
-(void)theIntroducemessage:(NSString *)string
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:IntroduceInterface]];
    request.delegate = self;
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];

}
//APP
-(void)theAppmessage:(NSString *)string 
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:Appintroduce]];
    request.delegate = self;
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    
}


//..................................................................................................................
//开发区图片+名称+文字说明
-(void)thedevelopZone:(NSString *)string
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:DevelopeZoneInfo]];
    request.delegate = self;
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    
}

-(void)thecityName:(NSString *)string           //获取城市列表
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:cityname]];
    request.delegate = self;
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    
}

-(void)thelevelList:(NSString *)string       //等级列表
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:levelList]];
    request.delegate = self;
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    
}

-(void)theindustryList:(NSString *)string           //行业列表
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:industryList]];
    request.delegate = self;
    [request setPostValue:string forKey:@"parameter"];
    [request startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
   
     [delegate netAccess:self RequestFinished:[request.responseString JSONValue]];
}


@end

