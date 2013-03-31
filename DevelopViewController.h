//
//  DevelopViewController.h
//  DevelopMent
//
//  Created by xin wang on 3/20/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface DevelopViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *devetableview;
    UITableView *hideview1;       //区域省
    UITableView *hideview2;        //区域市
    UITableView *hideview3;        //级别
    UITableView *hideview4;        //行业
    UIView *backview;
    NSMutableArray *cityarrray;
    
    NSMutableArray *arraylist;    //列表数据
    NSArray *array1;
    NSArray *array2;
    int number;
    int number2;
    NSString* buttontag;
}
@property(nonatomic,strong)UITableView *devetableview;
@property(nonatomic,strong) UITableView *hideview1;
@property(nonatomic,strong) UITableView *hideview2;
@property(nonatomic,strong)UIView *backview;
@property(nonatomic,strong)NSMutableArray *arrayone;
@property(nonatomic,strong)NSMutableArray *cityarrray;

-(id)initWithnumber:( NSInteger )stringnum;
@end
