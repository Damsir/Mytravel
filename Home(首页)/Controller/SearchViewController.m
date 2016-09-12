//
//  SearchViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/14.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "SearchViewController.h"
#import "MCHotModel.h"
#import "MCHotViewCell.h"
#import "MCAdViewController.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

//搜索状态
@property(nonatomic,assign) BOOL isSearchState;
//搜索结果数组
@property(nonatomic,strong) NSMutableArray *searchResult;
@property(nonatomic,strong) UITableView *table;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _searchResult = [NSMutableArray array];
    [self createSeachUI];
    
    UINib *nib = [UINib nibWithNibName:@"MCHotViewCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"1507"];
}

-(void)createSeachUI
{
    UISearchBar *SearchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    SearchBar.placeholder = @"搜索游趣目的地、景点...";
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

    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"backImage"];
    image.userInteractionEnabled = YES;
    [self.view addSubview:image];

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 100, 20)];
    lab.text = @"热搜:";
    [self.view addSubview:lab];
    
    NSArray *titlesArray = @[@"英国",@"美国",@"希腊",@"德国",@"阿里",@"厦门",@"九寨沟",@"意大利",@"韩国",@"日本",@"台湾",@"曼谷"];
    for (int i=0; i<4; i++)
    {
        for (int j= 0; j<3; j++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat w = (SCREENWIDTH-240)/2.0;
            btn.frame = CGRectMake(30+j*(w+60), 110+i*40, 60, 25);
           [btn setTitle:titlesArray[3*i+j] forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor orangeColor].CGColor;
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
           [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            btn.tag = 3*i+j;
            [btn addTarget:self action:@selector(selectedTitle:) forControlEvents:UIControlEventTouchUpInside];
           [image addSubview:btn];
        }
    }
}

#pragma mark -- btn事件
-(void)selectedTitle:(UIButton *)btn
{
    _isSearchState = YES;
    //删除空格
    NSString *title = [btn.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    UISearchBar *seachBar = (id) [self.navigationItem.titleView viewWithTag:100];
    seachBar.text = title;
    //调用searchBar的文字改变代理
    [self searchBar:seachBar textDidChange:title];
    
}

#pragma mark -- tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearchState)
    {
        return _searchResult.count;
    }
    else
    {
        return 0;
    }
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCHotViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1507"];
    
    if (_isSearchState)
    {
        [cell setUIWithInfoModel:_searchResult[indexPath.row]];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCAdViewController *adVC = [[MCAdViewController alloc] init];
    adVC.URL =[self.dataArray[indexPath.row] bookUrl];
    [self.view.window.rootViewController presentViewController:adVC animated:YES completion:nil];
}

#pragma mark--实现searchBar的搜索结果
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(nonnull NSString *)searchText
{
    [self.view bringSubviewToFront:self.table];
    _isSearchState = YES;
    //清除上一次的搜索结果
    [_searchResult removeAllObjects];
    
    //数据源通过搜索字符搜索匹配
    for (MCHotModel *model in self.dataArray)
    {
        NSRange range = [model.title rangeOfString:searchText];
        
        if (range.location != NSNotFound)
        {
            [_searchResult addObject:model];
        }
    }
    //数据匹配查找完成,刷新table
    [self.table reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view sendSubviewToBack:self.table];
    searchBar.text = @"";
    //注销第一响应者
    [searchBar resignFirstResponder];
    //改变状态为非搜索状态
    _isSearchState = NO;
    //移除数据
    [_searchResult removeAllObjects];
    [self.table reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    //注销第一响应者
    [searchBar resignFirstResponder];
    [self.table reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240.0;
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
