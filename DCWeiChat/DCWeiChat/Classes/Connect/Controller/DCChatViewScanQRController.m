//
//  DCChatViewScanQRController.m
//  NewWeChat
//
//  Created by MornChan on 16/3/3.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCChatViewScanQRController.h"

@interface DCChatViewScanQRController ()<UIWebViewDelegate>


@end

@implementation DCChatViewScanQRController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    
    NSString * newUrlString = [NSString stringWithFormat:@"http://%@",self.urlString];
    
    NSURL * url = [NSURL URLWithString:newUrlString];

    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(dismissController)];

}

- (void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
@end
