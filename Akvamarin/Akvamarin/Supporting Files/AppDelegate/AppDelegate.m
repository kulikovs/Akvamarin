//
//  AppDelegate.m
//  Akvamarin
//
//  Created by KulikovS on 07.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "AppDelegate.h"
#import "KSCalendarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [UIWindow new];
    self.window = window;
    
    KSCalendarViewController *calendarViewController = [KSCalendarViewController new];
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:calendarViewController];

    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
