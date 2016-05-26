//
//  DCDiscoverViewSendTextController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/25.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#define photoWH1x  72
#define padding  6

#import "DCDiscoverViewSendTextController.h"
#import "AFNetworking.h"
#import "SinaOAuthDate.h"
#import "MBProgressHUD+DC.h"
#import <CoreLocation/CoreLocation.h>
#import "DCSelectPhotosView.h"
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"

@interface DCDiscoverViewSendTextController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager* _locationManager;
    
    NSString * _textViewMessage;
    
}


@property(strong,nonatomic) UITableView * tableView;

@property(strong,nonatomic) UITextView * textView;

@property (strong, nonatomic) CLLocationManager* locationManager;

@property(strong,nonatomic) NSString * locationInfo;

@property(strong,nonatomic) NSMutableArray * selectPhotos;

@property(strong,nonatomic) UIImageView * imageView;

@property(assign,nonatomic) CGFloat textFieldHeight;


@end

@implementation DCDiscoverViewSendTextController



- (NSMutableArray *)selectPhotos
{
    if (!_selectPhotos) {
        
        _selectPhotos = [NSMutableArray array];
    }
    return _selectPhotos;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (void)setupNavigationBar
{
    
    self.navigationItem.title = @"发表文字";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
    
    
    
    //必须得设置tintcolor 否则无法显示
    NSDictionary * norattri = [NSDictionary dictionary];
    
    norattri = @{NSForegroundColorAttributeName:[UIColor whiteColor],
              
              NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
              
              };
    
    NSDictionary * enarattri = [NSDictionary dictionary];
    
    enarattri = @{NSForegroundColorAttributeName:[UIColor grayColor],
                 
                 NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                 
                 };
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:norattri forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:enarattri forState:UIControlStateDisabled];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:norattri forState:UIControlStateNormal];



    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;

}


- (void)leftBarButtonItemClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)rightBarButtonItemClick
{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary] ;
    
    NSString * access_token = [SinaOAuthDate loadOAuthDate].access_token;
    
    params[@"access_token"] = access_token;
    
    params[@"status"] = self.textView.text;
    
    
    if (self.textView.text.length) {
        
        [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [MBProgressHUD showSuccess:@"发送成功"];
            
            [self.delegate sendTextWithController:self WithText:nil];
            
            
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [MBProgressHUD showError:@"发送失败"];
            
        }];

    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

    
}


//图片显示的整个区域
- (DCSelectPhotosView *)addPhotosView
{
    CGFloat photoX,photoY;
    
    //需要添加图片的按钮
    UIImageView * imageView = [[UIImageView alloc]init];
    
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap)];
    
    [imageView addGestureRecognizer:gesture];
    
    imageView.image = [UIImage imageNamed:@"addPhoto"];
    
    int clo = (int)self.selectPhotos.count / 4;
    
    int row = (int)self.selectPhotos.count % 4;
    
    photoX =  padding + row *(photoWH1x + padding) ;
    
    photoY =  padding + clo * (photoWH1x + padding);
    
    if (self.selectPhotos.count >= 9) {
        
        imageView.hidden = YES;
        
    }
    else imageView.frame = CGRectMake(photoX, photoY, photoWH1x, photoWH1x);
    
    DCSelectPhotosView *photosView = [[DCSelectPhotosView alloc]init];
    
    [photosView addPhotoWithPhotos:self.selectPhotos];
        
    CGSize photoViewSize = [DCSelectPhotosView sizeWithCount:(int)self.selectPhotos.count];
    
    _textFieldHeight = photoViewSize.height - 80;
    
    photosView.frame = (CGRect){0,120,(photoViewSize)};

    [photosView addSubview:imageView];
    
    return photosView;

}




- (void)imageTap
{
    
    MLSelectPhotoPickerViewController * pickerVC = [[MLSelectPhotoPickerViewController alloc]init];
    
    pickerVC.status = PickerViewShowStatusCameraRoll;
    
    pickerVC.maxCount = 9 - self.selectPhotos.count ;
    
    NSLog(@"maxCount is %ld",9-self.selectPhotos.count);
    
    [pickerVC showPickerVc:self];
    
//    __block typeof(self) weakSelf = self;

    pickerVC.callBack = ^(NSArray * array){
        NSMutableArray * tarray = [NSMutableArray array];
        
        for (MLSelectPhotoAssets * photoAssets in array) {
            
            UIImage * image = [photoAssets originImage];
            
            [tarray addObject:image];
            
        }
        
        
        [self.selectPhotos addObjectsFromArray:tarray];
        
        if (tarray.count) {
            
            [self addPhotosView];
            [self setupTableView];

        }

    };
    
    
    
    
    

}

- (void)setupTableView
{
    CGRect newViewRect;
    if (!_tableView) {
        
        CGRect viewRect = self.view.bounds;
        
        viewRect.origin.y = 0;
        
        newViewRect = viewRect;

    }
    else
    {
        CGRect viewRect = self.view.bounds;
        
        viewRect.origin.y = 64;
        
        newViewRect = viewRect;

    }
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:newViewRect style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    CGSize contentOfSize = _tableView.contentSize;
    
    contentOfSize.height = 200;
    
    _tableView.contentSize = contentOfSize;
    
    UITextView * textField =  [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200 + _textFieldHeight)];
    
    self.textView = textField;
    
    [textField addSubview:[self addPhotosView]];
    
    textField.font = [UIFont systemFontOfSize:13];
    
    textField.alwaysBounceVertical = YES;
    
    textField.delegate = self;
    
    _tableView.tableHeaderView =textField;
    
    [self.view addSubview:_tableView];

}


- (void)textViewDidChange:(UITextView *)textView;
{
    
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length;
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    _textViewMessage = textView.text;
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = _textViewMessage;
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self setupTableView];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}












- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *ID = @"cc";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"location"];
    
    if (self.locationInfo.length) {
        
        cell.textLabel.text = self.locationInfo;
        
        [MBProgressHUD hideHUD];
    }
    else cell.textLabel.text = @"获取所在位置";
    
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self startLocation];

    [MBProgressHUD showMessage:@"正在定位"];
    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
    
    
}
-(void)startLocation{
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
        //使用期间
//    [self.locationManager requestWhenInUseAuthorization];
        //始终
    [self.locationManager requestAlwaysAuthorization];

    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10.0f;
    [self.locationManager startUpdatingLocation];
}

//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [_locationManager stopUpdatingLocation];
    
    //    // 保存 Device 的现语言 (英语 法语 ，，，)
    //    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
    //                                            objectForKey:@"AppleLanguages"];
    //    // 强制 成 简体中文
    //    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil]
    //                                              forKey:@"AppleLanguages"];
    
    
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSDictionary * locationDict = [NSDictionary dictionary];
        
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *test = [placemark addressDictionary];
            
            locationDict = test;
        }
        
        //  Country(国家)  State(城市)  SubLocality(区)

        NSString * location = [NSString stringWithFormat:@"%@,%@,%@",locationDict[@"Country"],locationDict[@"State"],locationDict[@"SubLocality"]];
        

        self.locationInfo = location;
        
        [self.tableView reloadData];
        
        
    }];
    
}

@end
