//
//  DCContactViewDetailViewController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/20.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactViewDetailViewController.h"
#import "DCContactViewDetailViewFirstCell.h"
#import "DCContactViewDetailViewSecondCell.h"
#import "DCContactViewDetailViewThirdCell.h"
#import "DCContactViewProfileSettingViewController.h"


@interface DCContactViewDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) UITableView * tableView;

@end

@implementation DCContactViewDetailViewController


-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _tableView.contentInset = UIEdgeInsetsMake(-5, 0, 0, 0);
        
        _tableView.dataSource = self;
        
        _tableView.delegate = self;
        
    }
    
    return _tableView;
}

- (void)setupNavigationBar
{
    self.navigationItem.title = @"Profile";
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                              NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                              }];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(profileDetail)];

    
}

- (void)profileDetail
{
    DCContactViewProfileSettingViewController * settingControl = [[DCContactViewProfileSettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:settingControl animated:YES];
    
    
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNavigationBar];
//    self.navigationController.navigationBar
    
    [self.view addSubview:self.tableView];


}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
        
    }
    
    else if (section == 1)
    {
        return 1;
    }
    
    else
        return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
        
        DCContactViewDetailViewFirstCell * cell = [DCContactViewDetailViewFirstCell cellWithTableView:tableView];
        
        cell.icon.image = [UIImage imageNamed:self.contactDetailDate.icon];
        
        cell.name.text = self.contactDetailDate.name;
        
        cell.idname.text = self.contactDetailDate.idname;
        
        return cell;
        
}
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        DCContactViewDetailViewSecondCell * cell = [DCContactViewDetailViewSecondCell cellWithTableView:tableView];
        
        cell.textView.text = self.contactDetailDate.region;
        
        
        return cell;
    }
    
    else if (indexPath.row == 1)
    {
        
        DCContactViewDetailViewThirdCell * cell = [DCContactViewDetailViewThirdCell cellWithTableView:tableView];
        
        return cell;
    }
    
    
    
    if (indexPath.section == 1) {
        
        static NSString *ID = @"cc";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
        cell.textLabel.text = @"Set Remark and Tag";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;

    }
    
    static NSString *ID = @"cc";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.textLabel.text = @"More";
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return cell;

    

}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || (indexPath.section == 2 && indexPath.row == 1)) {
        
        return 80;
        
        
    }
    
    return 44;
}


- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        

       UIView * view =  [self createFootView];
        
        return view;
        
    }
    
    return nil;

}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2)
        return 100;
    return 0.1;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)createFootView
{
    UIView * view = [[UIView alloc]init];
    
    CGFloat btnW = 300;
    
    CGFloat btnH = 40;
    
    CGFloat padding = (self.view.frame.size.width - btnW)/2;
    
    UIButton * msgBrn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [msgBrn setTitle:@"Messages" forState:UIControlStateNormal];
    
    [msgBrn setBackgroundColor:[UIColor colorWithRed:0 green:0.65 blue:0 alpha:1]];
    
    msgBrn.frame = CGRectMake(padding, 10, btnW, btnH);
    
    
    view.frame =  CGRectMake(0, 0, self.view.frame.size.width, 100);
    
    UIButton * callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [callBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [callBtn setTitle:@"Free Call" forState:UIControlStateNormal];
    
    [callBtn setBackgroundColor:[UIColor whiteColor]];
    
    callBtn.frame = CGRectMake(padding, CGRectGetMaxY(msgBrn.frame) + 10, btnW, btnH);
    
    [view addSubview:msgBrn];
    [view addSubview:callBtn];
    
    return view;
}



@end
