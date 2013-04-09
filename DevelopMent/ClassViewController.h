//
//  ClassViewController.h
//  DevelopMent
//
//  Created by xin wang on 3/22/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetAccess.h"
#import "EGORefreshTableHeaderView.h"

@interface ClassViewController : UITableViewController<NetAccessDelegate,EGORefreshTableHeaderDelegate>
{
    NSMutableArray *listarray;
    NetAccess *gNetAccess;
    EGORefreshTableHeaderView *_refreshHeaderView;
    //  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes
	BOOL _reloading;
}


@property(nonatomic,strong)NSMutableArray *listarray;
@property (nonatomic, strong) NetAccess *gNetAccess;

- (id)initWithStyle:(UITableViewStyle)style;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
