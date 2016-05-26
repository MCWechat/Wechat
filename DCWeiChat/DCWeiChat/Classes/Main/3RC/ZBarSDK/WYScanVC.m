//
//  ViewController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.

#import "WYScanVC.h"
#import "DCChatViewScanQRController.h"

//获取当前屏幕的高度
#define kMainScreenHeight ([UIScreen mainScreen].applicationFrame.size.height)
//获取当前屏幕的宽度
#define kMainScreenWidth  ([UIScreen mainScreen].applicationFrame.size.width)
//获取设备型号
#define isiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
@interface WYScanVC ()

@end

@implementation WYScanVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    if (isiPhone4) {
        imageView.image = [UIImage imageNamed:@"pick_bg_small"];
    }else{
        imageView.image = [UIImage imageNamed:@"pick_bg"];
    }
    
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 110, 220, 4)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(50, 105+2*num, 220, 4);
        //最低位置
        if (2*num == 180) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(50, 105+2*num, 220, 4);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
-(void)backAction
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
    
    
}
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(0,0,kMainScreenWidth,kMainScreenHeight);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btnColor"]];
    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    scanButton.frame = CGRectMake(0, 0, 100, 30);
    scanButton.layer.cornerRadius = 8;
    scanButton.layer.masksToBounds = YES;
    scanButton.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight - 75);
    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMidY(scanButton.frame) - 80, kMainScreenWidth - 30, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [self.view addSubview:labIntroudction];
    
    [self performSelector:@selector(delayStart) withObject:nil afterDelay:0.02];
}
//延时启动
- (void)delayStart
{
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    
    
//    DCChatViewScanQRController * vc = [[DCChatViewScanQRController alloc]init];
//    
//    vc.urlString = stringValue;
    
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:^
     {
         self.urlblock(stringValue);
         [timer invalidate];

     }];
}


@end
