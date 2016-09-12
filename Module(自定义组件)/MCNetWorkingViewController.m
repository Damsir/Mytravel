//
//  MCNetWorkingViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/6.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCNetWorkingViewController.h"


@interface MCNetWorkingViewController ()

@end

@implementation MCNetWorkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadNetWorkingManager];
}
-(void)loadNetWorkingManager
{
    //网络监听
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //开启检测
    [manager startMonitoring];
    //AFNetworkReachabilityStatus检测到的网络状态
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status)
        {
            //未知
            case AFNetworkReachabilityStatusUnknown:
            {
                
            }
                break;
             //网络不可用
            case AFNetworkReachabilityStatusNotReachable:
            {
                [self showMassageWithText:@"当前网络不可用,请检查您的网络设置"] ;
            }
                break;
            //流量
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [self showMassageWithText:@"您正在使用3G/4G上网"];
            }
                break;
             //wifi
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                
            }
                break;
            default:
                break;
        }
    }];
}
-(void)showMassageWithText:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil , nil];
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
