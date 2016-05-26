//
//  DCChatViewAdditonViewController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCChatViewAdditonViewController.h"
#import "DCChatViewAdditonViewCell.h"
@class DCChatViewAdditonViewCell;

@interface DCChatViewAdditonViewController ()<UITableViewDelegate>

@end

@implementation DCChatViewAdditonViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.backgroundColor = [UIColor blueColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DCChatViewAdditonViewCell * cell = [DCChatViewAdditonViewCell additonViewCellWithTableView:tableView];
    
    
    if (indexPath.row == 0) {
        
        cell.textView.text = @"Group Chat";
        cell.iconView.image = [UIImage imageNamed:@"chats"];
        
    }
    else if (indexPath.row == 1)
    {
        cell.textView.text = @"Add Contacts";
        cell.iconView.image = [UIImage imageNamed:@"discover"];
        
    }
    else if (indexPath.row == 2)
    {
        cell.textView.text = @"Scan QR Code";
        cell.iconView.image = [UIImage imageNamed:@"me"];
        
    }
    else
    {
        cell.textView.text = @"Receive Money";
        cell.iconView.image = [UIImage imageNamed:@"contacts"];
        
    }
    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 2) {
        
        if ([self.delegate respondsToSelector:@selector(scanQRBtnClickWithController:)]) {
            
            [self.delegate scanQRBtnClickWithController:self];            
        }
        
    }
    
}


@end
