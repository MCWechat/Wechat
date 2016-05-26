//
//  DCNavigationContriller.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCNavigationController.h"

@interface DCNavigationController ()

@end

@implementation DCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                              NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                              }];
    
    [self.navigationBar setBarTintColor:[UIColor blackColor]];
    

}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    [super pushViewController:viewController animated:YES];
    

    
}


@end
