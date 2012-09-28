//
//  ZZAppDelegate.m
//  ZzPark
//
//  Created by 汪 威 on 12-7-31.
//  Copyright (c) 2012年 wiseflag.com. All rights reserved.
//

#import "ZZAppDelegate.h"

#import "ZZMainController.h"

#import "MobClick.h"

@implementation ZZAppDelegate
{
  BMKMapManager * _outdoorMapManager;
}

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navigationController = _navigationController;

- (void)dealloc
{
  [_window release];
  [_viewController release];
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //显示完Default.png图片进入程序后回复状态栏显示。
  application.statusBarHidden = NO;
  
  //要使用百度地图，先启动BaiduMapManager
  _outdoorMapManager = [[BMKMapManager alloc] init];
  BOOL ret = [_outdoorMapManager start:@"1D6F1D23B4EF447CC3A8441860BCC540F21D522A" generalDelegate:nil];
  if (!ret) {
    NSLog(@"BaiduMapManager start failed!");
  }
  
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  // Override point for customization after application launch.
  
  ZZMainController *mainController = [[[ZZMainController alloc] initWithNibName:@"ZZMainController" bundle:nil] autorelease];
  self.navigationController = [[[UINavigationController alloc] initWithRootViewController:mainController] autorelease];
  
//  self.viewController = [[[ZZMainController alloc] initWithNibName:@"ZZMainController" bundle:nil] autorelease];
  self.window.rootViewController = self.navigationController;
  [self.window makeKeyAndVisible];
  
  [MobClick startWithAppkey:@"50485bb752701545a300000c" reportPolicy:SENDWIFIONLY channelId:@"Dev"];
  return YES;
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
