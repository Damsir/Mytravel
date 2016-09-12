//
//  MCAdViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/7.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCAdViewController.h"

@interface MCAdViewController ()<UIWebViewDelegate>
{
    UIWebView *web;
}

@end

@implementation MCAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createWebView];

}

-(void)createWebView
{
    
    //创建网页页面
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 18, self.view.frame.size.width, self.view.frame.size.height+28)];
    web.scrollView.bounces = NO;
    web.delegate = self;
    [self.view addSubview:web];
    //通过URL 创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_URL]];
    [web loadRequest:request];
    [self createHeadView];
    
}

-(void)createHeadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    view.backgroundColor = [UIColor colorWithRed:180/255.0 green:250/255.0 blue:254/255.0 alpha:1.0];
    [self.view addSubview:view];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(BackHomePage) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.center = CGPointMake(SCREENWIDTH/2, 40);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = @"详情介绍";
    [view addSubview:label];
    
}

#pragma mark -- 返回事件
-(void)BackHomePage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [web removeFromSuperview];
}

#pragma mark -- UIWebViewDelegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [web showJiaZaiWithBool:YES WithAnimation:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [web showJiaZaiWithBool:NO WithAnimation:NO];
    
    // 获得web 页面的头title
    // 通过获得web html 页面的 "document.title"  js代码获取
    self.title =[web stringByEvaluatingJavaScriptFromString:@"document.title"];//获
    
}
//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [web showJiaZaiWithBool:NO WithAnimation:NO];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接出错,请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
