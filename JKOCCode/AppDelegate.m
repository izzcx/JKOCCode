//
//  AppDelegate.m
//  JKOCCode
//
//  Created by silence on 2017/2/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ExampleListViewController.h"
#import "TestViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ExampleListViewController *exampleListVC = [[ExampleListViewController alloc] init];
    TestViewController *testVC = [[TestViewController alloc] init];
    UINavigationController *firstNavVC = [[UINavigationController alloc] initWithRootViewController:exampleListVC];
    UINavigationController *secondNavVC = [[UINavigationController alloc] initWithRootViewController:testVC];
    
    UITabBarItem *item0 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    item0.title = @"ui";
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
    item1.title = @"net";
    item1.badgeValue = @"1";
    firstNavVC.tabBarItem = item0;
    secondNavVC.tabBarItem = item1;
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.viewControllers = [NSArray arrayWithObjects:firstNavVC,secondNavVC, nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    
    [self checkCurrentNet];
    
    return YES;
}

- (void)checkCurrentNet{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (BOOL)isNetEnable{
    
    return [AFNetworkReachabilityManager sharedManager].reachable;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
