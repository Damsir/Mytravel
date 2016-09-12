//
//  MCNavigationController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/1.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCNavigationController.h"

@interface MCNavigationController ()

@end

@implementation MCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor colorWithRed:34/255.0 green:171/255.0 blue:78/255.0 alpha:0.9];
    //self.navigationBar.barTintColor = [UIColor colorWithRed:32/255.0 green:175/255.0 blue:165/255.0 alpha:1];
}

//---------调整状态栏的颜色--------
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
