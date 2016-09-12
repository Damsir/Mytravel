//
//  MCTabBarController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/1.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCTabBarController.h"
#import "ViewController.h"
#import "ShareVideoViewController.h"
#import "MCNavigationController.h"
#import "MCDestinationViewController.h"
#import "MineViewController.h"

#import "LeftViewController.h"
#import "DrawerViewController.h"


@interface MCTabBarController ()<UITabBarControllerDelegate>

{
    NSMutableArray *viewControllers;
}

@end

@implementation MCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //关闭自适应
    self.automaticallyAdjustsScrollViewInsets  = NO ;
    
    self.tabBar.tintColor = [UIColor colorWithRed:34/255.0 green:171/255.0 blue:38/255.0 alpha:1];
    //self.tabBar.barTintColor = [UIColor orangeColor];

    [self loadViewControllers];
    
}
-(void)loadViewControllers
{
    MCNavigationController *nav1 = [[MCNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"ico_tabbar_home"] selectedImage:[UIImage imageNamed:@"ico_tabbar_home_sel"]];
    
    
    MCNavigationController *nav2 = [[MCNavigationController alloc] initWithRootViewController:[[ShareVideoViewController alloc] init]];
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分享" image:[[UIImage imageNamed:@"ico_tabbar_video"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"ico_tabbar_video_sel"]];
    
    MCNavigationController *nav3 = [[MCNavigationController alloc] initWithRootViewController:[[MCDestinationViewController alloc] init]];
    
    nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"目的地" image:[UIImage imageNamed:@"ico_tabbar_destination"] selectedImage:[UIImage imageNamed:@"ico_tabbar_destination_sel"]];
    
    
    MineViewController *nav4 = [[MineViewController alloc] init];
    nav4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"ico_tabbar_user"] selectedImage:[UIImage imageNamed:@"ico_tabbar_user_sel"]];
    
    viewControllers = [NSMutableArray arrayWithObjects:nav1,nav2,nav3,nav4, nil];
   
    self.viewControllers = viewControllers;
    
    //从NSUserDefaults取到上次程序结束时，最后点击的tabBarItem项
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults] ;
    NSInteger index = [defaults integerForKey:@"selectedIndex"] ;
    //设置默认选中项
    self.selectedIndex = index ;
    self.delegate = self ;
}

#pragma -- UITabBarControllerDelegate 点击tabBarItem时调用此函数
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSInteger index = tabBarController.selectedIndex ;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults] ;
    
    [defaults setInteger:index forKey:@"selectedIndex"] ;
    
    [defaults synchronize] ;
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
