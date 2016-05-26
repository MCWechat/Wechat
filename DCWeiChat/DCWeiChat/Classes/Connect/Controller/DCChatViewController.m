//
//  DCChatViewController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCChatViewController.h"
#import "DCChatViewAdditonViewController.h"
#import "DCChatViewCell.h"
#import "DCChatViewDetailController.h"
#import "DCContactDate.h"
#import "WYScanVC.h"
#import "DCChatViewScanQRController.h"
#import "DCNavigationController.h"

#define   DocumentPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"contact.data"];



@class DCContactDate;

@interface DCChatViewController ()<UITableViewDelegate,UIScrollViewDelegate,DCChatViewDetailDelegate,UISearchBarDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate,DCChatViewAdditonViewDelegate>

@property(assign,nonatomic) BOOL RightBarButtonItemClicked;

@property(strong,nonatomic)DCChatViewAdditonViewController * chatViewAdditonView;

@property(weak,nonatomic)UISearchBar * searchBar;

@property(strong,nonatomic)NSArray * contactDate;

@property(assign,nonatomic)CGFloat tableViewContentOffSetY;

@property(strong,nonatomic) NSIndexPath * indexPath;

@property (nonatomic, strong) UISearchController *searchController;

@property (strong,nonatomic) UITableViewController *searchResultsController;


@property(strong,nonatomic) NSMutableArray * resultDate;

@property(strong,nonatomic) NSString* urlString;



@end

@implementation DCChatViewController

//-(void)loadTableView{
//    self.tableView.tableFooterView=[[UIView alloc]init];
//}
-(void)LoadSearchController{
    
    self.searchResultsController=[[UITableViewController alloc]init];//这个控制器可以自己定义
    self.searchResultsController.edgesForExtendedLayout=UIRectEdgeNone;
    self.searchResultsController.tableView.tableFooterView=[[UIView alloc]init];
    self.searchResultsController.tableView.delegate=self;
    self.searchResultsController.tableView.dataSource=self;
    
    self.searchController=[[UISearchController alloc]initWithSearchResultsController:self.searchResultsController];
    
    self.searchController.searchResultsUpdater=self;
    self.searchController.searchBar.frame=CGRectMake(0, 0, self.view.bounds.size.width, 44);
    self.searchController.searchBar.delegate=self;
    self.tableView.tableHeaderView=self.searchController.searchBar;
}



- (void)setUrlString:(NSString *)urlString
{

    _urlString = urlString;
    
    if (_urlString !=nil) {
        
        DCChatViewScanQRController * scanController = [[DCChatViewScanQRController alloc]init];
        
        DCNavigationController * navigationController = [[DCNavigationController alloc]initWithRootViewController:scanController];
        
        scanController.urlString = self.urlString;
        
        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
        
    }
    
    
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    NSString *filterString = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filterString];
    
    NSMutableArray * tarray = [NSMutableArray array];
    
    for (DCContactDate * date in self.contactDate) {
        
        [tarray addObject:date.name];
    }
    
    NSArray * carray = [NSMutableArray arrayWithArray:[tarray filteredArrayUsingPredicate:predicate]];
    
    NSMutableArray * tempArray = [NSMutableArray array];

    if(carray.count != 0){
        

    for (NSString * name in carray) {
        
        for (DCContactDate *date in self.contactDate) {
            
            if ([date.name isEqualToString:name]) {
                
                [tempArray addObject:date];
            }
            
            self.resultDate = tempArray;
        }
    }
        
    }
    [self.searchResultsController.tableView reloadData];

}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [self.tabBarController.tabBar setHidden:NO];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{

    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    return YES;
}

- (NSString *)documentPathWithDateName:(NSString *)name
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:name];
}


- (void)saveDate
{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.contactDate];
    
    [NSKeyedArchiver archiveRootObject:data toFile:[self documentPathWithDateName:@"cc.data"]];

}


