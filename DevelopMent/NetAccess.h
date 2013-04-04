//
//  NetAccess.h
//  Scrollview
//
//  Created by xin wang on 3/6/13.
//  Copyright (c) 2013 xin wang. All rights reserved.192.168.1.105:8010
//

#define Firstviewimage @"http://www.dacheq.cn/index.php/index/indexImg"  //首页图片
//#define Searchinterface @"http://www.dacheq.cn/index.php/index/search"      //搜索页搜索数据
//#define DataInterface @"http://www.dacheq.cn/index.php/index/getindex"    //指数
//#define Classinterface @"http://www.dacheq.cn/index.php/index/class"            //分类
//#define IntroduceInterface @"http://www.dacheq.cn/index.php/index/intro"     //简介
//#define DevelopeZoneInfo @"http://www.dacheq.cn/index.php/index/getDevelop"     //开发区名称+图片+文字
//#define cityname @"http://www.dacheq.cn/index.php/index/getCity"  // 获取市名
//#define levelList @"http://www.dacheq.cn/index.php/index/level"   // 获取级别列表
//#define industryList @"http://www.dacheq.cn/index.php/index/tradeclass" //获取行业列表
//#define Appintroduce @"http://www.dacheq.cn/index.php/index/app"   //APP
//#define getImageUrl  @"http://www.dacheq.cn/assets/developimage/%@"   //根据图片名获取图片

#define HOST_URL                @"http://www.dacheq.com/"
//#define HOST_URL                @"http://192.168.1.101:8010/"

#define API_DEVELOPIAMGE @"assets/developimage/"         //根据图片名获取图片
#define API_APP @"index.php/index/app"                                //APP
#define API_TRADECLASS @"index.php/index/tradeclass"       //获取行业列表
#define API_LEVEL @"index.php/index/level"                             // 获取级别列表
#define API_GETCITY @"index.php/index/getCity"                   // 获取市名
#define API_GETDEVELOP @"index.php/index/getDevelop"      //开发区名称+图片+文字  
#define API_INTRO @"index.php/index/intro"                              //简介
#define API_CLASS @"index.php/index/class"                               //分类 
#define API_GETINDEX @"index.php/index/getindex"                    //指数
#define API_SEARCH @"index.php/index/search"                      //搜索页搜索数据
#define API_INDEXIMG @"index.php/index/indexImg"           //首页图片  



//#define Firstviewimage @"http://192.168.1.101:8010/index.php/index/indexImg"  //首页图片
//#define Searchinterface @"http://192.168.1.101:8010/index.php/index/search"      //搜索页搜索数据
//#define DataInterface @"http://192.168.1.101:8010/index.php/index/getindex"    //指数
//#define Classinterface @"http://192.168.1.101:8010/index.php/index/class"            //分类
//#define IntroduceInterface @"http://192.168.1.101:8010/index.php/index/intro"     //简介
//#define DevelopeZoneInfo @"http://192.168.1.101:8010/index.php/index/getDevelop"     //开发区名称+图片+文字
//#define cityname @"http://192.168.1.101:8010/index.php/index/getCity"  // 获取市名
//#define levelList @"http://192.168.1.101:8010/index.php/index/level"   // 获取级别列表
//#define industryList @"http://192.168.1.101:8010/index.php/index/tradeclass" //获取行业列表
//#define Appintroduce @"http://192.168.1.101:8010/index.php/index/app"   //APP
//#define getImageUrl  @"http://192.168.1.101:8010/assets/developimage/%@"   //根据图片名获取图片     

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "JSON.h"
@protocol NetAccessDelegate;
@interface NetAccess : NSObject<ASIHTTPRequestDelegate>
{
    id<NetAccessDelegate> delegate;
    int tag;
}
@property(nonatomic,assign)id<NetAccessDelegate> delegate;
@property(nonatomic,assign) int tag;
+(BOOL)reachable;
-(void)theFirstviewPicture:(NSString*)string;
-(void)searchthemessage:(NSString *)string;
-(void)thedatamessage:(NSString *)string;
-(void)theclassmessage:(NSString*)string;
-(void)theIntroducemessage:(NSString *)string;
-(void)theAppmessage:(NSString *)string;


-(void)thedevelopZone:(NSString *)string;
-(void)thecityName:(NSString *)string;
-(void)thelevelList:(NSString *)string;
-(void)theindustryList:(NSString *)string;

@end

@protocol NetAccessDelegate <NSObject>
- (void)netAccess:(NetAccess*)na RequestFinished:(NSMutableArray*)resultSet;
@end