//
//  AppDelegate.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#define AccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "AppDelegate.h"
#import "DCChatViewController.h"
#import "DCContactViewController.h"
#import "DCDiscoverViewController.h"
#import "DCMeViewController.h"
#import "DCNavigationController.h"
#import "DCTabBarController.h"
#import "SinaOAuthDate.h"
#import "IWOAuthViewController.h"
@interface AppDelegate ()
@property(strong,nonatomic)DCTabBarController * tabbarController;
@property(strong,nonatomic) SinaOAuthDate * OAuthDate;
@property(strong,nonatomic) IWOAuthViewController * OAuthViewController;

@end

@implementation AppDelegate

- (IWOAuthViewController *)OAuthViewController
{
    
    if (!_OAuthViewController) {
        
        _OAuthViewController = [[IWOAuthViewController alloc]init];
    }
    return _OAuthViewController;
}

-(DCTabBarController *)tabbarController
{
    if (_tabbarController == nil) {
        _tabbarController = [[DCTabBarController alloc]init];
    }
    return _tabbarController;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    if ([SinaOAuthDate loadOAuthDate].access_token) {
    
        self.window.rootViewController = self.tabbarController;
        
    }
    else self.window.rootViewController = self.OAuthViewController;

    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)tabbarControllerAddChildViewWithController:(UIViewController *)controller WithItemTitle:(NSString *)title withImageName:(NSString *)imageName
{
    
    DCNavigationController * navi = [[DCNavigationController alloc]initWithRootViewController:controller];
    
    navi.tabBarItem.title = title;
    
    navi.tabBarItem.image = [UIImage imageNamed:imageName];
    
    [self.tabbarController addChildViewController:navi];
    
    
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
