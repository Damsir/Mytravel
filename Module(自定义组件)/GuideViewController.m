//
//  GuideViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/1.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"

@interface GuideViewController ()

@property(nonatomic,strong) NSMutableArray *imagesArray;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) UIImageView *imageView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadData];
    [self createUI];
   
}
-(void)loadData
{
    _imagesArray = [NSMutableArray array];
    for (int i=0; i<5; i++)
    {
        //获得图片的包路径
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"guide%d@2x",i+2] ofType:@"png"];
        //通过读取路径的方式获取图片
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [_imagesArray addObject:image];
    }
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.userInteractionEnabled = YES;
    _imageView.image = _imagesArray[0];
    [self.view addSubview:_imageView];

    if (!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.8 target:self selector:@selector(createGuideView) userInfo:nil repeats:YES];
    }
}

-(void)createGuideView
{
    static NSInteger index = 1;

    _imageView.image = _imagesArray[index];
    index++;
    if (index == 5)
    {
        index = 0;
    }
    
    CATransition *transition = [CATransition animation];
    transition.duration = 3.0;
    transition.type = @"rippleEffect";
    transition.subtype = kCATransitionFromRight;
    [self.view.layer addAnimation:transition forKey:@"animation"];
}
-(void)createUI
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 200, 70);
    button.center = CGPointMake(SCREENWIDTH/2.0, SCREENHEIGHT-90);
    [button setBackgroundImage:[UIImage imageNamed:@"welcome"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
    [button addTarget:self action:@selector(GoMainViewController) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:button];
    
}
//切换到主视图
-(void)GoMainViewController
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"isFirst"];
    [defaults synchronize];
    
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [UIView animateWithDuration:2.0 animations:^{
        
        _imageView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [delegate changeRootView];
        [_imageView removeFromSuperview];
    
    }];
    
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
