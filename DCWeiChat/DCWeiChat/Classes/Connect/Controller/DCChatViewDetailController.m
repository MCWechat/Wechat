//
//  DCChatViewDetailController.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCChatViewDetailController.h"
#import "DCChatViewDetailCell.h"
#import "DCContactDate.h"
#import "DCMessageDate.h"
#import "DCChatViewController.h"
#import "DCMessageDateFrame.h"

@class DCContactDate,DCMessageDate,DCMessageDateFrame;

@interface DCChatViewDetailController()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(strong,nonatomic)NSMutableArray * messageDateFrames;

@property(strong,nonatomic) UIView * keyBoardView;

@property(strong,nonatomic) UITableView * tableView;

@property(strong,nonatomic) UITextField * textField;

@property(strong,nonatomic) UIButton * voiceBtn;
@property(strong,nonatomic) UIButton * holdBtn;

@property(assign,nonatomic) BOOL voiceBtnClick;

@property(strong,nonatomic) UIView * voiceView;
@property(strong,nonatomic) UIImageView * voiceImgView;
@property(strong,nonatomic) UILabel * voiceLabView;
@property(strong,nonatomic) UIImageView * voicePowView;


@end



@implementation DCChatViewDetailController



- (UIView *)voiceView
{
    if (_voiceView == nil) {
        
        _voiceView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 80 , self.view.frame.size.height/2 -80, 160, 160)];
        
        _voiceView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
        
        _voiceImgView = [[UIImageView alloc]init];
        
        _voiceImgView.image = [UIImage imageNamed:@"RecordingBkg"];
        
        _voiceImgView.frame = CGRectMake(10, 25, 60, 110);
        
        [_voiceView addSubview:_voiceImgView];
        
        _voicePowView = [[UIImageView alloc]init];
        
        _voicePowView.frame = CGRectMake(CGRectGetMaxX(_voiceImgView.frame) + 40, 25, 40, 110);
        
        [_voiceView addSubview:_voicePowView];
        
        [self.view addSubview:_voiceView];
        
        _voiceView.hidden = YES;
        
        NSLog(@"voice");
        
    }
    
    return _voiceView;
}

- (void)delegateForMessageDate
{
    if ([self.delegate respondsToSelector:@selector(chatViewDetailController:messageDate:)]) {
        
        [self.delegate chatViewDetailController:self messageDate:self.messageDate];
        
    }

}

- (void)sendMessage:(DCMessageDate *)messageDate
{
    DCMessageDateFrame * messageDateFrame = [[DCMessageDateFrame alloc]init];
    
    messageDateFrame.messageDate = messageDate;
    
    [self.messageDate addObject:messageDate];
    
    [self.messageDateFrames addObject:messageDateFrame];
    
    [self.tableView reloadData];

    [self tableViewScrollToBttom];
    
    [self delegateForMessageDate];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DCMessageDate * messageDate = [[DCMessageDate alloc]init];
    
    messageDate.message = textField.text;
    messageDate.type = DCMessageTypeMe;
    messageDate.icon = @"icon2";

    [self sendMessage:messageDate];
    textField.text = nil;
    [self.view endEditing:YES];
    return YES;
}

