//
//  DCContactViewController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactViewController.h"
#import "DCContactDate.h"
#import "DCContactViewCell.h"
#import "DCContactGroupDate.h"
#import "DCContactViewDetailViewController.h"

@interface DCContactViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) NSArray * contactDates;

@property(strong,nonatomic) UITableView * tableView;

@property(strong,nonatomic) NSIndexPath * indexPath;

@end

@implementation DCContactViewController


- (void)saveDate
{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.contactDates];
    
    [NSKeyedArchiver archiveRootObject:data toFile:[self documentPathWithDateName:@"ContactGroupDate.data"]];
    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
                
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
    }
    return _tableView;
}


- (NSString *)documentPathWithDateName:(NSString *)name
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:name];
}



- (NSArray *)loadDate
{
    //先取出data文件
    NSData * newdata = [NSKeyedUnarchiver unarchiveObjectWithFile:[self documentPathWithDateName:@"ContactGroupDate.data"]];
    
    //将data反转为数组
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:newdata];
    
    return array;
}

- (NSArray *)loadDictDate
{
    NSBundle * bundle = [NSBundle mainBundle];
    
    NSString * path = [bundle pathForResource:@"ContactDetailDate.plist" ofType:nil];
    
    NSArray * array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray * tarray = [NSMutableArray array];
    
    for (NSDictionary * dict in array) {
        
        DCContactGroupDate * groupDate = [DCContactGroupDate ContactGroupDateWithDict:dict];
        
        [tarray addObject:groupDate];
    }
    
    return tarray;
}


- (NSArray *)contactDates
{
    if (_contactDates == nil) {
//        _contactDates = [self loadDate];
        _contactDates = [self loadDictDate];
        
    }
    
    return _contactDates;
}


- (void)setupNavigationBar
{
    self.navigationItem.title = @"联系人";
    
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
//                              NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
//                              }];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteDate) name:@"deleteBtnClicked" object:nil];
    
    [self.view addSubview:self.tableView];
    
    [self setupNavigationBar];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.contactDates.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    DCContactGroupDate * contactGroupDate = self.contactDates[section];
    
    return contactGroupDate.users.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DCContactGroupDate * contactGroupDate = self.contactDates[indexPath.section];
    
    DCContactDetailDate * contactDetailDate = contactGroupDate.users[indexPath.row];
    
    DCContactViewCell * cell = [DCContactViewCell contactViewCellWithTableView:tableView];

    cell.contactDetailDate = contactDetailDate;
    

    
    return cell;

    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    DCContactGroupDate * contactGroupDate = self.contactDates[section];
    
    return contactGroupDate.group;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tabBarController.tabBar.hidden = YES;

    DCContactViewDetailViewController * detailView = [[DCContactViewDetailViewController alloc]init];
    
    DCContactGroupDate * contactGroupDate = self.contactDates[indexPath.section];
    
    DCContactDetailDate * contactDetailDate = contactGroupDate.users[indexPath.row];
    
    self.indexPath = indexPath;
    
    detailView.contactDetailDate = contactDetailDate;
    
    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden = NO;


}

- (void)deleteDate
{

    DCContactGroupDate * contactGroupDate = self.contactDates[self.indexPath.section];
    
    [contactGroupDate.users removeObjectAtIndex:self.indexPath.row];
    
    [self.tableView reloadData];
    
    
}


@end
