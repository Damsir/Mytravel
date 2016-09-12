//
//  MCPracticeViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCPracticeViewController.h"
#import "MCPracticeCell.h"
#import "MCPracticeInfo.h"
#import "PracticeAdView.h"//广告
#import "MCDetailViewController.h"

@interface MCPracticeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    UICollectionView *MCCollection;
    NSMutableArray *dataArray;
    int page;
    NSString *url;
    MCPracticeInfo *pricticeInfo;
}
@end

@implementation MCPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"每日精选游记";
    dataArray = [NSMutableArray array];
    page = 0;
    url = [NSString stringWithFormat:MCPRACTICE_API,page];
    
    [self createCollectionView];
    [self loadNetData];

}
-(void)createCollectionView
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    scroll.delegate = self;
    [self.view addSubview:scroll];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    MCCollection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    MCCollection.backgroundColor = [UIColor colorWithRed:216/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    MCCollection.delegate = self;
    MCCollection.dataSource = self;
    [scroll addSubview:MCCollection];
    
    [MCCollection registerClass:[MCPracticeCell class] forCellWithReuseIdentifier:@"MCPracticeCell"];
    
    UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    naView.backgroundColor = [UIColor colorWithRed:32/255.0 green:176/255.0 blue:226/255.0 alpha:1];
    naView.tag = 200;
    naView.alpha = 0;
    [self.view addSubview:naView];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"游记列表";
    lab.center = CGPointMake(SCREENWIDTH/2.0, 40);
    [naView addSubview:lab];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    

    __weak typeof (*&self)weakSelf = self;
    //上拉刷新,下来加载更多
    MCCollection.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 0;
        url = [NSString stringWithFormat:MCPRACTICE_API,page];
        [dataArray removeAllObjects];
        [weakSelf loadNetData];
    }];
    
    MCCollection.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page++;
        url = [NSString stringWithFormat:MCPRACTICE_API,page];
        [weakSelf loadNetData];
    }];
}
#pragma mark -- 返回方法
-(void)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-- 加载网络数据
-(void)loadNetData
{
    //加载提示框
    [self.view showJiaZaiWithBool:YES WithAnimation:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        pricticeInfo = [[MCPracticeInfo alloc] mj_setKeyValues:operation.responseString];
       
        for (MCPracticemodel *model in pricticeInfo.hot_spot_list)
        {
            [dataArray addObject:model];
        }
        
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        [MCCollection reloadData];
        [MCCollection.header endRefreshing];
        [MCCollection.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        [MCCollection.header endRefreshing];
        [MCCollection.footer endRefreshing];
        
    }];
    
}

#pragma mark--UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
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

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCPracticeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCPracticeCell" forIndexPath:indexPath];
    //安全性判断
    if (dataArray.count > indexPath.row)
    {
        [cell setCellWithInfo:dataArray[indexPath.row]];
        PracticeAdView *adView = [[PracticeAdView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 170)];
        [MCCollection addSubview:adView];
    }
    return cell;
}

#pragma mark -- collectionView点击代理事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCDetailViewController *detaiVC = [[MCDetailViewController alloc] init];
    //***要做一下处理,因为只有11个数据每组,所以需要y%12***
    detaiVC.spot_id = [NSString stringWithFormat:@"%@",[pricticeInfo.hot_spot_list[indexPath.row%12] spot_id]];
    
    [self presentViewController:detaiVC animated:YES completion:nil];
}

//每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width-30)/2.0, 190);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(180, 10, 0, 10);
}

//导航栏透明度
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIView *naView = (id)[self.view viewWithTag:200];
    CGFloat naviAlpha = scrollView.contentOffset.y / 150.0;
    naView.alpha = naviAlpha;
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
