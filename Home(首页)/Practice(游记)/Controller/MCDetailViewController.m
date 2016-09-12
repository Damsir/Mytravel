//
//  MCDetailViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCDetailViewController.h"
#import "MCDetailInfo.h"
#import "MCDetailCell.h"
#import "PracticeHeader.h"

@interface MCDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,PracticeHeaderDelegate,UMSocialUIDelegate>

{
    MCDetailInfo *DetailInfo;
    UITableView *MCDetailTable;
    NSMutableArray *dataArray;
    NSString *url;
    PracticeHeader *header;
}

@end

@implementation MCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    dataArray = [NSMutableArray array];

    [self createUI];
    [self loadNetData];
}
#pragma mark -- 界面
-(void)createUI
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    scroll.delegate = self;
    [self.view addSubview:scroll];
    
    MCDetailTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    MCDetailTable.tableFooterView = [[UIView alloc] init];
    MCDetailTable.dataSource =self;
    MCDetailTable.delegate = self;
    [scroll addSubview:MCDetailTable];
    [MCDetailTable registerClass:[MCDetailCell class] forCellReuseIdentifier:@"MCDetailCell"];
    
    UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    naView.backgroundColor = [UIColor colorWithRed:32/255.0 green:176/255.0 blue:226/255.0 alpha:1];
    naView.tag = 100;
    naView.alpha = 0;
    [self.view addSubview:naView];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"游记详情欣赏";
    lab.center = CGPointMake(SCREENWIDTH/2.0, 40);
    [naView addSubview:lab];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    header = [[PracticeHeader alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
    header.delegate = self;
    
    url = [NSString stringWithFormat:@"%@%@",MCPRACTICEDETAIL_API,_spot_id];
    
    //分享
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-50, 20, 40, 40)];
    [shareBtn setImage:[UIImage imageNamed:@"detail_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(sharePractice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}

#pragma mark -- 分享
-(void)sharePractice
{
    NSString *share_url = [NSString stringWithFormat:@"http://web.breadtrip.com/%@",DetailInfo.spot.share_url];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"564d338fe0f55a9b9f009196" shareText:share_url shareImage:[UIImage imageNamed:@"login"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone, UMShareToRenren,UMShareToSina,UMShareToTencent,nil] delegate:self];
    
}
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if(response.responseCode== UMSResponseCodeSuccess)
    {
        NSLog(@"分享成功");
    }
}

#pragma mark -- header的代理方法(高度)
-(void)reloadHeaderHeight:(CGFloat)height
{
    [header setFrame:CGRectMake(0, 0, SCREENHEIGHT, height)];
    MCDetailTable.tableHeaderView = header;
}

#pragma mark -- 返回方法
-(void)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 加载网络数据
-(void)loadNetData
{
    [self.view showJiaZaiWithBool:YES WithAnimation:NO];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DetailInfo = [[MCDetailInfo alloc] mj_setKeyValues:operation.responseString];
        
        for (MCDetailModel *model in DetailInfo.spot.detail_list)
        {
            [dataArray addObject:model];
        }
        
        [MCDetailTable reloadData];
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        
    }];
}

#pragma mark -- tableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCDetailCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (dataArray.count > indexPath.row)
    {
        [cell setCellWithModel:dataArray[indexPath.row]];
        [header setHeaderWithTarget:DetailInfo.spot andUser:DetailInfo.user];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCDetailModel *model = dataArray[indexPath.row];
    if(!model.text)
    {
        return 190.0;
    }
    else 
    {
        return 240.0;
    }
}

//导航栏透明度
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = MCDetailTable.contentOffset.y;
    
    UIView *naView = (id)[self.view viewWithTag:100];
    CGFloat naviAlpha = scrollView.contentOffset.y/150.0;
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
