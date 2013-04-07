//
//  ScanDevelopViewController.h
//  DevelopMent
//
//  Created by xindaoapp on 13-3-26.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "NetAccess.h"
#import "HLDeferredList.h"

@interface ScanDevelopViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NetAccessDelegate>
{
    UITextField *searchfield;
    NSMutableArray *listarray;
    NSMutableArray *listarray2;
    NSMutableArray *listarray3;
    NSMutableArray *listarray4;
    NSMutableArray *listarray5;
    NSMutableArray *allListArray;
    NSMutableDictionary *imagesDictionary;

    
    UITableView *searchtable;

    UIView *showCityView;
    UIView *showLevelView;
    UIView *showIndustryView;
 //   UIActivityIndicatorView *assAiv;
    UIActivityIndicatorView  *footactive;
    UIImageView *moveImageView;
    UIImageView *moveImageView2;
    UIImageView *moveImageView3;
    
    NSString *provinceName;
    NSString *tempprovinceName;
    NSString *levelName;
    NSString *industryName;
    NSString *contectFlag;
     NSString *leid;
    NSString *inid;
    NSString *cid;
    
    NSMutableArray *allProvinceArray;
    NSMutableArray *allProvinceArrayEnglish;
    NSMutableArray *allProvinceArrayChina;
    int num;
    int flagForInit;
    int  developnumhasget;
    int pagenum;
    int  catchflag;
    
    UIButton *industrybutton;
    UIButton *levelbutton;
    UIButton *provincebutton;
    
    UITableView *provinceView;
    UITableView *cityView;
    UITableView *levelView ;
    UITableView *IndustryView;
    
    NSString *getDevelopZoneInfo;
   NSString *getCityName;
    NSString *languageFlag;
    int  netAcessTimeFlag;
    
    
    int provinceButonStatue;   //记录每个按钮的状态互斥  选中-1，
    int levelButonStatue;
    int industryButonStatue;
    
    UILabel *provinceLabel;
    UILabel *levelLabel;
    UILabel *industryLabel;
    
    
    
}
@property(nonatomic,strong)UITextField *searchfield;
@property(nonatomic,strong)NSMutableArray *listarray;
@property(nonatomic,strong)NSMutableArray *listarray2;
@property(nonatomic,strong)NSMutableArray *listarray3;
@property(nonatomic,strong)NSMutableArray *listarray4;
@property(nonatomic,strong)NSMutableArray *listarray5;


@property(nonatomic,strong)UITableView *searchtable;
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
@property(nonatomic,strong) NSString *provinceName;
@property(nonatomic,strong) NSString *tempprovinceName;

@property (nonatomic, strong) NetAccess *gNetAccess;
@property (nonatomic,strong) NetAccess *cityNetAccess;
@property (nonatomic,strong) NetAccess *levelNetAcess;
@property (nonatomic,strong) NetAccess *industryNetAcess;
@property(nonatomic,strong)  HLDeferred *developDeferred;
@property(nonatomic,strong)  HLDeferred *cityDeferred;
@property(nonatomic,strong)  HLDeferred *levelDeferred;
@property(nonatomic,strong)  HLDeferred *industryDeferred;
@property(nonatomic,strong)  HLDeferredList *deferredList;

-(id)initWithnumber:( NSInteger )stringnum;
-(id)initWithclassId:(NSString *)classid stringnum:(NSInteger)stringnum;
-(id)initWithcityname:(NSString *)name andprovince:(NSString *)provincestring;

@end


