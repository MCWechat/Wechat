//
//  SinaOAuthDate.m
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//
//
#define AccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]


#import "IWOAuthViewController.h"
#import "AFNetworking.h"
#import "SinaOAuthDate.h"
#import "DCTabBarController.h"


@interface IWOAuthViewController () <UIWebViewDelegate>

@end

@implementation IWOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面(新浪提供的登录页面)
//    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
//https://api.weibo.com/oauth2/authorize?client_id=3706852090&redirect_uri=http://www.example.com/response&response_type=code

    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2019184315&redirect_uri=http://www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLRequest * newRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
//    [webView loadRequest:newRequest];
}


#pragma mark - webView代理方法
/**
 *  webView开始发送请求的时候就会调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
//    [MBProgressHUD showMessage:@"哥正在帮你加载中..."];
}

/**
 *  webView请求完毕的时候就会调用
 */


/**
 *  当webView发送一个请求之前都会先调用这个方法, 询问代理可不可以加载这个页面(请求)
 *
 *  @return YES : 可以加载页面,  NO : 不可以加载页面
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"url is ____ %@",request.URL.absoluteString);
    // 1.请求的URL路径: http://ios.itcast.cn/?code=0f189b682cd020e79303dbb043d4fb28
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 3.如果urlStr中包含了code=
    //    if (range.location != NSNotFound)
    if (range.length) {
        // 4.截取code=后面的请求标记(经过用户授权成功的)
        long loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
//        NSLog(@"code is %@",code);
        // 5.发送POST请求给新浪,  通过code换取一个accessToken
        [self accessTokenWithCode:code];
    }
    
    return YES;
}

/**
 *  通过code换取一个accessToken
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    
    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 说明服务器返回的JSON数据
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2019184315";
    params[@"client_secret"] = @"28f335b6d1ca969e6bffdcc191ed6f75";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    // 3.发送请求

    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          NSLog(@"responseObject is : %@",responseObject);
          

          SinaOAuthDate * oauthDate = [SinaOAuthDate dateWithDict:responseObject];
          
          [self saveOAuthDate:oauthDate];
          
          
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"______ receive Failed");
    }];
}

-(void)saveOAuthDate:(SinaOAuthDate *)date
{
    [NSKeyedArchiver archiveRootObject:date toFile:AccountFile];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[DCTabBarController alloc] init];

}

@end
