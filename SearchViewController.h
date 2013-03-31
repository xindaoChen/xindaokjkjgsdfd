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
    UITextField *searchfield;
    NSMutableArray *listarray;
    UITableView *searchtable;
    UIActivityIndicatorView *assAiv;
    NSMutableArray *imagearray;
   
}
@property(nonatomic,strong)UITextField *searchfield;
@property(nonatomic,strong)NSMutableArray *listarray;
@property(nonatomic,strong)UITableView *searchtable;
@property(nonatomic,strong)UIActivityIndicatorView *assAiv;
@end
