//
//  DCChatViewSearchResultController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/29.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCChatViewSearchResultController.h"
#import "DCChatViewController.h"
#import "DCChatViewCell.h"


@interface DCChatViewSearchResultController ()


@end

@implementation DCChatViewSearchResultController


- (NSArray *)date
{
    
    if (!_date) {
        
        _date = [NSArray array];
    }
    return _date;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setNeedsDisplay];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.date.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DCChatViewCell * cell = [DCChatViewCell chatViewCellWithTableView:tableView];
    
    cell.date = self.date[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}





@end
