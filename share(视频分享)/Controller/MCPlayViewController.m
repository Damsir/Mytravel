//
//  MCPlayViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/9.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCPlayViewController.h"
// 导入播放视频的头文件
#import <MediaPlayer/MediaPlayer.h>

@interface MCPlayViewController ()<UMSocialUIDelegate>

{
    MPMoviePlayerViewController *_player;
}

@end

@implementation MCPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    self.title = @"视频详情";
    [self createUI];
    
}

-(void)createUI
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"视频详情";
    self.navigationItem.titleView = lab;
    
    UIImageView *playView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 250)];
    playView.center = CGPointMake(SCREENWIDTH/2.0, SCREENHEIGHT/2.0-30);
    [playView setImageWithURL:[NSURL URLWithString:self.playImageUrl] placeholderImage:[UIImage imageNamed:@"placeholder_h"]];
    playView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVideo:)];
    [playView addGestureRecognizer:tap];
    [self.view addSubview:playView];
    
    UIImageView *playImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    playImg.center = playView.center;
    playImg.image = [UIImage imageNamed:@"love_Play_Icon"];
    playImg.userInteractionEnabled = YES;
    [playImg addGestureRecognizer:tap];
    [self.view addSubview:playImg];
    
    //分享
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"s_detail_share_normal_blue"] style:UIBarButtonItemStyleDone target:self action:@selector(shareVideo)];

}
#pragma mark -- 视频分享
-(void)shareVideo
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"564d338fe0f55a9b9f009196" shareText:self.playVideoUrl shareImage:[UIImage imageNamed:@"login"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone,UMShareToRenren,UMShareToSina,UMShareToTencent,nil] delegate:self];

}
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if(response.responseCode== UMSResponseCodeSuccess)
    {
        NSLog(@"分享成功");
    }
}


//播放视频
-(void)playVideo:(UITapGestureRecognizer *)tap
{
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    _player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.playVideoUrl]];
    _player.view.frame = CGRectMake(0, 0, SCREENHEIGHT, SCREENWIDTH);
    _player.view.center = CGPointMake(SCREENWIDTH/2.0, SCREENHEIGHT/2.0);
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
    [_player.view setTransform:transform];
    [self.view addSubview:_player.view];
    
    
    // 视频播放完的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}


// 视频播放完成移除视图控制器,和视频播放注册的通知
- (void)myMovieFinishedCallback:(NSNotification *)tifi
{
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    MPMoviePlayerController *player = [tifi object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [player stop];
    [player.view removeFromSuperview];
    
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
