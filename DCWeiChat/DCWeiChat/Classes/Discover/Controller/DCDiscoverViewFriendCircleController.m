//
//  DCDiscoverViewFriendCircleController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/21.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCDiscoverViewFriendCircleController.h"
#import "DCFriendCircleCell.h"
#import "DCFriendCircleDate.h"
#import "DCFriendCircleDateFrame.h"
#import "SinaOAuthDate.h"
#import "AFNetworking.h"
#import "DCStatuses.h"
#import "DCUsers.h"
#import "DCStatusesCache.h"
#import "DCDiscoverViewSendTextController.h"
#import "DCNavigationController.h"
#import "DCComments.h"

@interface DCDiscoverViewFriendCircleController () <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,DCDiscoverViewSenTextDelegate,UIScrollViewDelegate>

@property(strong,nonatomic) UITableView * tableView;

@property(weak,nonatomic) UIButton * backGroundImage;

@property(strong,nonatomic) UIView * headerView;

@property(strong,nonatomic) NSMutableArray * date;

@property(strong,nonatomic) NSMutableArray * cellDate;

@property(strong,nonatomic) NSMutableArray * commentsDate;


@end


@implementation DCDiscoverViewFriendCircleController


-(NSMutableArray *)commentsDate
{
    if (!_commentsDate) {
        
        _commentsDate = [NSMutableArray array];
    }
    return _commentsDate;
}


- (NSMutableArray *)cellDate
{
    if (_cellDate == nil) {
        
        _cellDate = [NSMutableArray array];
    }
    return _cellDate;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    
}

-(NSMutableArray *)date
{
    if (!_date) {
        _date = [NSMutableArray array];
    }
    return _date;
}

- (void)loadCacheDate
{
    NSArray * array = [DCStatusesCache loadCache];
    
    NSMutableArray * tarray = [NSMutableArray array];
    
    for (DCStatuses* statuses in array) {
        
        DCFriendCircleDateFrame * dateFrame = [[DCFriendCircleDateFrame alloc]init];
        
        dateFrame.statuses = statuses;
        
        [tarray addObject:dateFrame];
    }
    
    self.date = tarray;
    
}

- (void)loadNewDate
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary] ;
    
    NSString * access_token = [SinaOAuthDate loadOAuthDate].access_token;
    
    params[@"access_token"] = access_token;
    params[@"count"] = @5;
    
    if (self.date.count) {
        
        DCFriendCircleDateFrame * date = [self.date firstObject];
        
        params[@"since_id"] = date.statuses.idstr;
    }
    
    
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            NSArray * array = responseObject[@"statuses"];
        
            //每条微博的临时数组
            NSMutableArray * tarray = [NSMutableArray array];

            
            for (NSDictionary* dict in array) {
                
                DCStatuses * statuses = [DCStatuses statusesWithDict:dict];
                
//                NSMutableDictionary * newParam = [NSMutableDictionary dictionary];
//                
//                newParam[@"access_token"] = access_token;
//                
//                newParam[@"id"] = statuses.idstr;
                
                [DCStatusesCache addCacheWithStatuses:statuses];
                
                DCFriendCircleDateFrame * dateFrame = [[DCFriendCircleDateFrame alloc]init];
                
                dateFrame.statuses = statuses;
                
                [tarray addObject:dateFrame];
            }
        
        
        
        NSMutableArray * narray = [NSMutableArray array];
        
        [narray addObjectsFromArray:tarray];
        [narray addObjectsFromArray:self.date];
        
        self.date = narray;
        
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"loadDateFailed");
        
    }];
    

    
    



    
}

- (void)loadStatuses
{
    if ([DCStatusesCache loadCache].count == 0) {
    
        [self loadNewDate];
    }
    else [self loadCacheDate];
    
}


- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), self.view.frame.size.height + 44)  style:UITableViewStyleGrouped];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (UIView *)headerView
{
    if (_headerView == nil ) {
        
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height)/2 )];
        
        UIButton * backGroundImage = [UIButton buttonWithType:UIButtonTypeCustom];
        
        backGroundImage.frame = _headerView.bounds;
        
        
