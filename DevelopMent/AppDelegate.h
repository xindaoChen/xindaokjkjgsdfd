//
//  AppDelegate.h
//  DevelopMent
//
//  Created by xin wang on 3/20/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import <CoreData/CoreData.h>
#import "BMKMapManager.h"
#import "DiscussViewController.h"
#import "ClassViewController.h"
#import "FirstViewController.h"
#import "NetAccess.h"

@class XDTabBarViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *language;
    UINavigationController *naviga2;
    UINavigationController *naviga3;
    BMKMapManager *mapmange;
    ClassViewController *classview;
    DiscussViewController *disview;
    XDTabBarViewController *xdTabbar;
    FirstViewController* firstview;
    NetAccess *deviceTokenAccess;
    int pushAccount;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) BMKMapManager* mapManager;
@property (nonatomic,strong) NSString *language;
@property (nonatomic,strong)  UINavigationController *naviga2;
@property (nonatomic,strong)  UINavigationController *naviga3;
@property (nonatomic,strong)  ClassViewController *classview;
@property (nonatomic,strong) DiscussViewController *disview;
@property (nonatomic,strong) FirstViewController* firstview;
@property (nonatomic,strong) XDTabBarViewController *xdTabbar;
@property (nonatomic, strong) NSString *domainName;
@property (nonatomic, strong) NSString *version;
@property (nonatomic ,strong) NetAccess *deviceTokenAccess;

@property (nonatomic, strong) NSString *applink;
@property (nonatomic, strong) NSString *compsite;
//数据模型对象
@property(strong,nonatomic) NSManagedObjectModel *managedObjectModel;
//上下文对象
@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;
//持久性存储区
@property(strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//初始化Core Data使用的数据库
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

//managedObjectModel的初始化赋值函数
-(NSManagedObjectModel *)managedObjectModel;

//managedObjectContext的初始化赋值函数
-(NSManagedObjectContext *)managedObjectContext;

//+ (AppDelegate *)sharedDelegate;

@end
