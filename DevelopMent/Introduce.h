//
//  Introduce.h
//  DevelopMent
//
//  Created by xin wang on 3/25/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Introduce : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSString * did;
@property (nonatomic, retain) NSString * fid;

@end
