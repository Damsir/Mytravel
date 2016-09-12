//
//  TicketDetailPage.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/10.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "TicketDetailPage.h"

@interface TicketDetailPage ()<UIWebViewDelegate>

{
    UIWebView *web;
}

@end

@implementation TicketDetailPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createWebView];
}

-(void)createWebView
{
    //创建网页页面
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    web.scrollView.bounces = NO;
    web.delegate = self;
    [self.view addSubview:web];
    //通过URL 创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [web loadRequest:request];
    
    UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    naView.backgroundColor = [UIColor colorWithRed:32/255.0 green:176/255.0 blue:226/255.0 alpha:1];
    naView.tag = 200;
    [self.view addSubview:naView];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"详情";
    lab.center = CGPointMake(SCREENWIDTH/2.0, 40);
    [naView addSubview:lab];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}
-(void)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [web removeFromSuperview];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 获得web 页面的头title
    // 通过获得web html 页面的 "document.title"  js代码获取
    self.title =[web stringByEvaluatingJavaScriptFromString:@"document.title"];//获
    
    NSMutableString *js = [NSMutableString string];
    [js appendString:@"var banner = document.getElementsByClassName('text')[0];"];
    [js appendString:@"banner.parentNode.removeChild(banner);"];
    [webView stringByEvaluatingJavaScriptFromString:js];
    
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
