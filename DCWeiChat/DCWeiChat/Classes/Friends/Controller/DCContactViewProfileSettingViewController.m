//
//  DCContactViewProfileSettingViewController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/20.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactViewProfileSettingViewController.h"

@interface DCContactViewProfileSettingViewController ()<UIActionSheetDelegate>


@end

@implementation DCContactViewProfileSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-5, 0, 0, 0);

    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 1 || section == 2) {
        
        return 1;
    }
    
    else return 2;
    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4)
        return 50;
    return 0.1;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cc";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    }
    
    if (indexPath.section == 2 || indexPath.section == 3 || (indexPath.section == 4 && indexPath.row ==0)) {
        
        UISwitch * switchBtn = [[UISwitch alloc]init];
        
        cell.accessoryView = switchBtn;
        
        if (indexPath.section == 2 && indexPath.row == 0 ) {
            
            cell.textLabel.text = @"Favorite";
            
        }
        if (indexPath.section == 3 ) {
            
            if (indexPath.row ==0) {
                
                cell.textLabel.text = @"Don`t Share My Moments";
                
            }
            else cell.textLabel.text = @"Hide Her Moments";
            
        }
        if (indexPath.section == 4) {
            
            cell.textLabel.text = @"Block";
            
        }
        
        return cell;

    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = @"Set Remarks and Tags";
    }
    if (indexPath.section == 1) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"Share Her name Card"];
    }
    
    if (indexPath.section == 4) {
        cell.textLabel.text = @"Report";

    }
    
    return cell;

}


- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        
        
        UIView * view =  [self createFootView];
        
        return view;
        
    }
    
    return nil;
    
}
- (UIView *)createFootView
{
    UIView * view = [[UIView alloc]init];
    view.frame =  CGRectMake(0, 0, self.view.frame.size.width, 50);

    
    CGFloat btnW = 300;
    
    CGFloat btnH = 40;
    
    CGFloat padding = (self.view.frame.size.width - btnW)/2;
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    
    [deleteBtn setBackgroundColor:[UIColor colorWithRed:0.8 green:0 blue:0 alpha:1]];
    
    deleteBtn.frame = CGRectMake(padding, 10, btnW, btnH);
    
    [view addSubview:deleteBtn];
    
    
    return view;
}




- (void)deleteBtnClicked
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"确定删除？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"deleteBtnClicked" object:self];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    
    
    

    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
