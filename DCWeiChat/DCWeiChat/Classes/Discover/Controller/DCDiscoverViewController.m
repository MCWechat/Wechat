//
//  DCDiscoverViewController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCDiscoverViewController.h"
#import "DCDiscoverViewFriendCircleController.h"

@interface DCDiscoverViewController ()

@end

@implementation DCDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self.tabBarController.tabBar setHidden:NO];

}

- (void)setupNavigationBar
{
    self.navigationItem.title = @"发现";

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1 || section == 2) {
        
        return 2;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cc";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = @"Moments";
        cell.imageView.image = [UIImage imageNamed:@"btn1"];
        
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            cell.textLabel.text = @"Scan QR Code";
            cell.imageView.image = [UIImage imageNamed:@"btn2"];
            

        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"Shake";
            cell.imageView.image = [UIImage imageNamed:@"chats"];}

    }
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"People Nearby";
            cell.imageView.image = [UIImage imageNamed:@"discover"];
            
            return cell;
        }
        else
        {
            cell.textLabel.text = @"Drift Bottle";
            cell.imageView.image = [UIImage imageNamed:@"me"];}

    }
    if (indexPath.section == 3)
    {
        cell.textLabel.text = @"Games";
        cell.imageView.image = [UIImage imageNamed:@"btn1"];
    }
    
    return cell;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        DCDiscoverViewFriendCircleController * friendCircleController = [[DCDiscoverViewFriendCircleController alloc]init];
        
        [self.navigationController pushViewController:friendCircleController animated:YES];
        
        [self.tabBarController.tabBar setHidden:YES];

        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    self.tabBarController.tabBar.hidden= NO;

}


@end
