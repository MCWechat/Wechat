//
//  DCContactViewAddViewController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/20.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactViewAddViewController.h"

@interface DCContactViewAddViewController ()

@end

@implementation DCContactViewAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cc";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}
@end
