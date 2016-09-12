//
//  MCDiscountController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/12.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCDiscountController.h"
#import "MCDiscountCell.h"
#import "MCAdViewController.h"
#import "MCDiscountModel.h"

@interface MCDiscountController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *MCCollection;
    NSMutableArray *dataArray;
    int page;
    NSString *url;
    DiscountInfo *discountInfo;
}

@end

@implementation MCDiscountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    page = 1;
    url = [NSString stringWithFormat:@"%@&is_show_pay=%d&%@",ZHEKOUURLF,page,ZHEKOUURLS];

    [self createCollectionView];
    [self loadNetData];
    
    UINib *nib = [UINib nibWithNibName:@"MCDiscountCell" bundle:nil];
    [MCCollection registerNib:nib forCellWithReuseIdentifier:@"MCDiscountCell"];
}

-(void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //指定layout的滑动方向(垂直)
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    MCCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    MCCollection.backgroundColor = [UIColor colorWithRed:180/255.0 green:250/255.0 blue:254/255.0 alpha:1.0];
    
    MCCollection.delegate = self;
    MCCollection.dataSource = self;
    
    [self.view addSubview:MCCollection];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(BackHomePage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.center = CGPointMake(SCREENWIDTH/2, 40);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = @"折扣详情";
    [MCCollection addSubview:label];
    
    __weak typeof (*&self)weakSelf = self;
    //上拉刷新,下来加载更多
    MCCollection.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        url = [NSString stringWithFormat:@"%@&is_show_pay=%d&%@",ZHEKOUURLF,page,ZHEKOUURLS];
        [dataArray removeAllObjects];
        [weakSelf loadNetData];
    }];
    
    MCCollection.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page++;
        url = [NSString stringWithFormat:@"%@&is_show_pay=%d&%@",ZHEKOUURLF,page,ZHEKOUURLS];
        [weakSelf loadNetData];
    }];
    
}

#pragma mark -- 返回事件
-(void)BackHomePage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadNetData
{
    //加载提示框
    [self.view showJiaZaiWithBool:YES WithAnimation:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        discountInfo = [[DiscountInfo alloc] initWithData:operation.responseData error:nil];
        
        for (MCDiscountModel *model in discountInfo.data)
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
    MCDiscountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCDiscountCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    cell.clipsToBounds = YES;
    //安全性判断
    if (dataArray.count > indexPath.row)
    {
        [cell setCellWithInfo:dataArray[indexPath.row]];
    }
    return cell;
}
//每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width-30)/2.0, 200);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(64, 10, 10, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCAdViewController *adVC = [[MCAdViewController alloc] init];
    adVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    MCDiscountModel *info = dataArray[indexPath.row];
    adVC.URL = info.url;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"游趣首页" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self presentViewController:adVC animated:YES completion:nil];
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
