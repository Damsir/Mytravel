//
//  MCWeatherViewController.m
//  TravelFun
//
//  Created by 吴定如 on 15/11/26.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCWeatherViewController.h"
#import "MJExtension.h"
#import "MCWeatherModel.h"

@interface MCWeatherViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{
    UITableView *cityTable;
    MCWeatherModel *weatherModel;
    NSMutableArray *provinceArray;//省
    NSMutableArray *cityArray;//城市数组
    NSMutableArray *sectionArray;//关闭收起分组
}

@end

@implementation MCWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self loadData];
}
-(void)createUI
{
    UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    naView.backgroundColor = [UIColor colorWithRed:32/255.0 green:176/255.0 blue:226/255.0 alpha:1];
    naView.tag = 100;
    [self.view addSubview:naView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"iconfont-back-1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"选取城市";
    lab.center = CGPointMake(SCREENWIDTH/2.0, 40);
    [naView addSubview:lab];
    
    UIButton *SeachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    SeachBtn.frame = CGRectMake(0, 0, 40, 30);
    SeachBtn.center = CGPointMake(SCREENWIDTH-30, 40);
    [SeachBtn setTitle:@"搜索" forState:UIControlStateNormal];
    SeachBtn.tag = 201;
    [SeachBtn addTarget:self action:@selector(CreateSeachBar) forControlEvents:UIControlEventTouchUpInside];
    [naView addSubview:SeachBtn];
    
    
    cityTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:UITableViewStylePlain];
    cityTable.dataSource = self;
    cityTable.delegate = self;
    cityTable.tableFooterView = [[UIView alloc] init];
    //右侧条的颜色
    cityTable.sectionIndexBackgroundColor = [UIColor clearColor];
    //索引标题的颜色
    cityTable.sectionIndexColor = [UIColor orangeColor];

    [self.view addSubview:cityTable];
    
}
//创建搜索栏
-(void)CreateSeachBar
{
    UIView *naView  = (id)[self.view viewWithTag:100];
    UIButton *seachBtn = (id)[naView viewWithTag:201];
    seachBtn.hidden = YES;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0.7*SCREENWIDTH, 30)];
    textField.center = CGPointMake(SCREENWIDTH/2.0, 40);
    textField.placeholder = @"搜索城市中文名称或者拼音...";
    textField.delegate = self;
    textField.clearsContextBeforeDrawing = YES;
    textField.tag = 200;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.returnKeyType = UIReturnKeySearch;
    [naView addSubview:textField];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 40, 30);
    cancelBtn.center = CGPointMake(SCREENWIDTH-30, 40);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(Cancel:) forControlEvents:UIControlEventTouchUpInside];
    [naView addSubview:cancelBtn];
}
//取消事件
-(void)Cancel:(UIButton *)btn
{
    UIView *naView  = (id)[self.view viewWithTag:100];
    UIButton *seachBtn = (id)[naView viewWithTag:201];
    seachBtn.hidden = NO;
    UITextField *textField = (id)[self.view viewWithTag:200];
    [textField endEditing:YES];
    [textField removeFromSuperview];
    [btn removeFromSuperview];
}
//返回
-(void)Back
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        _wetherBlock(weatherModel.model);
        
    }];
}

-(void)loadData
{
    cityArray = [NSMutableArray array];
    sectionArray = [NSMutableArray array];
    //省
    NSString *path = [[NSBundle mainBundle] pathForResource:@"provinces" ofType:@"plist"];
    provinceArray = [NSMutableArray arrayWithContentsOfFile:path];
    //市区
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    NSDictionary *dic =[NSDictionary dictionaryWithContentsOfFile:path2];
    
    for (int i=0; i<provinceArray.count; i++)
    {
        NSArray *array = [dic objectForKey:provinceArray[i]];
        [cityArray addObject:array];
        //收起展开分组标记
        NSString *str = @"1";
        [sectionArray addObject:str];
    }
    
}

#pragma mark -- tableView代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return provinceArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *markStr = sectionArray[section];
    if ([markStr isEqualToString:@"1"])
    {
        return [cityArray[section] count];
    }
    else
    {
        return 0;
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = cityArray[indexPath.section][indexPath.row];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return provinceArray[section];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20)];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    //label.text = @[@"A",@"A1",@"B",@"C",@"F",@"G",@"G1",@"G2",@"G3",@"H",@"H1",@"H2",@"H3",@"H4",@"H5",@"J",@"J1",@"J2",@"L",@"N",@"N1",@"Q",@"S",@"S1",@"S2",@"S3",@"S4",@"T",@"F1",@"X",@"X1",@"X2",@"Y",@"Z"][section];
    label.text = provinceArray[section];
    label.textColor = [UIColor orangeColor];
    [view addSubview:label];
    view.tag = section;
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openOrClose:)];
    [view addGestureRecognizer:tap];
    
     return view;
}
-(void)openOrClose:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    NSString *markStr = sectionArray[view.tag];
    if ([markStr isEqualToString:@"1"])
    {
        [sectionArray replaceObjectAtIndex:view.tag withObject:@"0"];
    }
    else
    {
        [sectionArray replaceObjectAtIndex:view.tag withObject:@"1"];
    }
    
    [cityTable reloadData];
}


//右侧索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return provinceArray;
}

#pragma mark -- 天气查询方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *text = cityArray[indexPath.section][indexPath.row];
    NSString *httpArg = [NSString stringWithFormat:@"cityname=%@",text];
    NSString *url = [[NSString alloc] initWithFormat:@"%@?%@",MCWEATHER_API,httpArg];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"32d8ea3372029f92c5268aaae8d41157" forHTTPHeaderField:@"apikey"];
    
    [self.view showJiaZaiWithBool:YES WithAnimation:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        weatherModel = [[MCWeatherModel alloc] mj_setKeyValues:operation.responseString];
        //隐藏加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        
        
        //数据加载成功返回上一个界面
        if (weatherModel)
        {
            [self dismissViewControllerAnimated:YES completion:^{
                
                _wetherBlock(weatherModel.model);
    
            }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //隐藏加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        
    }];
    
    [operation start];
    
}

#pragma mark -- 搜索功能
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //删除空格
    NSString *text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *httpArg = [NSString stringWithFormat:@"cityname=%@",text];
    NSString *url = [[NSString alloc] initWithFormat:@"%@?%@",MCWEATHER_API,httpArg];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"32d8ea3372029f92c5268aaae8d41157" forHTTPHeaderField:@"apikey"];
    
    [self.view showJiaZaiWithBool:YES WithAnimation:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        weatherModel = [[MCWeatherModel alloc] mj_setKeyValues:operation.responseString];
        //隐藏加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        
        //数据加载成功返回上一个界面
        if (weatherModel)
        {
            [self dismissViewControllerAnimated:YES completion:^{
                
                _wetherBlock(weatherModel.model);
                
            }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //隐藏加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
        
    }];
    
    [operation start];
    
    [textField endEditing:YES];
    textField.text = nil;
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
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
