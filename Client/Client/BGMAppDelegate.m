//
//  BGMAppDelegate.m
//  Client
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import "BGMAppDelegate.h"

@implementation BGMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"orangeNavigationBAr"] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.227 green:0.106 blue:0.004 alpha:1.0], UITextAttributeTextColor, UIOffsetMake(0.0, 0.0), UITextAttributeTextShadowOffset, nil];
    NSDictionary *textDisabledTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.227 green:0.106 blue:0.004 alpha:0.2], UITextAttributeTextColor, UIOffsetMake(0.0, 0.0), UITextAttributeTextShadowOffset, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    
    //[[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:1.0 green:0.765 blue:0.118 alpha:1.0]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textDisabledTitleOptions forState:UIControlStateDisabled];
    
    UIImage *backButton = [[UIImage imageNamed:@"backButton"]  resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *barButtonItem = [[UIImage imageNamed:@"barButtonItem"]  resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonItem forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
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