//        NSLog(@"image view ______ %f",backGroundImage.frame.size.height);

        
        [backGroundImage addTarget:self action:@selector(backGroundImageClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.backGroundImage = backGroundImage;
        
        _headerView.backgroundColor = [UIColor grayColor];
        
        [_headerView addSubview:backGroundImage];
        
        [_headerView addSubview:[self createUser]];
        
    }
    

    
    return _headerView;
}

- (void)setupTableView
{
    [self.view addSubview:self.tableView];
    
//    DCFriendCircleCell * cell = [[DCFriendCircleCell alloc]init];
    

//    UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(rightBarButtonItemLongClick)];
    
    
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(rightBarButtonItemClick)];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    btn.frame = CGRectMake(0, 0, 30, 30);
    
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = [self headerView];
    
    UIRefreshControl * refresh = [[UIRefreshControl alloc]init];
    
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"hard to loading"];
    
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refresh];


}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupTableView];
    
    
}
- (void)refresh:(UIRefreshControl *)refresh
{

    [self loadNewDate];
    
    [refresh endRefreshing];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.date.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCFriendCircleCell * cell = [DCFriendCircleCell circleCellWithTableView:tableView];
    
//    [self.tableView addObserver:cell forKeyPath:@"change" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.cellDate addObject:cell];
    
    DCFriendCircleDateFrame * dateFrame = self.date[indexPath.row];
    
    cell.dateFrame = dateFrame;
    
    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCFriendCircleDateFrame * dateFrame = self.date[indexPath.row];
    
    return dateFrame.cellHeight + 20;
    
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    
//        return [self headerView];
//
//
//}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 44;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



- (UIButton *)createUser
{
    CGFloat nameW = 50;
    
    CGFloat nameH = 20;
    
    CGFloat btnHW = 60;
    
    CGFloat viewCenterY = (self.view.frame.size.height)/2;
    
    CGFloat padding = 10;
    
//    CGFloat tabbarHeight = self.tabBarController.tabBar.frame.size.height;
    
    UIButton * userImage = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [userImage setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];

    userImage.frame = CGRectMake(self.view.frame.size.width - padding - btnHW, viewCenterY - btnHW/2 -padding , btnHW, btnHW);
    
    [userImage setBackgroundColor:[UIColor whiteColor]];
    
    [userImage setImage:[UIImage imageNamed:@"icon1"] forState:UIControlStateNormal];
    
    UILabel * userName = [[UILabel alloc]init];
    
    userName.text = @"Cache";
    
    userName.textColor = [UIColor whiteColor];
    
    userName.font = [UIFont boldSystemFontOfSize:15];
    
    userName.frame = CGRectMake(CGRectGetMinX(userImage.frame) - padding - nameW, userImage.frame.origin.y + padding, nameW, nameH);
    
    [self.headerView addSubview:userName];
    
    return userImage;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self loadStatuses];
    
}

-(void)backGroundImageClick
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"更换相册封面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];

        
        
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
//    [self.view addSubview:alert.view];

    [self presentViewController:alert animated:YES completion:nil];

    
}

- (void)rightBarButtonItemClick
{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    
    [alert addAction:[UIAlertAction actionWithTitle:@"小视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        DCDiscoverViewSendTextController * sendText = [[DCDiscoverViewSendTextController alloc]init];
        
        sendText.delegate = self;
        
        DCNavigationController * navigation = [[DCNavigationController alloc]initWithRootViewController:sendText];
        

        [self.navigationController presentViewController:navigation animated:YES completion:nil];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];

        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];

        
        
    }]];

    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    [self.backGroundImage setImage:image forState:UIControlStateNormal];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

- (void)sendTextWithController:(DCDiscoverViewSendTextController *)controller WithText:(NSString *)text
{
    [self loadNewDate];

}


@end
