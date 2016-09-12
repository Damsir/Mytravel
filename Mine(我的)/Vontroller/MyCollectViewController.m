
//
//  MyCollectViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/3.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MyCollectViewController.h"
#import "CollectionCell.h"
#import "TicketDetailPage.h"

@interface MyCollectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myCollectTable;
    NSMutableArray *DBArray;
    BOOL selectedState;//编辑状态
    UIButton *editBtn;
}

@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selectedState = NO;
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.image = [UIImage imageNamed:@"Screenshot"];
    [self.view addSubview:backImage];
    [self judgeLoginOrNot];
    
}
//判断登录与否
-(void)judgeLoginOrNot
{
    // 判断用户是否是已经登录
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isLoginState = [[defaults objectForKey:@"isLoginState"] boolValue];
    if (isLoginState)
    {
        [self createMyCollectionTable];
    }
    else
    {
        UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
        naView.backgroundColor = [UIColor colorWithRed:32/255.0 green:176/255.0 blue:226/255.0 alpha:1];
        naView.tag = 200;
        [self.view addSubview:naView];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont boldSystemFontOfSize:18];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"我的收藏";
        lab.center = CGPointMake(SCREENWIDTH/2.0, 40);
        [naView addSubview:lab];
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未登录,请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}

-(void)createMyCollectionTable
{
    myCollectTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:UITableViewStylePlain];
    myCollectTable.tableFooterView = [[UIView alloc] init];
    myCollectTable.dataSource = self;
    myCollectTable.delegate = self;
    [self.view addSubview:myCollectTable];
    
    [myCollectTable registerClass:[CollectionCell class] forCellReuseIdentifier:@"CollectionCell"];
    
    UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    naView.backgroundColor = [UIColor colorWithRed:32/255.0 green:176/255.0 blue:226/255.0 alpha:1];
    naView.tag = 200;
    [self.view addSubview:naView];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"我的收藏";
    lab.center = CGPointMake(SCREENWIDTH/2.0, 40);
    [naView addSubview:lab];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    editBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-50, 20, 40, 40)];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editBtn];
    
    
    DBArray = [NSMutableArray arrayWithArray:[[DBManager sharedDBManager] recieveDBData]];
    if (DBArray.count == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的收藏夹空空如也,快去收藏吧" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
//返回
-(void)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//收藏编辑
-(void)edit:(UIButton *)btn
{
    if (selectedState)
    {
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [myCollectTable setEditing:NO animated:YES];
        selectedState = NO;
    }
    else{
        [editBtn setTitle:@"完成" forState:UIControlStateNormal];
        //开启tableView的编辑状态
        [myCollectTable setEditing:YES animated:YES];
        selectedState = YES;
    }
}

//这个函数调用之后,cell可以左滑出现删除按钮,并且删除的事件在这个方法中响应
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /************先删数据,后删cell**************/
    [[DBManager sharedDBManager] deleteDataWithDictionary:@{@"url":DBArray[indexPath.row][@"url"]}];//删除数据库的内容
    [DBArray removeObjectAtIndex:indexPath.row];//删除保存数据的数组
    //调用该方法
    [myCollectTable deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
}

#pragma mark -- tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"=====%@",DBArray);
    if (DBArray.count > 0)
    {
        return DBArray.count;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell"];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (DBArray.count > indexPath.row)
    {
        [cell setCellWithDataBaseArray:DBArray[indexPath.row]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketDetailPage *buyVC = [[TicketDetailPage alloc] init];
    buyVC.url = [DBArray[indexPath.row] objectForKey:@"url"];
    [self presentViewController:buyVC animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
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
