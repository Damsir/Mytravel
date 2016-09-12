//
//  AppDelegate.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/27.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "MCTabBarController.h"

#import "LeftViewController.h"
#import "DrawerViewController.h"
#import "ViewController.h"

#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
   [NSThread sleepForTimeInterval:1.5];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    //再次进程序改变登录状态
    NSUserDefaults *Defaults=[NSUserDefaults standardUserDefaults];
    [Defaults setBool:NO forKey:@"isLoginState"];
    [Defaults synchronize];
    // 判断是否是第一次进入程序的标示
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isFirst = [[defaults objectForKey:@"isFirst"] boolValue];
    // 如果是第一次就加载引导页,如果不是就加载正常页面
    if (isFirst)
    {
        LeftViewController *leftVC = [[LeftViewController alloc] init];
        DrawerViewController *Drawer = [[DrawerViewController alloc] initWithLeftView:leftVC andRootView:[[MCTabBarController alloc] init]];
        self.window.rootViewController = Drawer;
        
    }
    else
    {
        self.window.rootViewController = [[GuideViewController alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    
    
    [UMSocialData setAppKey:@"564d338fe0f55a9b9f009196"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx0b104d65dabe5a74" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://weibo.com/u/3119709301/home?topnav=1&wvr=6"];
    
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://weibo.com/u/3119709301/home?topnav=1&wvr=6"];
    [UMSocialQQHandler setQQWithAppId:@"1104906077" appKey:@"564d338fe0f55a9b9f009196" url:@"http://weibo.com/u/3119709301/home?topnav=1&wvr=6"];
    
    
    //对未安装客户端平台进行隐藏
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


-(void)changeRootView
{
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    DrawerViewController *Drawer = [[DrawerViewController alloc] initWithLeftView:leftVC andRootView:[[MCTabBarController alloc] init]];
    self.window.rootViewController = Drawer;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