-(UITextField *)textField
{
    if (!_textField) {
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(40, 7, self.view.frame.size.width - 120, 30)];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.delegate = self;
    }
    return _textField;
}
-(UIView *)keyBoardView
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (!_keyBoardView) {
        _keyBoardView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) -44, screenSize.width, 44)];
        [_keyBoardView addSubview:self.textField];
        
        CGFloat btnH = 40,btnW = 40;
        UIButton * voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * charaBtn = [UIButton buttonWithType:UIButtonTypeCustom];

        voiceBtn.frame = CGRectMake(0, 2, btnW, btnH);
        addBtn.frame = CGRectMake(CGRectGetMaxX(self.textField.frame), 2, btnW, btnH);
        charaBtn.frame = CGRectMake(CGRectGetMaxX(addBtn.frame), 2, btnW, btnH);

        [voiceBtn addTarget:self action:@selector(voiceBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [voiceBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
        [voiceBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateHighlighted];

        
        [addBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
        
        
        [charaBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
        [charaBtn setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateHighlighted];
        [charaBtn addTarget:self action:@selector(playBtn) forControlEvents:UIControlEventTouchUpInside];

        [_keyBoardView addSubview:voiceBtn];
        [_keyBoardView addSubview:addBtn];
        [_keyBoardView addSubview:charaBtn];

        
        _keyBoardView.backgroundColor = [UIColor whiteColor];
        self.keyBoardView = _keyBoardView;
        self.voiceBtn = voiceBtn;
        
    }
    return _keyBoardView;
}

- (void)playBtn
{

}

-(UITableView *)tableView
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height -44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        _tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        _tableView.allowsSelection = NO;
        
    }
    return _tableView;
}



-(NSArray *)messageDateFrames
{
    if (_messageDateFrames == nil) {
        
        _messageDateFrames = [NSMutableArray array];
        
        NSMutableArray * tarray = [NSMutableArray array];
        
        for (DCMessageDate * msgd in self.messageDate) {
            
            DCMessageDateFrame * msgdf = [[DCMessageDateFrame alloc]init];
            
            msgdf.messageDate = msgd;
            
            [tarray addObject:msgdf];
        }
        self.messageDateFrames = tarray;
    }
    return _messageDateFrames;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.voiceView];
    [self.view addSubview:self.keyBoardView];
    
}


- (void)tableViewScrollToBttom
{
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.messageDateFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notif
{
    CGRect keyBoardChangeFrame = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardChangeDuration = [notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGFloat transformY = keyBoardChangeFrame.origin.y - self.view.frame.size.height;
    
    [UIView animateWithDuration:keyBoardChangeDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
    
    if (transformY != 0) {
        
        [self tableViewScrollToBttom];

    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableViewScrollToBttom];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.view endEditing:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        //7.0第一次运行会提示，是否允许使用麦克风
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        //AVAudioSessionCategoryPlayAndRecord用于录音和播放
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if(session == nil)
            NSLog(@"Error creating session: %@", [sessionError description]);
        else
            [session setActive:YES error:nil];
    }
    
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    playName = [NSString stringWithFormat:@"%@/play.aac",docDir];
    
    //录音设置
    recorderSettingsDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
                           [NSNumber numberWithInt:1000.0],AVSampleRateKey,
                           [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                           [NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
                           [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                           [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                           nil];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.messageDateFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cc";
    
    DCChatViewDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[DCChatViewDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.messageDateFrame = self.messageDateFrames[indexPath.row];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCMessageDateFrame * msgdf = self.messageDateFrames[indexPath.row];
    
    return msgdf.cellHeight;
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];

}


- (UIButton *)holdBtn
{
    if (_holdBtn == nil) {
        _holdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _holdBtn.frame = self.textField.bounds;
        _holdBtn.backgroundColor = [UIColor whiteColor];
        _holdBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_holdBtn setTitle:@"Hold To Talk" forState:UIControlStateNormal];
        [_holdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_holdBtn addTarget:self action:@selector(holdBtnUp) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(holdBtnLongPress:)];
        [_holdBtn addGestureRecognizer:longPress];
        
        _holdBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.textField addSubview:_holdBtn];
        
        
    }
    return _holdBtn;
}


- (void)holdBtnLongPress:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint longPressP = [recognizer locationInView:self.view];
    
    switch (recognizer.state) {
            
        case UIGestureRecognizerStateBegan:
            
            [self holdBtnDown];
            

            break;
            
        case UIGestureRecognizerStateChanged:
            
            if (longPressP.y < 400) {
                
                self.voiceImgView.image = [UIImage imageNamed:@"cancel"];
                
            }
            else self.voiceImgView.image = [UIImage imageNamed:@"RecordingBkg"];
            
            
            
            break;
            
        case UIGestureRecognizerStateEnded:
            
            if (longPressP.y < 400) {
                
                [self holdBtnEnd];

            
            }
            
            else [self holdBtnUp];

            self.voiceView.hidden = YES;
            
            break;
            
         case UIGestureRecognizerStateCancelled:
            
            break;
            
        case UIGestureRecognizerStatePossible:
            
            break;
            
        case UIGestureRecognizerStateFailed:
            
            break;
            
    }
    
    
}


- (void)holdBtnEnd
{
    self.voiceView.hidden = YES;
    //松开 结束录音
    
    //录音停止
    [recorder stop];
    recorder = nil;
    //结束定时器
    [timer invalidate];
    timer = nil;

    
}
- (void)holdBtnUp
{
    
    self.voiceView.hidden = YES;
    //松开 结束录音
    
    //录音停止
    [recorder stop];
    recorder = nil;
    //结束定时器
    [timer invalidate];
    timer = nil;
    
    DCMessageDate * messageDate = [[DCMessageDate alloc]init];
    
    messageDate.message = @"Voice Message";
    messageDate.type = DCMessageTypeMe;
    messageDate.icon = @"icon2";
    messageDate.voiceName = playName;
    [self sendMessage:messageDate];
    
    
}

-(void)holdBtnDown
{
    
    self.voiceView.hidden = NO;
    
    
    if ([self canRecord]) {
        
        NSError *error = nil;
        //必须真机上测试,模拟器上可能会崩溃
        recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:playName] settings:recorderSettingsDict error:&error];
        
        if (recorder) {
            recorder.meteringEnabled = YES;
            [recorder prepareToRecord];
            [recorder record];
            
            //启动定时器
            timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(levelTimer:) userInfo:nil repeats:YES];
            
        }
    }
    
}

