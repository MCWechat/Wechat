//
//  DCTabBarController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCChatViewController.h"
#import "DCContactViewController.h"
#import "DCDiscoverViewController.h"
#import "DCMeViewController.h"
#import "DCNavigationController.h"
#import "DCTabBarController.h"

@interface DCTabBarController ()

@end

@implementation DCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBarController];

    
}

- (void)setupTabBarController
{
    
    DCChatViewController * chatView = [[DCChatViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    DCContactViewController * contactView = [[DCContactViewController alloc]init];
    
    DCDiscoverViewController * discoverView = [[DCDiscoverViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    DCMeViewController * meView = [[DCMeViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    [self tabbarControllerAddChildViewWithController:chatView WithItemTitle:@"Chats" withImageName:@"chats"];
    [self tabbarControllerAddChildViewWithController:contactView WithItemTitle:@"Contacts" withImageName:@"contacts"];
    [self tabbarControllerAddChildViewWithController:discoverView WithItemTitle:@"Discovers" withImageName:@"discover"];
    [self tabbarControllerAddChildViewWithController:meView WithItemTitle:@"Me" withImageName:@"me"];

    
}

- (void)tabbarControllerAddChildViewWithController:(UIViewController *)controller WithItemTitle:(NSString *)title withImageName:(NSString *)imageName
{
    
    DCNavigationController * navi = [[DCNavigationController alloc]initWithRootViewController:controller];
    
    navi.tabBarItem.title = title;
    
    navi.tabBarItem.image = [UIImage imageNamed:imageName];
    
    [self addChildViewController:navi];
    
    
    
    
    
}


@end
