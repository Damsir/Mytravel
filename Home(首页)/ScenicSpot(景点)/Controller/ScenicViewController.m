//
//  ScenicViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/13.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "ScenicViewController.h"
#import "MCSpotList.h"
#import "MCSpotCell.h"
#import "SpotDetailViewController.h"

@interface ScenicViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

{
    MCSpotList *spotList;
}
//搜索状态
@property(nonatomic,assign) BOOL isSearchState;

@property(nonatomic,strong) UITableView *table;


@end

@implementation ScenicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self createSeachUI];
}
-(void)createSeachUI
{
    UISearchBar *SearchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    SearchBar.placeholder = @"搜索旅游景点(中文拼音)、景区...";
    SearchBar.delegate = self;
    SearchBar.clearsContextBeforeDrawing = YES;
    SearchBar.showsCancelButton = YES;
    SearchBar.searchBarStyle = UISearchBarStyleDefault;
    SearchBar.tag = 100;
    [SearchBar sizeToFit];
    self.navigationItem.titleView = SearchBar;
   
    
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.table.tableFooterView = [[UIView alloc] init];
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.view addSubview:self.table];
    
    [self.table registerClass:[MCSpotCell class] forCellReuseIdentifier:@"MCSpotCell"];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"back_image"];
    image.userInteractionEnabled = YES;
    [self.view addSubview:image];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 100, 20)];
    lab.text = @"热搜景点:";
    [self.view addSubview:lab];
    
    NSArray *titlesArray = @[@"xihu",@"wudangshan",@"gugong",@"shapotou",@"taishan",@"budalagong",@"fenghuang",@"gulangyu",@"wujiashan",@"guilin",@"sanya",@"yuhuadong",@"huashan",@"leshandafo",@"zhangye"];
    for (int i=0; i<5; i++)
    {
        for (int j= 0; j<3; j++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat w = (SCREENWIDTH-290)/2.0;
            btn.frame = CGRectMake(20+j*(w+80), 110+i*40, 80, 30);
            [btn setTitle:titlesArray[3*i+j] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor blueColor].CGColor;
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            btn.tag = 3*i+j;
            [btn addTarget:self action:@selector(selectedTitle:) forControlEvents:UIControlEventTouchUpInside];
            [image addSubview:btn];
        }
    }
}
#pragma mark -- 按钮选择事件
-(void)selectedTitle:(UIButton *)btn
{
    _isSearchState = YES;
    NSString *text = btn.titleLabel.text;
    UISearchBar *searchBar = (id)[self.navigationItem.titleView viewWithTag:100];
    searchBar.text = text;
    [searchBar resignFirstResponder];
    //调用searchBar的文字改变代理
    [self searchBarSearchButtonClicked:searchBar];
}

#pragma mark -- tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (spotList.result && _isSearchState == YES)
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
    MCSpotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCSpotCell"];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (spotList)
    {
        cell.spot = spotList;
        [cell setCellWithSpot:spotList];
    }
    
    return cell;
}

#pragma mark -- 搜索功能
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //搜索时将tableView移动上层
    [self.view bringSubviewToFront:self.table];
    [searchBar resignFirstResponder];
     _isSearchState = YES;
    //删除空格
    NSString *text = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *httpArg = [NSString stringWithFormat:@"id=%@&output=json",text];
    NSString *url = [[NSString alloc] initWithFormat:@"%@?%@",MCSpot_API,httpArg];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"32d8ea3372029f92c5268aaae8d41157" forHTTPHeaderField:@"apikey"];

    [self.view showJiaZaiWithBool:YES WithAnimation:YES];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        spotList = [[MCSpotList alloc] mj_setKeyValues:operation.responseString];
        //隐藏加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        [self.table reloadData];
        if (!spotList.result)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"很抱歉,没搜到哦,请尝试搜索其他的景点" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //隐藏加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
    
    }];
    
    [operation start];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
#pragma mark -- 取消按钮点击事件
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //结束搜索时将tableView移动底层
    [self.view sendSubviewToBack:self.table];
    _isSearchState = NO;
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    spotList = [MCSpotList new];
    [self.table reloadData];
}

#pragma mark -- Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpotDetailViewController *detailVC = [[SpotDetailViewController alloc] init];
    detailVC.spot = spotList;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
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
