//
//  AppDelegate.m
//  PageViewController
//
//  Created by fhkvsou on 16/2/18.
//  Copyright © 2016年 fhkvsou. All rights reserved.
//

#import "AppDelegate.h"
#import "PageViewController.h"
#import "PageItem.h"
#import "TestViewViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSMutableArray <PageItem *> * items = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++) {
        PageItem * item = [[PageItem alloc]init];
        
        item.controller = [[TestViewViewController alloc]init];
        
        item.selectColor = [UIColor orangeColor];
        item.normalColor = [UIColor blackColor];
        item.title = @"全球好货";
        
        [items addObject:item];
    }

//    PageItem * item = [[PageItem alloc]init];
//    item.controller = [[TestViewViewController alloc]init];
//    item.controller.view.backgroundColor = [UIColor redColor];
//    item.selectColor = [UIColor orangeColor];
//    item.normalColor = [UIColor blackColor];
//    item.title = @"全球好货";
//    [items addObject:item];
//    
//    PageItem * item2 = [[PageItem alloc]init];
//    item2.controller = [[TestViewViewController alloc]init];
//    item2.controller.view.backgroundColor = [UIColor yellowColor];
//    item2.selectColor = [UIColor orangeColor];
//    item2.normalColor = [UIColor blackColor];
//    item2.title = @"全球好货";
//    [items addObject:item2];
    
    
    PageViewController * pageVc = [[PageViewController alloc]initWithItems:[items copy]];
    pageVc.numberOfVisiableItems = 3.5;
    pageVc.colorOfSignView = [UIColor orangeColor];
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:pageVc];
    
    self.window.rootViewController = nav;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
