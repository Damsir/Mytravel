//
//  TicketDetailViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "TicketDetailViewController.h"
#import "TicketDetailList.h"
#import "DetailHeader.h"
#import "DetailTableViewCell.h"

@interface TicketDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

{
    TicketDetailList *ticketList;
    UITableView *detailTable;
    DetailHeader *header;
}

@end

@implementation TicketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTicketTable];
    [self loadNetData];
}

-(void)createTicketTable
{
    detailTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    detailTable.tableFooterView = [[UIView alloc] init];
    detailTable.dataSource = self;
    detailTable.delegate = self;
    [self.view addSubview:detailTable];
    detailTable.rowHeight = 150.0;
    [detailTable registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DetailTableViewCell"];
    
    header = [[DetailHeader alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 210)];
    detailTable.tableHeaderView = header;
    
    UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    naView.backgroundColor = [UIColor colorWithRed:32/255.0 green:176/255.0 blue:226/255.0 alpha:1];
    naView.tag = 200;
    naView.alpha = 0;
    [self.view addSubview:naView];
    //标题
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"票务详情";
    lab.center = CGPointMake(SCREENWIDTH/2.0, 40);
    [naView addSubview:lab];
    //返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"iconfont-back-1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    //分享
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-50, 20, 40, 40)];
    [shareBtn setImage:[UIImage imageNamed:@"detail_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareTicket) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}

#pragma mark -- 分享
-(void)shareTicket
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"564d338fe0f55a9b9f009196" shareText:ticketList.data.tourUrl shareImage:[UIImage imageNamed:@"login"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone, UMShareToRenren,UMShareToSina,UMShareToTencent,nil] delegate:self];
    
}
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if(response.responseCode== UMSResponseCodeSuccess)
    {
        NSLog(@"分享成功");
    }
}

//返回
-(void)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadNetData
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:[NSString stringWithFormat:MCTICKETDETAIL_API,_tour_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         ticketList = [[TicketDetailList alloc] mj_setKeyValues:operation.responseString];
         
         [detailTable reloadData];
         [self.view showJiaZaiWithBool:NO WithAnimation:NO];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [self.view showJiaZaiWithBool:NO WithAnimation:NO];
         
     }];

}

#pragma mark--UICollectionViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (ticketList)
    {
        return 4;
    }
    else{
        return 0;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (ticketList)
    {
        [header setHeaderViewWithInfo:ticketList.data];
        
        if (indexPath.row == 0)
        {
            cell.title.text = @"产品描述";
            cell.detail.text = ticketList.data.Description;
        }
        else if (indexPath.row == 1)
        {
            cell.title.text = @"使用方法";
            cell.detail.text = ticketList.data.usageProfile;
        }
        else if (indexPath.row == 2)
        {
            cell.title.text = @"退改说明";
            cell.detail.text = ticketList.data.cancel_policy;
        }
        else
        {
            cell.title.text = @"注意事项";
            cell.detail.text = ticketList.data.attentionProfile;
        }
    }
    return cell;
}

//导航栏透明度
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIView *naView = (id)[self.view viewWithTag:200];
    CGFloat naviAlpha = scrollView.contentOffset.y / 100.0;
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