- (NSArray *)createDate
{

        NSBundle * bundle = [NSBundle mainBundle];

        NSString * path = [bundle pathForResource:@"MessageDate.plist" ofType:nil];

        NSArray * array = [NSArray arrayWithContentsOfFile:path];

        NSMutableArray * tarray = [NSMutableArray array];

        for (NSDictionary * dict in array) {

            DCContactDate * contact = [[DCContactDate alloc]initWithDict:dict];

            [tarray addObject:contact];
        }
    
    return tarray;
    

}




- (NSArray *)loadDate
{
    //先取出data文件
    NSData * newdata = [NSKeyedUnarchiver unarchiveObjectWithFile:[self documentPathWithDateName:@"cc.data"]];
    
    //将data反转为数组
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:newdata];

    return array;
}




-(NSArray *)contactDate
{
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];

        if (!_contactDate) {
            
            _contactDate = [self createDate];

        }
        
    }
    
    else if(!_contactDate)
    {
        
        _contactDate = [self loadDate];


    }

    return _contactDate;
}


-(UITableViewController *)chatViewAdditonView
{
    
    return _chatViewAdditonView;
}

- (void)clickRightBarButtonItem
{
    
    if (!self.chatViewAdditonView) {
        self.chatViewAdditonView = [[DCChatViewAdditonViewController alloc]init];
        
        self.chatViewAdditonView.delegate = self;
        
        self.chatViewAdditonView.tableView.frame = CGRectMake(self.view.frame.size.width/2 -5, self.navigationController.navigationBar.frame.size.height - 34 + self.tableViewContentOffSetY, self.view.frame.size.width/2, self.view.frame.size.width/2 - 34);
                
        self.chatViewAdditonView.tableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
        
        [self.tableView addSubview:_chatViewAdditonView.view];
    }

    else
    {
        
        [self.chatViewAdditonView.view removeFromSuperview];
        self.chatViewAdditonView = nil;
        
    }
    
//    self.RightBarButtonItemClicked = !self.RightBarButtonItemClicked;
}

- (void)setupNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickRightBarButtonItem)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.title = [NSString stringWithFormat:@"微信"];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView==self.searchResultsController.tableView) {
        
        return self.resultDate.count;
    }else{
        
        return self.contactDate.count;
    }
}


//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DCChatViewCell * cell = [DCChatViewCell chatViewCellWithTableView:tableView];
    
    if (tableView == self.searchResultsController.tableView) {
        
        cell.date = self.resultDate[indexPath.row];
        
    }
    else cell.date = self.contactDate[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    
    self.tabBarController.tabBar.hidden = YES;
    
    DCChatViewDetailController * cvdc = [[DCChatViewDetailController alloc]init];
    
    cvdc.delegate = self;
    
    DCContactDate * ctd =self.contactDate[indexPath.row];
    
    cvdc.messageDate = ctd.messageDate;
    
    cvdc.messageBlock = ^(NSMutableArray * messageDate)
    {
        
        ctd.messageDate = messageDate;
        
        [self.tableView reloadData];

        
    };

    [self.navigationController pushViewController:cvdc animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    self.tableViewContentOffSetY = scrollView.contentOffset.y + 64;
    
    [self.chatViewAdditonView.view removeFromSuperview];
    self.chatViewAdditonView = nil;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    [self setupNavigationBar];
    self.tabBarController.tabBar.hidden= NO;
    [self LoadSearchController];
//    [self loadTableView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden= NO;
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

}

-(void)chatViewDetailController:(DCChatViewDetailController *)controller messageDate:(NSMutableArray *)messageDate
{
    
//    DCContactDate * contactDate = self.contactDate[self.indexPath.row];
    
//    [contactDate.messageDate addObject:messageDate];
    
    
}


-(void)scanQRBtnClickWithController:(DCChatViewAdditonViewController *)controller
{
    

    WYScanVC * vc = [[WYScanVC alloc]init];
    
    
    vc.urlblock = ^(NSString * url)
    {
        self.urlString = url;
        
    };
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
     
    

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self saveDate];
    
    NSLog(@"save");
    
}


@end
