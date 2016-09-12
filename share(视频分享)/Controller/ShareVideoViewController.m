//
//  ShareVideoViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/7.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "ShareVideoViewController.h"

//View
#import "MCShareViewCell.h"
#import "MCTopicViewCell.h"
//controller
#import "MCPlayViewController.h"
#import "MCScanViewController.h"
//库
#import <MediaPlayer/MediaPlayer.h>

@interface ShareVideoViewController ()<UITableViewDataSource,UITableViewDelegate,MCTopicViewCellDelegate,MCShareViewCellDelegate>
{
    MPMoviePlayerController *moviePlayer;//视频播放器
    NSTimer *timer;

}

@property(nonatomic,strong) UIScrollView *scroll;
@property(nonatomic,strong) UITableView *topicTable;
//@property(nonatomic,strong) UISearchBar *searchBar;

@end

@implementation ShareVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets  = YES ;
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self createHeader];
    [self createScan];
    //[self loadData];
   
    
    //注册自定义的cell
    [self.MCTable registerNib:[UINib nibWithNibName:@"MCTopicViewCell" bundle:nil] forCellReuseIdentifier:@"MCTopicViewCell"];
    [self.MCTable registerClass:[MCShareViewCell class] forCellReuseIdentifier:@"MCShareViewCell"];
    
}

-(void)createHeader
{
    //导航栏分类按钮
    NSArray *items = @[@"人气",@"精选"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    segment.frame = CGRectMake(100, 100, 100, 30);
    segment.layer.cornerRadius = 15;
    segment.clipsToBounds = YES;
    segment.layer.borderWidth = 1;
    segment.layer.borderColor = [UIColor whiteColor].CGColor;
    segment.selectedSegmentIndex = 0;
    segment.tag = 200;
    segment.tintColor = [UIColor whiteColor];
    [segment addTarget:self action:@selector(pressSegment:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    
    
    _scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scroll.userInteractionEnabled = YES;
    _scroll.contentSize = CGSizeMake(SCREENWIDTH * 2, 0);
    _scroll.contentOffset = CGPointMake(0, 0);
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.bounces = NO;
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
                
    self.MCTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadData];
}

#pragma mark -- 扫一扫
-(void)createScan
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 30, 40);
    [btn setImage:[UIImage imageNamed:@"扫一扫"] forState:UIControlStateNormal];
    [btn setTitle:@"扫一扫" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    btn.titleEdgeInsets=UIEdgeInsetsMake(30.0,-30.0,0,0);
    
    [btn addTarget:self action:@selector(Scan) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
}
-(void)Scan
{
    MCScanViewController *scanVC = [[MCScanViewController alloc] init];
    scanVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scanVC animated:YES];
}

#pragma mark -- 导航栏中间的按钮事件及scrollView的代理事件
-(void)pressSegment:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0)
    {
        _scroll.contentOffset = CGPointMake(0, 0);
        self.MCTable.frame = self.view.bounds;
        [_scroll addSubview:self.MCTable];
        
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        _scroll.contentOffset = CGPointMake(SCREENWIDTH, 0);
        self.MCTable.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT);
        [_scroll addSubview:self.MCTable];
    }
    [self loadData];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UISegmentedControl *segment = (UISegmentedControl *)[self.navigationItem.titleView viewWithTag:200];
    if (_scroll == scrollView)
    {
        if (scrollView.contentOffset.x == 0)
        {
            segment.selectedSegmentIndex = 0;
            [self.MCTable setFrame:self.view.bounds];
            [_scroll addSubview:self.MCTable];
        }
        else if (scrollView.contentOffset.x == SCREENWIDTH)
        {
            [segment setSelectedSegmentIndex:1];
            [self.MCTable setFrame: CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT)];
            [_scroll addSubview:self.MCTable];
        }
        [self loadData];
    }
}

#pragma mark--加载数据
//重写父类的下拉刷新
-(void)headerRefresh
{
    [moviePlayer.view removeFromSuperview];
    moviePlayer = nil;
    [self loadData];
}
//重写父类的上拉加载更多
-(void)footerLoadMore
{
    UISegmentedControl *segment = (UISegmentedControl *)[self.navigationItem.titleView viewWithTag:200];
    if (segment.selectedSegmentIndex == 0||_scroll.contentOffset.x == 0)
    {
        //标记是此控制器的请求
        self.index = 21;
    }
    else if (segment.selectedSegmentIndex ==1 || _scroll.contentOffset.x == SCREENWIDTH)
    {
        self.index = 22;
    }
   
    __weak typeof (*&self)weakSelf = self;
    
    [weakSelf loadMoreYouQuNetDataToInfo:^(BOOL isSuccess, NSError *error) {
        
        if (isSuccess)
        {
            [weakSelf.MCTable.footer endRefreshing];
            [weakSelf.MCTable reloadData];
        }
        //刷新完成,隐藏加载提示框
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
    }];
    
}
-(void)loadData
{
    [_scroll addSubview:self.MCTable];
    
    UISegmentedControl *segment = (UISegmentedControl *)[self.navigationItem.titleView viewWithTag:200];
    if (segment.selectedSegmentIndex == 0)
    {
        //标记是此控制器的请求
        self.index = 21;
        NSString *url = MCTOPICVIDEO_API;
        self.url = url;
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        //标记是此控制器的请求
        self.index = 22;
        NSString *url = MCSPECIALVIDEO_API;
        self.url = url;
    }
    

    __weak typeof (*&self)weakSelf = self;
    
    [weakSelf loadYouQuNetDataInfo:^(BOOL isSuccess, NSError *error) {
        
        if(isSuccess)
        {
            [self.MCTable.header endRefreshing];
            [self.MCTable reloadData];
        }
        
        [self.view showJiaZaiWithBool:NO WithAnimation:NO];
    }];
    
}

