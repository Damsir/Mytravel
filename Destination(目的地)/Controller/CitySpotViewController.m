//
//  CitySpotViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/30.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "CitySpotViewController.h"
#import "MCCitySpotList.h"
#import "CitySpotCell.h"
#import "TicketDetailViewController.h"

@interface CitySpotViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *url;
    int page;
    NSMutableArray *dataArray;
    UITableView *citySpotTable;
    MCCitySpotList *citySpotList;
    
    CitySpotCell *cell;
}

@end

@implementation CitySpotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    dataArray = [NSMutableArray array];
    page = 1;
    url = [NSString stringWithFormat:MCCITYSPOTLIST_API,page,_countryId];
    
    [self createTableView];
    [self loadNetData];
    
}
-(void)createTableView
{
    citySpotTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    citySpotTable.tableFooterView = [[UIView alloc] init];
    citySpotTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    citySpotTable.dataSource = self;
    citySpotTable.delegate = self;
    [self.view addSubview:citySpotTable];
    [citySpotTable registerNib:[UINib nibWithNibName:@"CitySpotCell" bundle:nil] forCellReuseIdentifier:@"CitySpotCell"];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = _name;
    self.navigationItem.titleView = lab;

    __weak typeof (*&self)weakSelf = self;
    //上拉刷新,下来加载更多
    citySpotTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        url = [NSString stringWithFormat:MCCITYSPOTLIST_API,page,_countryId];
        [dataArray removeAllObjects];
        [weakSelf loadNetData];
    }];
    
    citySpotTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page++;
        url = [NSString stringWithFormat:MCCITYSPOTLIST_API,page,_countryId];
        [weakSelf loadNetData];
    }];
}

#pragma mark-- 加载网络数据
-(void)loadNetData
{
    //加载提示框
    [self.view showJiaZaiWithBool:YES WithAnimation:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         citySpotList = [[MCCitySpotList alloc] mj_setKeyValues:operation.responseString];
         for (CitySpotModel *model in citySpotList.tourBriefList)
         {
             [dataArray addObject:model];
         }
         
         [self.view showJiaZaiWithBool:NO WithAnimation:NO];
         [citySpotTable reloadData];
         [citySpotTable.header endRefreshing];
         [citySpotTable.footer endRefreshing];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [self.view showJiaZaiWithBool:NO WithAnimation:NO];
         [citySpotTable.header endRefreshing];
         [citySpotTable.footer endRefreshing];
     }];
}

#pragma mark--UICollectionViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataArray)
    {
        return dataArray.count;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static BOOL isFirst = YES;
    cell = [tableView dequeueReusableCellWithIdentifier:@"CitySpotCell"];
    //安全性判断
    if (dataArray.count > indexPath.row)
    {
        [cell setCellWithInfo:dataArray[indexPath.row]];
    }
    if (isFirst)
    {
        [UIView animateWithDuration:1.2 animations:^{
            
            cell.image.bounds = CGRectMake(0, 0, SCREENWIDTH-40, 160);
        }];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0;
}

#pragma mark -- 图片缩放效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //求出播放器在试图控制器上的位置
    CGRect rect = [cell convertRect:cell.bounds toView:citySpotTable];
    if (rect.origin.y > 120 || rect.origin.y < SCREENHEIGHT-120)
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            cell.image.bounds = CGRectMake(0, 0, SCREENWIDTH-40, 160);
        }];
    }
}

#pragma mark -- Cell点击代理事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketDetailViewController *detaiVC = [[TicketDetailViewController alloc] init];
    detaiVC.tour_id = [NSString stringWithFormat:@"%@",[dataArray[indexPath.row] tour_id]];
    [self.view.window.rootViewController presentViewController:detaiVC animated:YES completion:nil];
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
