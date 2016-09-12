//
//  SpotDetailViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/23.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "SpotDetailViewController.h"
#import "SpotDetailView.h"
#import "SpotLocationViewController.h"
#import "BuyTicketViewController.h"

@interface SpotDetailViewController ()<UITableViewDataSource,UITableViewDelegate,SpotDetailViewDelegate>

{
    UITableView *table;
    CGFloat heightRow;//cell的高度
}

@end

@implementation SpotDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self createDetailView];
    
}

-(void)createDetailView
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT- 49) style:UITableViewStylePlain];
    table.tableFooterView = [[UIView alloc] init];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    
    [table registerClass:[SpotDetailView class] forCellReuseIdentifier:@"SpotDetailView"];
    [table reloadData];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"景点详情";
    lab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = lab;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-dingwei"] style:UIBarButtonItemStyleDone target:self action:@selector(locationSpotPosition)];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    backView.backgroundColor = [UIColor colorWithRed:32/255.0 green:176/255.0 blue:226/255.0 alpha:1.0];
    backView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    backView.tag = 100;
    [self.view addSubview:backView];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.backgroundColor = [UIColor redColor];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.frame = CGRectMake(0, 0, 100, 36);
    buyBtn.layer.cornerRadius = 5;
    buyBtn.clipsToBounds = YES;
    [buyBtn setTitle:@"立即预定" forState:UIControlStateNormal];
    buyBtn.center = backView.center;
    [buyBtn addTarget:self action:@selector(Buy:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
    
    
    
}
-(void)Buy:(UIButton *)btn
{
    BuyTicketViewController *buyVC = [[BuyTicketViewController alloc] init];
    buyVC.url = _spot.result.url;
    [self.navigationController pushViewController:buyVC animated:YES];
}

#pragma mark -- 景点定位
-(void)locationSpotPosition
{
    SpotLocationViewController *locationVC = [[SpotLocationViewController alloc] init];
    locationVC.model = self.spot.result;
    [self.view.window.rootViewController presentViewController:locationVC animated:YES completion:nil];
}

#pragma mark -- tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_spot)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpotDetailView *cell = [tableView dequeueReusableCellWithIdentifier:@"SpotDetailView"];
    cell.delegate =self;
    
    if (_spot)
    {
        [cell setCellWithSpot:self.spot];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightRow;
}

#pragma mark -- header的代理方法(高度)
-(void)reloadCellheight:(CGFloat)height
{
    heightRow = height;
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
