//
//  ClassViewController.h
//  DevelopMent
//
//  Created by xin wang on 3/22/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetAccess.h"
@interface ClassViewController : UITableViewController<NetAccessDelegate>
{
    NSMutableArray *listarray;
    NetAccess *gNetAccess;
}
@property(nonatomic,strong)NSMutableArray *listarray;
@property (nonatomic, strong) NetAccess *gNetAccess;

- (id)initWithStyle:(UITableViewStyle)style;
@end
