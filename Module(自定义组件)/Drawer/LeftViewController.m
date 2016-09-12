//
//  LeftViewController.m
//  Drawer
//
//  Created by 吴定如 on 15/10/23.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "LeftViewController.h"
#import "DrawerViewController.h"
#import "MCWeatherModel.h"
#import "MCWeatherView.h"
#import "MCDrawerCell.h"
#import "OurDetailViewController.h"
#import "MCWeatherViewController.h"

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    UITableView *table;
    WeatherModel *weatherModel;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self createTable];
    
}
-(void)createTable
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:imageview];

    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 0.6*SCREENWIDTH, SCREENHEIGHT-40) style:UITableViewStylePlain];
    tableview.contentInset = UIEdgeInsetsMake(0.20*SCREENHEIGHT, 0, 0, 0);
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    table = tableview;
    [table reloadData];
    [self.view addSubview:tableview];
    
    [table registerClass:[MCWeatherView class] forCellReuseIdentifier:@"MCWeatherView"];
    [table registerClass:[MCDrawerCell class] forCellReuseIdentifier:@"MCDrawerCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        MCWeatherView *cell = [tableView dequeueReusableCellWithIdentifier:@"MCWeatherView"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (weatherModel)
        {
            [cell setWeatherViewWithModel:weatherModel];
        }
        
        return cell;
    }
    else
    {
        MCDrawerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCDrawerCell"];
        
        if (indexPath.row == 0)
        {
            cell.text.text = @"天气查询";
        } else if (indexPath.row == 1)
        {
            cell.text.text = @"视频清晰";
            
        }else if (indexPath.row == 2)
        {
            cell.text.text = @"关于我们";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        if (indexPath.row==0)
        {
            //要推出的视图控制器
            MCWeatherViewController *vc = [[MCWeatherViewController alloc] init];
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        
            [self.view.window.rootViewController presentViewController:vc animated:YES completion:nil];
            vc.wetherBlock = ^(WeatherModel *model){
                
                weatherModel = model;
                [table reloadData];
            };
        }
        else if (indexPath.row == 1)
        {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"视频优先播放清晰度" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"超清",@"高清",@"标清",@"流畅", nil];
            
            [sheet showInView:self.view];
        }
        else if (indexPath.row == 2)
        {
            OurDetailViewController *ourVC = [[OurDetailViewController alloc] init];
            [self.view.window.rootViewController presentViewController:ourVC animated:YES completion:nil];
        }
    }
}
#pragma mark -- actionSheet代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 4)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"视频清晰度切换成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 0.35*SCREENHEIGHT;
    }
    else
    {
        return 0.075*SCREENHEIGHT;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end