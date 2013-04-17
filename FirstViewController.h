//
//  FirstViewController.h
//  DevelopMent
//
//  Created by xin wang on 3/20/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "ClassViewController.h"
#import "NetAccess.h"
#import "ClassViewController.h"
#import "DiscussViewController.h"
#import "EGORefreshTableHeaderView.h"
 
@class GrayPageControl;
 
@interface FirstViewController : UITableViewController<UIScrollViewDelegate,BMKMapViewDelegate,BMKSearchDelegate,NetAccessDelegate,UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate, EGORefreshTableHeaderDelegate>
{
    UIScrollView *firscrollView;
    UIScrollView *secscrollview;
    UIScrollView* scrollview;
    UIPageControl *pageController;
    GrayPageControl *pageControllertwo;
    UIPageControl *pagecon;
    NSMutableArray *listarray;
    NSMutableArray *maplistarray;
    BMKSearch *mysearch;
    BMKMapView *myMapView;
    UILabel *buttonbars;
    NSString *province;
    UIToolbar *toolBar;
    NSMutableArray *arrayone;
     NSMutableArray *arrayonetwo;
    UISearchBar* searchbar;
    NSTimer *timer;
    NSTimer *timer2;
    NSMutableArray *imagearray;
    int Snumber;
    
    UIView *viewss;
    UIView *selectview;
    NSMutableArray *idaray;
    NSMutableArray *picturearray;
    ClassViewController *classeview;
    DiscussViewController *disview;
    NetAccess *gNetAccess;
    
    NSMutableArray *buttonarray;
    BOOL isRefresh;
    
	EGORefreshTableHeaderView *_refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes
	BOOL _reloading;
    UIColor *grayColor;
}

@property(nonatomic,strong)UIScrollView *firscrollView;
@property(nonatomic,strong)UIScrollView *secscrollview;
@property(nonatomic,strong)UIPageControl *pageController;
@property(nonatomic,strong)UIPageControl *pageControllertwo;
@property(nonatomic,strong) UIToolbar *toolBar;
@property (nonatomic, strong) NetAccess *gNetAccess;
 
@property(nonatomic,strong) NSMutableArray *maplistarray;
@property (nonatomic, strong) NSString *urlHost;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
 
@end
