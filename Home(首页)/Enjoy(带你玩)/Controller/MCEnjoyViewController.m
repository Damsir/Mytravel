//
//  MCEnjoyViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/20.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCEnjoyViewController.h"
#import "MJExtension.h"
#import "MCEnjoyList.h"
#import "MCEnjoyCell.h"

@interface MCEnjoyViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

{
    MCEnjoyList *enjoyList;
    UITableView *MCenjoyTable;
    int page;
    NSMutableArray *dataArray;
    NSString *url;
}

@end

@implementation MCEnjoyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"带你玩";
    dataArray = [NSMutableArray array];
    page = 0;
    url = [NSString stringWithFormat:@"%@%d",MCENJOY_API,page];
    
    [self createUI];
    [self loadNetData];

}
#pragma mark -- 界面
-(void)createUI
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    scroll.delegate = self;
    [self.view addSubview:scroll];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"iconfont-back-1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    MCenjoyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    MCenjoyTable.tableFooterView = [[UIView alloc] init];
    MCenjoyTable.dataSource =self;
    MCenjoyTable.delegate = self;
    [scroll addSubview:MCenjoyTable];
    
    [MCenjoyTable registerNib:[UINib nibWithNibName:@"MCEnjoyCell" bundle:nil] forCellReuseIdentifier:@"MCEnjoyCell"];

    __weak typeof (*&self)weakSelf = self;
    MCenjoyTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [dataArray removeAllObjects];
        page = 0;
        url = [NSString stringWithFormat:@"%@%d",MCENJOY_API,page];
        [weakSelf loadNetData];
        
    }];
    
    MCenjoyTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page ++;
        url = [NSString stringWithFormat:@"%@%d",MCENJOY_API,page];
        [weakSelf loadNetData];
    }];
    
}
#pragma mark -- 返回方法
-(void)Back
{
    self.navigationController.navigationBar.alpha = 1.0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -- 加载网络数据
-(void)loadNetData
{
    [self.view showJiaZaiWithBool:YES WithAnimation:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        enjoyList = [[MCEnjoyList alloc] mj_setKeyValues:operation.responseString];
        for (MCEnjoyModel *model in enjoyList.product_list)
        {
            [dataArray addObject:model];
        }
        
        [MCenjoyTable reloadData];
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        [MCenjoyTable.footer endRefreshing];
        [MCenjoyTable.header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        [MCenjoyTable.footer endRefreshing];
        [MCenjoyTable.header endRefreshing];
    }];
}

#pragma mark -- tableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCEnjoyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCEnjoyCell"];
    
    if (dataArray.count > indexPath.row)
    {
        [cell setUIWithModel:dataArray[indexPath.row]];
    }
    

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280.0;
}

//导航栏透明度
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat naviAlpha = scrollView.contentOffset.y/150.0;
    self.navigationController.navigationBar.alpha = naviAlpha;
    
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
