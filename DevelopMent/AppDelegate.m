//
//  AppDelegate.m
//  DevelopMent
//
//  Created by xin wang on 3/20/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import "AppDelegate.h"
#import "XDTabBarViewController.h"
#import "XDHeader.h"
#import "NetAccess.h"


#import "JSON.h" 
#import "JSONKit.h"
@implementation AppDelegate
@synthesize language;
@synthesize mapManager,classview,disview,firstview;
@synthesize managedObjectContext,managedObjectModel,persistentStoreCoordinator,naviga2,naviga3,deviceTokenAccess;
@synthesize xdTabbar;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:KEY_FOR_HOST_URL] != nil) {
        _domainName  =  [defaults objectForKey:KEY_FOR_HOST_URL];
        _version = [defaults objectForKey:KEY_FOR_VERSION];
    }else{
        [defaults setValue:HOST_URL forKey:KEY_FOR_HOST_URL];
        [defaults setValue:INIT_VERSION forKey:KEY_FOR_VERSION];
        _domainName  = HOST_URL;
        _version = INIT_VERSION;
    }
    NSLog(@"%@",_version);
    NSLog(@"%@",_domainName);
   [defaults synchronize];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     firstview = [[FirstViewController alloc] init];
    UINavigationController *naviga1 = [[UINavigationController alloc] initWithRootViewController:firstview];
    naviga1.tabBarItem.image = [UIImage imageNamed:@"homepage"];
 
    classview = [[ClassViewController alloc] init];
    naviga2 = [[UINavigationController alloc] initWithRootViewController:classview];
    naviga2.tabBarItem.image = [UIImage imageNamed:@"class"];
    
    disview = [[DiscussViewController alloc] init ];
    naviga3 = [[UINavigationController alloc] initWithRootViewController:disview];
    naviga3.tabBarItem.image = [UIImage imageNamed:@"about"];
    NSArray *array = [NSArray arrayWithObjects:naviga1,naviga2,naviga3, nil];
    
    XDTabBarViewController *tabbar=[[XDTabBarViewController alloc] init];
    tabbar.viewControllers=array;
    tabbar.delegate=(id)self;
    self.xdTabbar = tabbar;
    self.window.rootViewController = tabbar;
    pushAccount = 0;
    NSUserDefaults *faflult = [NSUserDefaults standardUserDefaults];
    language = [faflult objectForKey:@"lange"];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [mapManager start:@"77D26CBA93676420DF337777AC65CF762264B858"
                 generalDelegate:nil];
    if (ret) {
         
    }
    [self.window makeKeyAndVisible];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    
    
   
        
    
    return YES;
}



// Delegation methods
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSLog(@"regisger success： desc:%@", [devToken description]);
    NSDictionary *bundleDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [bundleDictionary objectForKey:@"CFBundleDisplayName"];
    
    NSString *deviceToken = [[[[devToken description]
                               stringByReplacingOccurrencesOfString:@"<" withString:@""]
                              stringByReplacingOccurrencesOfString:@">" withString:@""]
                             stringByReplacingOccurrencesOfString:@" " withString:@""];
  
    
    if ([deviceToken length] > 30 && pushAccount == 0) {
        pushAccount++;
        NSString *params = [NSString stringWithFormat:@"{\"appname\":\"%@\",\"devicetoken\":\"%@\"}",appName,deviceToken];
        NetAccess *netAccess = [[NetAccess alloc] init];
        self.deviceTokenAccess = netAccess;
        [self.deviceTokenAccess postDevicetoken:params];
    }
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}


+ (AppDelegate *)sharedDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return managedObjectModel;
}


- (void)netAccess:(NetAccess *)netAccess RequestFailed:(NSMutableArray *)resultSet
{
    
}

- (void)netAccess:(NetAccess *)na RequestFinished:(NSMutableArray *)resultSet
{
    NSLog(@"Post Device Token netAcess:%@", resultSet);
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    //得到数据库的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //CoreData是建立在SQLite之上的，数据库名称需与Xcdatamodel文件同名
    NSURL *storeUrl = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"CDJournal.sqlite"]];

    
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
    						 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
    						 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
        // Handle error
    }
    
    return persistentStoreCoordinator;
}

-(NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator =[self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc]init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return managedObjectContext;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
