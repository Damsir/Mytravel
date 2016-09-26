//
//  ViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/27.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "ViewController.h"
//Views
#import "MCScrollView.h"
#import "MCFindView.h"
#import "MCDiscountView.h"
#import "MCHotViewCell.h"
#import "AdvertiseView.h"
//Model
#import "MCInfoList.h"
#import "MCRecommendModel.h"
//Contrller
#import "MCAdViewController.h"
#import "MCDiscountController.h"
#import "SearchViewController.h"
#import "MCEnjoyViewController.h"
#import "MCPracticeViewController.h"
#import "ScenicViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MCInfoList *InfoList;
    
    MCRecommendInfo *recommendInfo;
}

//table的headView
@property(nonatomic,strong) UIView *headView;
//广告数组
@property(nonatomic,strong) NSMutableArray *ADArray;
@property(nonatomic,strong) MCScrollView *MCscroll;
@property(nonatomic,strong) MCFindView *MCfindview;
@property(nonatomic,strong) MCDiscountView *MCdiscountView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //关闭自适应
    //self.automaticallyAdjustsScrollViewInsets  = NO ;
    
    [self initNavigationBarTitle:@"游趣首页"];
    
    UINib *nib = [UINib nibWithNibName:@"MCHotViewCell" bundle:nil];
    [self.MCTable registerNib:nib forCellReuseIdentifier:@"MCHotViewCell"];
    
    [self loadNetData];
    [self createUI];
    [self createSearchBar];
    
    //在向上滑动的时候 导航栏(隐藏)
    self.navigationController.hidesBarsOnSwipe = YES;
    
}
#pragma mark--加载数据
//重写父类的下拉刷新
-(void)headerRefresh
{
    [self loadNetData];
}
//重写父类的上拉加载更多
-(void)footerLoadMore
{
    //加载提示框
    [self.view showJiaZaiWithBool:YES WithAnimation:YES];
    
    //标记是此控制器的请求
    self.index = 1;
    
    __weak typeof (*&self)weakSelf = self;
    
    [weakSelf loadMoreYouQuNetDataToInfo:^(BOOL isSuccess, NSError *error) {
        
        if (isSuccess)
        {
            [weakSelf.MCTable.footer endRefreshing];
            [weakSelf.MCTable reloadData];
            
        }
        //隐藏加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        
    }];
    
}
-(void)loadNetData
{
    //加载提示框
    [self.view showJiaZaiWithBool:YES WithAnimation:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:MCRECOMMEND_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        recommendInfo = [[MCRecommendInfo alloc] initWithData:operation.responseData error:nil];
        //NSLog(@"%@",recommendInfo.slide);
        
        //游趣新发现
        [_MCfindview loadData:recommendInfo.subject];
        //游趣特价折扣
        [_MCdiscountView loadData:recommendInfo.discount];
        
        [_MCscroll setAdiverseWithData:recommendInfo.slide];
        
        
        //加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        [self.MCTable.header endRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"网络请求失败...");
    }];
    
    
    //标记是此控制器的请求
    self.index =1;
    
    __weak typeof (*&self)weakSelf = self;
    
    [weakSelf loadYouQuNetDataInfo:^(BOOL isSuccess, NSError *error) {
        
        if(isSuccess)
        {
            [self.MCTable.header endRefreshing];
            [self.MCTable reloadData];
            
        }
        //[self.view showJiaZaiWithBool:NO WithAnimation:NO];
    }];
    
}
#pragma mark -- 初始化界面
-(void)createUI
{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1065)];
    
    _MCscroll = [[MCScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 270)];
    __weak typeof (*&self)weakSelf = self;
    //分类按钮的回调代理点击事件
    _MCscroll.block = ^(NSInteger index)
    {
        [weakSelf selectedButtonItem:index];
        
    };
    [_headView addSubview:_MCscroll];
    
    
    _MCfindview = [[MCFindView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_MCscroll.frame), SCREENWIDTH, 305)];
    [_headView addSubview:_MCfindview];
    
    _MCdiscountView  = [[[NSBundle mainBundle] loadNibNamed:@"MCDiscountView" owner:nil options:nil] firstObject];
    _MCdiscountView.frame = CGRectMake(0, CGRectGetMaxY(_MCfindview.frame), SCREENWIDTH, 500);
    [_headView addSubview:_MCdiscountView];
    
    self.MCTable.rowHeight = 240;
    self.MCTable.tableHeaderView = _headView;
}


#pragma mark -- tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray)
    {
        return self.dataArray.count;
    }
    else
    {
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCHotViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCHotViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.dataArray.count > indexPath.row)
    {
        [cell setUIWithInfoModel:self.dataArray[indexPath.row]];
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @">>游趣热门列表";
}

//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCAdViewController *adVC = [[MCAdViewController alloc] init];
    adVC.URL =[self.dataArray[indexPath.row] bookUrl];
    NSLog(@"%@",adVC.URL);
    [self.view.window.rootViewController presentViewController:adVC animated:YES completion:nil];
}

#pragma mark -- 按钮选择分类的回调点击事件
-(void)selectedButtonItem:(NSInteger)index
{
    if (index == 0)
    {
        MCPracticeViewController *pricticeVC = [[MCPracticeViewController alloc] init];
        
        [self.view.window.rootViewController presentViewController:pricticeVC animated:YES completion:nil];
    }
    else if (index == 1)
    {
        ScenicViewController *scenVC = [[ScenicViewController alloc] init];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
        scenVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:scenVC animated:YES];
    }
    
    else if (index == 2)
    {
        MCEnjoyViewController *enjoyVC = [[MCEnjoyViewController alloc] init];
        enjoyVC.hidesBottomBarWhenPushed = YES;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"游趣首页" style:UIBarButtonItemStyleDone target:self action:nil];
        [self.navigationController pushViewController:enjoyVC animated:YES];
    }
    
    else if (index == 3)
    {
        MCDiscountController *discountVC = [[MCDiscountController alloc] init];
        discountVC.hidesBottomBarWhenPushed = YES;
        [self.view.window.rootViewController presentViewController:discountVC animated:YES completion:nil];
    }
}

#pragma mark -- 搜索
-(void)createSearchBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab_search_s"] style:UIBarButtonItemStyleDone target:self action:@selector(GotoSearch)];
}
-(void)GotoSearch
{
    
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    searchVC.dataArray = self.dataArray;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.alpha = 1.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
