//
//  NetAccess.h
//  Scrollview
//
//  Created by xin wang on 3/6/13.
//  Copyright (c) 2013 xin wang. All rights reserved.192.168.1.105:8010
//


#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "XDHeader.h"

@protocol NetAccessDelegate;
@class ASIFormDataRequest;

@interface NetAccess : NSObject<ASIHTTPRequestDelegate>
@property(nonatomic,weak)id<NetAccessDelegate> delegate;
@property(nonatomic,assign) int tag;
@property (nonatomic, strong) ASIFormDataRequest *gRequest;
 


+(BOOL)reachable;
-(void)theFirstviewPicture:(NSString*)string;
-(void)searchthemessage:(NSString *)string;
-(void)thedatamessage:(NSString *)string;
-(void)theclassmessage:(NSString*)string;
-(void)theIntroducemessage:(NSString *)string;
-(void)theAppmessage:(NSString *)string;
-(void)getnewVersion;

-(void)thedevelopZone:(NSString *)string;
-(void)thecityName:(NSString *)string;
-(void)thelevelList:(NSString *)string;
-(void)theindustryList:(NSString *)string;
- (void)cancelAsynchronousRequest;


@end

@protocol NetAccessDelegate <NSObject>
- (void)netAccess:(NetAccess*)na RequestFinished:(NSMutableArray*)resultSet;
- (void)netAccess:(NetAccess*)netAccess RequestFailed:(NSMutableArray*)resultSet;

@end