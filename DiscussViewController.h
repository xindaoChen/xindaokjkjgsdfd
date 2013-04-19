//
//  DiscussViewController.h
//  DevelopMent
//
//  Created by xin wang on 3/22/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetAccess.h"

@interface DiscussViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
 
}
@property (nonatomic, strong) NSString *urlHost;
@property (nonatomic, strong) NetAccess *gNetAccess;
@end