-(void)levelTimer:(NSTimer*)timer_
{
    self.voicePowView.image = [UIImage imageNamed:@"RecordingSignal001"];
    //call to refresh meter values刷新平均和峰值功率,此计数是以对数刻度计量的,-160表示完全安静，0表示最大输入值
    [recorder updateMeters];
    const double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
    lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults;
    
    NSLog(@"Average input: %f Peak input: %f Low pass results: %f", [recorder averagePowerForChannel:0], [recorder peakPowerForChannel:0], lowPassResults);
    
    if (lowPassResults>=0.8) {
        self.voicePowView.image = [UIImage imageNamed:@"RecordingSignal008"];
    }else if(lowPassResults>=0.40){
        self.voicePowView.image = [UIImage imageNamed:@"RecordingSignal007"];
    }else if(lowPassResults>=0.35){
        self.voicePowView.image = [UIImage imageNamed:@"RecordingSignal006"];
    }else if(lowPassResults>=0.30){
        self.voicePowView.image = [UIImage imageNamed:@"RecordingSignal005"];
    }else if(lowPassResults>=0.25){
        self.voicePowView.image = [UIImage imageNamed:@"RecordingSignal004"];
    }else if(lowPassResults>=0.20){
        self.voicePowView.image = [UIImage imageNamed:@"RecordingSignal003"];
    }else if(lowPassResults>=0.15){
        self.voicePowView.image = [UIImage imageNamed:@"RecordingSignal002"];
    }else if(lowPassResults>=0.1){
        self.voicePowView.image = [UIImage imageNamed:@"RecordingSignal001"];
    }
    
}





- (void)voiceBtnClicked
{
    
    
    if (!self.voiceBtnClick) {
        [self.holdBtn setHidden:NO];
        [self.voiceBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
        


    }
    else
    {
        [self.voiceBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
        [self.holdBtn setHidden:YES];

    }
    
    self.voiceBtnClick = !self.voiceBtnClick;

    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.messageBlock(self.messageDate);
    self.tabBarController.tabBar.hidden= YES;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden= YES;

}

//判断是否允许使用麦克风7.0新增的方法requestRecordPermission
-(BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                }

            }];
        }
    }
    
    return bCanRecord;
}




@end
