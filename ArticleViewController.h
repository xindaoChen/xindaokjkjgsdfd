//
//  ArticleViewController.h
//  DevelopMent
//
//  Created by xin wang on 3/20/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "NetAccess.h"
@interface ArticleViewController : UIViewController<UIWebViewDelegate,BMKMapViewDelegate,BMKSearchDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,NetAccessDelegate>
{
     
    UITableView *APPview;
    NSURL *myurl;
    UITableView *dataview;
    UIButton *rightbutton;
    UIButton*leftbutton;
    UIScrollView *firscrollView;
    UIActivityIndicatorView *assAiv;
    BMKMapView *myMapView;
    BMKSearch *mysearch;
    BMKPointAnnotation* myAnnotation;
 
    NSString*idstring;
    NSMutableArray *dataarray;
    NSMutableArray *introducearray;
    NSMutableArray *introducearrytwo;          //简介缓存
    int sum;
     CLLocationCoordinate2D locationgs;
    NSString *namestring;
    UIWebView *webview ;
    NSMutableArray *apparray;
}
 
@property(nonatomic,strong) NSURL *myurl;
@property(nonatomic,strong) BMKMapView *myMapView;
@property(nonatomic,strong) BMKSearch *mysearch;
@property(nonatomic,strong) BMKPointAnnotation* myAnnotation;
@property(nonatomic,strong) UITableView *dataview;
@property(nonatomic,strong) UITableView *APPview;
@property(nonatomic,strong)  NSString*idstring;


- (id)initWithurl:(NSDictionary *)array;
@end