#pragma mark -- tableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 21)
    {
        MCTopicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCTopicViewCell"];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //安全性判断
        if (self.dataArray.count > indexPath.row)
        {
            SpecialVideoModel *model =self.dataArray[indexPath.row];
            cell.model = model;
            [cell setUIWithModel:model];
            if (indexPath.row == 0)
            {
                [cell.rankImage setImage:[UIImage imageNamed:@"rankNum0"]];
            }
            else if (indexPath.row == 1)
            {
                [cell.rankImage setImage:[UIImage imageNamed:@"rankNum1"]];
            }
            else if (indexPath.row == 2)
            {
                [cell.rankImage setImage:[UIImage imageNamed:@"rankNum2"]];
            }
        }
        return cell;
    }
    else if(self.index == 22)
    {
        MCShareViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCShareViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        //安全性判断
        if (self.dataArray.count > indexPath.row)
        {
            cell.model = self.dataArray[indexPath.row];
            [cell setUIWithModel:self.dataArray[indexPath.row]];
        }
        return cell;
    }
    return [[UITableViewCell alloc] init];;
}
//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 21)
    {
        return 370.0;
    }
    else
    {
        return 250.0;
    }
    
}
//cell点击播放视频事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击cell进入下个页面时注销播放器
    [moviePlayer.view removeFromSuperview];
     moviePlayer = nil;
    [timer invalidate];
  
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:nil];
    
    MCPlayViewController *playVC = [[MCPlayViewController alloc] init];
    playVC.playImageUrl = [self.dataArray[indexPath.row] videoCoverUrl];
    playVC.playVideoUrl = [self.dataArray [indexPath.row] playUrl];
    playVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playVC animated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.MCTable reloadData];//刷新playBtn图标
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark -- 视频当前页面播放

-(void)playVideoWithInView:(UIView *)view AndWithplayUrl:(NSString *)url AndWithImageUrl:(NSString *)image
{
    // 1.创建一个视频播放器
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url]];
    moviePlayer.movieSourceType = MPMovieSourceTypeUnknown;
    moviePlayer.controlStyle = MPMovieControlStyleNone;
   
    
    // 2.设置位置和大小
    moviePlayer.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    [view addSubview:moviePlayer.view];
    
    // 3.准备和开始播放
    [moviePlayer prepareToPlay];
    [moviePlayer play];
    
    // 4.设置播放等待动画
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:moviePlayer.view.bounds];
    [imageView setImageWithURL:[NSURL URLWithString:image]];
    //imageView.image = [UIImage imageNamed:@"my"];
    imageView.tag = 500 ;
    [moviePlayer.view addSubview:imageView];
    
    // 5.菊花
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] ;
    blackView.layer.cornerRadius = 10 ;
    blackView.center = moviePlayer.view.center;
    blackView.backgroundColor = [UIColor blackColor] ;
    blackView.alpha = 0.3f ;
    [imageView addSubview:blackView] ;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.center = moviePlayer.view.center;
    [activity startAnimating];
    [imageView addSubview:activity];
    
    // 6.进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(view.frame)-4, view.frame.size.width-30, 4)];
    progressView.tag = 501;
    progressView.progressTintColor = [UIColor redColor];
    progressView.trackTintColor = [UIColor whiteColor];
    [moviePlayer.view addSubview:progressView];
    
    // 7.注册一个监听者，监听加载完成和播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoLoadFinish:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}
#pragma mark -- 视频加载完成的方法
- (void)videoLoadFinish:(NSNotification *)noti
{
    UIImageView *imageView = (UIImageView *)[moviePlayer.view viewWithTag:500];
    [imageView removeFromSuperview];
    if (!timer)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(currentPlayTime:) userInfo:nil repeats:YES];
    }
}
#pragma mark -- 视频播放完成的方法
- (void)videoPlayFinish:(NSNotification *)noti
{
    MPMoviePlayerController *movie = [noti object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:movie];
    //视频播放完成销毁播放器
    [moviePlayer.view removeFromSuperview];
    [timer invalidate];
     moviePlayer = nil;
    
}
#pragma mark -- 视频播放进度的方法
- (void)currentPlayTime:(NSTimer *)timer
{
    UIProgressView *progress = (UIProgressView *)[moviePlayer.view viewWithTag:501];
    if (moviePlayer.currentPlaybackTime)
    {
        progress.progress = (CGFloat)moviePlayer.currentPlaybackTime/moviePlayer.duration;
    }
}

#pragma mark -- 当播放器滑出屏幕是销毁播放器
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //求出播放器在试图控制器上的位置
    CGRect rect = [moviePlayer.view convertRect:moviePlayer.view.bounds toView:self.view];
    // cell的高度--370
    if (rect.origin.y + 200 < 64 || rect.origin.y >SCREENHEIGHT-49)
    {
        [timer invalidate];
        [moviePlayer.view removeFromSuperview];
        moviePlayer = nil;
    }
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
