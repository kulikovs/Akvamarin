//
//  AppDelegate.m
//  Akvamarin
//
//  Created by KulikovS on 07.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "IDPActiveRecordKit.h"

#import "AppDelegate.h"
#import "KSStartViewController.h"
#import "KSCoreDataConstants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [IDPCoreDataManager sharedManagerWithMomName:kKSCoreDataModelName];
    
    UIWindow *window = [UIWindow new];
    self.window = window;
    
    KSStartViewController *startViewController = [KSStartViewController new];
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:startViewController];

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
