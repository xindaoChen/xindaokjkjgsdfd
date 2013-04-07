//
//  SearchViewController.h
//  DevelopMent
//
//  Created by xin wang on 3/20/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetAccess.h"
#import "MyCell.h"
@interface SearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NetAccessDelegate,UISearchBarDelegate>
{
     
    NSMutableArray *listarray;
    UITableView *searchtable;
 //   UIActivityIndicatorView *assAiv;
     
    UISearchBar *searchbar ;
    NSMutableDictionary *imageDic;
    NSMutableDictionary *imagesDictionary;
   
}

@property(nonatomic,strong)NSMutableArray *listarray;
@property(nonatomic,strong)UITableView *searchtable;
@property (nonatomic, strong) NetAccess *gNetAccess;
@property (nonatomic, strong) NSString *urlHost;

@end
