//
//  ScanDevelopViewController.h
//  DevelopMent
//
//  Created by xindaoapp on 13-3-26.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "NetAccess.h"

@interface ScanDevelopViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NetAccessDelegate,PullTableViewDelegate>
{
    UITextField *searchfield;
    NSMutableArray *listarray;
    NSMutableArray *listarray2;
    NSMutableArray *listarray3;
    NSMutableArray *listarray4;
    NSMutableArray *listarray5;
    NSMutableArray *allListArray;

    
    //UITableView *searchtable;
    PullTableView *searchtable;
    UIView *showCityView;
    UIView *showLevelView;
    UIView *showIndustryView;
    UIActivityIndicatorView *assAiv;
    
    NSString *provinceName;
    NSString *tempprovinceName;
    NSString *levelName;
    NSString *industryName;
    NSString *contectFlag;
     NSString *leid;
    NSString *inid;
    NSString *cid;
    
    NSMutableArray *allProvinceArray;
    int num;
    int flagForInit;
    int  developnumhasget;
    int pagenum;
 
    
    UIButton *industrybutton;
    UIButton *levelbutton;
    UIButton *provincebutton;
    
    UITableView *provinceView;
    UITableView *cityView;
    UITableView *levelView ;
    UITableView *IndustryView;
    
    NSString *getDevelopZoneInfo;
   NSString *getCityName;
    
}
@property(nonatomic,strong)UITextField *searchfield;
@property(nonatomic,strong)NSMutableArray *listarray;
@property(nonatomic,strong)NSMutableArray *listarray2;
@property(nonatomic,strong)NSMutableArray *listarray3;
@property(nonatomic,strong)NSMutableArray *listarray4;
@property(nonatomic,strong)NSMutableArray *listarray5;
@property(nonatomic,strong)UITableView *searchtable;
@property(nonatomic,strong)PullTableView *searchtable;
//@property(nonatomic,strong)UIActivityIndicatorView *assAiv;
@property(nonatomic,strong)UIView *showCityView;
@property(nonatomic,strong)UIView *showLevelView;
@property(nonatomic,strong)UIView *showIndustryView;
@property (nonatomic,strong) NSMutableArray *allProvinceArray;
@property(nonatomic,strong) NSArray *allLevelArray;
@property(nonatomic,strong) NSArray *allIndustryArray;
@property(nonatomic,strong) UITableView *provinceView;
@property(nonatomic,strong) UITableView *cityView;
@property(nonatomic,strong) UITableView *levelView;
@property(nonatomic,strong) UITableView *IndustryView;
@property(nonatomic,strong) NSString *getDevelopZoneInfo;
@property(atomic,strong) NSString *inid;
@property(atomic,strong) NSString *leid;
@property(atomic,strong) NSString *cid;
@property(nonatomic,strong) NSString *getCityName;

-(id)initWithnumber:( NSInteger )stringnum;
-(id)initwithclassId:(NSString *)classid stringnum:(NSInteger)stringnum;
-(id)initwithcityname:(NSString *)name;

@end


