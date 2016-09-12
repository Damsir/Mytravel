//
//  MCDestinationViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/30.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "MCDestinationViewController.h"
#import "MCDestinationList.h"
#import "CityTableViewCell.h"
#import "CitySpotViewController.h"
#import "DestinationLocationViewController.h"//定位控制器

@interface MCDestinationViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSInteger selectedIndex;//记录当前选择的国家按钮
    DestinationModel *coutryList;
    UITableView *cityTable;
    UILabel *site;//定位地点
}

@end

@implementation MCDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationBarTitle:@"目的地"];
    selectedIndex = 0;//默认当前点击目的地为第一个按钮
    
    [self loadNetData];
    
    [self.MCTable registerNib:[UINib nibWithNibName:@"CityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CityTableViewCell"];
}

#pragma mark -- 创建界面
-(void)createDestinationUI
{
    for (int i=0; i<self.dataArray.count; i++)
    {
        UIButton *coutryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        coutryBtn.frame = CGRectMake(0, 69+i*(SCREENHEIGHT-123)/13.0, 0.25*SCREENWIDTH, (SCREENHEIGHT-123)/13.0);
        [coutryBtn setTitle:[self.dataArray[i] chineseName] forState:UIControlStateNormal];
        coutryBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [coutryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [coutryBtn addTarget:self action:@selector(selectedIndexBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0)
        {
            [coutryBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            coutryBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
            coutryBtn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        }
        coutryBtn.tag = i+100;
        [self.view addSubview:coutryBtn];
    }
    
    self.MCTable.frame = CGRectMake(0.25*SCREENWIDTH, 0, 0.75*SCREENWIDTH,SCREENHEIGHT);
    self.MCTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
    location.frame = CGRectMake(0, 0, 30, 30);
    [location setImage:[UIImage imageNamed:@"iconfont-dingwei"] forState:UIControlStateNormal];
    [location addTarget:self action:@selector(locationMyPosition) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc] initWithCustomView:location];
 
    site = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    site.textColor = [UIColor whiteColor];
    site.textAlignment = NSTextAlignmentCenter;
    site.text = @"北京";
    UIBarButtonItem *bar2 = [[UIBarButtonItem alloc] initWithCustomView:site];
    self.navigationItem.rightBarButtonItems = @[bar1,bar2];
}
#pragma mark -- 定位我的位置
-(void)locationMyPosition
{
    DestinationLocationViewController *locationVC = [[DestinationLocationViewController alloc] init];
    locationVC.locationNameBlock = ^(NSString *markPlace){
    
        site.text = markPlace;
    };
    [self.view.window.rootViewController presentViewController:locationVC animated:YES completion:nil];
    
}
#pragma mark -- 更改按钮状态
-(void)selectedIndexBtn:(UIButton *)btn
{
    //上一次点击的还原状态
    UIButton *oldButton = (UIButton *)[self.view viewWithTag:selectedIndex+100];
    [oldButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    oldButton.backgroundColor = [UIColor whiteColor];
    oldButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
   
    //当前点击的按钮的颜色变化,字体大小变化
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    btn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    //记住上一次点击的按钮的tag值
    selectedIndex = btn.tag-100;
    
    [self.MCTable reloadData];
    
}
//下拉刷新
-(void)headerRefresh
{
    [self.MCTable.header endRefreshing];
}
//重写父类的上拉加载更多
-(void)footerLoadMore
{
    [self.MCTable.footer endRefreshing];
}

-(void)loadNetData
{
    self.index = 3;
    self.url = MCDESTINATION_API;
    
    __weak typeof (*&self)weakSelf = self;
    
    [weakSelf loadYouQuNetDataInfo:^(BOOL isSuccess, NSError *error) {
        
        if (isSuccess)
        {
            [self createDestinationUI];
            [self.MCTable.header endRefreshing];
            [self.MCTable reloadData];
        }
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
    }];
}
#pragma mark -- tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count)
    {
        coutryList = self.dataArray[selectedIndex];
        return coutryList.subList.count;
    }
    else
    {
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DestinationModel *coutryModel = self.dataArray[selectedIndex];
    if ([coutryModel.subList count] > indexPath.row)
    {
        [cell setUIWithInfoDestinationModel:coutryModel.subList[indexPath.row]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0;
}

#pragma mark -- Cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitySpotViewController *cityVC = [[CitySpotViewController alloc] init];
    DestinationModel *coutryModel = self.dataArray[selectedIndex];
    cityVC.countryId = [NSString stringWithFormat:@"%@", [coutryModel.subList[indexPath.row] locationId]];
    cityVC.name = [coutryModel.subList[indexPath.row] chineseName];
    cityVC.hidesBottomBarWhenPushed = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"目的地" style:UIBarButtonItemStyleDone target:self action:nil];
    [self.navigationController pushViewController:cityVC animated:YES];
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
