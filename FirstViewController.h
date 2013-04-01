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
 
@interface FirstViewController : UIViewController<UIScrollViewDelegate,BMKMapViewDelegate,BMKSearchDelegate,NetAccessDelegate,UISearchBarDelegate>
{
    UIScrollView *firscrollView;
    UIScrollView *secscrollview;
    UIScrollView* scrollview;
    UIPageControl *pageController;
    UIPageControl *pageControllertwo;
    UIPageControl *pagecon;
    NSMutableArray *listarray;
    NSMutableArray *maplistarray;
    BMKSearch *mysearch;
    BMKMapView *myMapView;
    UILabel *buttonbars;
    UIToolbar *toolBar;
    NSMutableArray *arrayone;
     NSMutableArray *arrayonetwo;
    
    NSTimer *timer;
    NSTimer *timer2;
    NSMutableArray *imagearray;
    int Snumber;
    
    UIView *viewss;
    UIView *selectview;
    NSMutableArray *idaray;
    NSMutableArray *picturearray;
}
@property(nonatomic,strong)UIScrollView *firscrollView;
@property(nonatomic,strong)UIScrollView *secscrollview;
@property(nonatomic,strong)UIPageControl *pageController;
@property(nonatomic,strong)UIPageControl *pageControllertwo;
@property(nonatomic,strong) UIToolbar *toolBar;
 
@property(nonatomic,strong) NSMutableArray *maplistarray;
@end
