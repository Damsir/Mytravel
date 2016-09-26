//
//  MCBaseViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/19.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCBaseViewController.h"
#import "DrawerViewController.h"
//model
#import "MCHotModel.h"
#import "SpecialVideoModel.h"
#import "MCInfoList.h"
#import "MCDestinationList.h"


@interface MCBaseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MCInfoList *InfoList;
    NSDictionary *dic;//POST 方法的body
}

@end

@implementation MCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    
    //创建头像btn
    [self createMyIcon];
    //初始化table
    [self initWithTableView];
    
}

#pragma mark -- tableView创建
-(void)initWithTableView
{
    self.MCTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.MCTable.tableFooterView = [[UIView alloc] init];
    self.MCTable.dataSource = self;
    self.MCTable.delegate = self;
    [self.view addSubview:self.MCTable];
    
    //上拉刷新,下拉加载更多
    self.MCTable.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.MCTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerLoadMore)];
    
}

-(void)headerRefresh
{
    
}
-(void)footerLoadMore
{
    
}

#pragma mark--数据网络请求功能
//刷新页面
-(void)loadYouQuNetDataInfo:(freshDataBlock)block
{
    _page = 1;
    //刷新请先清空数组
    [self.dataArray removeAllObjects];
    //游趣首页
    if (_index == 1)
    {
        _url = @"";
        _url = [NSString stringWithFormat:HOTVISIT_API,_page];
        
        [self LoadDataWithAPIkey:block];
    }
    //视频分享
    else if (_index == 21)
    {
        dic = @{@"category":@"0",@"clientNo":@"ezvizsports",@"clientType":@"11",@"clientVersion":@"2.1.1.20150918",@"createtime":@"0",@"hot":@"0",@"netType":@"2",@"orderBy":@"3",@"osVersion":@"9.0.1",@"pageSize":@"10",@"pageStart":[NSString stringWithFormat:@"%d",_page],@"subCategory":@"24"};
        [self GetHttpData:block];
    }
    
    else if (_index == 22)
    {
        dic = @{@"clientNo":@"ezvizsports",@"clientType":@"11",@"clientVersion":@"2.1.1.20150918",@"netType":@"0",@"osVersion":@"9.0.1",@"pageSize":@"10",@"pageStart":[NSString stringWithFormat:@"%d",_page]};
        
        [self GetHttpData:block];
    }
    //目的地
    else if (_index == 3)
    {
        [self GetHttpData:block];
    }
    
}
//加载更多
-(void)loadMoreYouQuNetDataToInfo:(freshDataBlock)block
{
    _page++;
    if (_index ==1)
    {
        _url = @"";
        _url = [NSString stringWithFormat:HOTVISIT_API,_page];
        
        [self LoadDataWithAPIkey:block];
    }
    else if (_index == 21)
    {
        dic = @{@"category":@"0",@"clientNo":@"ezvizsports",@"clientType":@"11",@"clientVersion":@"2.1.1.20150918",@"createtime":@"0",@"hot":@"0",@"netType":@"2",@"orderBy":@"3",@"osVersion":@"9.0.1",@"pageSize":@"10",@"pageStart":[NSString stringWithFormat:@"%d",_page],@"subCategory":@"24"};
        
        [self GetHttpData:block];
    }
    else if (_index == 22)
    {
        dic = @{@"clientNo":@"ezvizsports",@"clientType":@"11",@"clientVersion":@"2.1.1.20150918",@"netType":@"0",@"osVersion":@"9.0.1",@"pageSize":@"10",@"pageStart":[NSString stringWithFormat:@"%d",_page]};
        [self GetHttpData:block];
    }
}

-(void)GetHttpData:(freshDataBlock)block
{
    //加载提示框
    [self.view showJiaZaiWithBool:YES WithAnimation:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:_url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *JsonDic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        if (_index == 21)
        {
            NSArray *array = JsonDic[@"playLists"];
            for (NSDictionary *dict in array)
            {
                SpecialVideoModel *model = [[SpecialVideoModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:model];
            }
           
        }
        else if (_index == 22)
        {
            NSArray *array = JsonDic[@"list"];
            for (NSDictionary *dict in array)
            {
                SpecialVideoModel *model = [[SpecialVideoModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:model];
            }
        }
        else if (_index == 3)
        {
            MCDestinationList *DestinationList = [[MCDestinationList alloc] mj_setKeyValues:operation.responseString];
            for (DestinationModel *model in DestinationList.data)
            {
                [self.dataArray addObject:model];
            }
        }
        
        //如果解析成功,给外边回调
        if (block)
        {
            //如果解析成功,回调
            block(YES,nil);
            
        }
        //[self.MCTable reloadData];
        //[self.MCTable.header endRefreshing];
        //[self.MCTable.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //如果网络解析错误,回调
        //block(NO,error);
        //隐藏加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        [self.MCTable.header endRefreshing];
        [self.MCTable.footer endRefreshing];
        
        NSLog(@"网络请求失败");
        
    }];
}

-(void)LoadDataWithAPIkey:(freshDataBlock)block
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"32d8ea3372029f92c5268aaae8d41157" forHTTPHeaderField:@"apikey"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (_index == 1)
        {
            InfoList = [[MCInfoList alloc]initWithData:operation.responseData error:nil];
            
            for (MCHotModel *hotModel in InfoList.books)
            {
                [self.dataArray addObject: hotModel];
            }
        }
        
        if (block) {
            //如果解析成功,回调
            block(YES,nil);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //隐藏加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        [self.MCTable.header endRefreshing];
        [self.MCTable.footer endRefreshing];
        
        NSLog(@"网络请求失败");
    }];
    
    [operation start];
}

#pragma mark -- tableView的代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}


#pragma mark -- 导航栏抽屉按钮
-(void)createMyIcon
{
   //设置左侧头像按钮
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStyleDone target:self action:@selector(openOrCloseLeftList)];
}

//打开抽屉
- (void) openOrCloseLeftList
{
    DrawerViewController *drawer = (id)self.view.window.rootViewController;
    [drawer openLeftView];
}

//导航栏标题
-(void)initNavigationBarTitle:(NSString *)title
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    lab.textColor     = [UIColor whiteColor];
    lab.font          = [UIFont boldSystemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text          = title;
    
    self.navigationItem.titleView = lab;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    NSLog(@"内存过大");
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
