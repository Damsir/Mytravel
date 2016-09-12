//
//  MCScrollView.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/5.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCScrollView.h"
#import "MCRecommendModel.h"
#import "AdvertiseView.h"

@interface MCScrollView()<UIScrollViewDelegate>

{
    UIScrollView *scroll;
    NSTimer *timer;
    NSInteger timeIndex;//记录当前是哪个广告
    NSMutableArray *dataArray;
}

@end

@implementation MCScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createCategoryView];
    }
    return self;
}

-(void)createCategoryView
{
    UIImageView *placeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 180)];
    placeView.image = [UIImage imageNamed:@"placeholder_h"];
    placeView.userInteractionEnabled = YES;
    [self addSubview:placeView];
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 180)];
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.bounces = NO;
    scroll.delegate = self;
    [self addSubview:scroll];
    
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 180, self.bounds.size.width, 90)];
    backView.image = [UIImage imageNamed:@"appdetail_background"];
    backView.userInteractionEnabled = YES;
    [self addSubview:backView];
    

    NSArray *titleArray = @[@"看游记",@"选景点",@"带你玩",@"抢折扣"];
    NSArray *imageArray = @[@"vacation_product_detail_img",@"vacation_vacation_index_img",@"s_order_detail_btn_car",@"s_order_detail_btn_card"];
    for (int i=0; i<4; i++)
    {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.08*SCREENWIDTH+i*0.92*SCREENWIDTH/4.0, 5, 0.75*SCREENWIDTH/4.0, 66);
        [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(58, -65, -13, 0);
        [backView addSubview:btn];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}
//加载广告页面
-(void)setAdiverseWithData:(NSArray *)array
{
    dataArray = [NSMutableArray arrayWithArray:array];
    for (int i=0 ; i<array.count; i++)
    {
        MCRecommendModel *model = array[i];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH * i, 0, SCREENWIDTH, 180)];
        imageV.userInteractionEnabled = YES;
        [imageV setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"placeholder_h"]];
        scroll.contentSize = CGSizeMake(SCREENWIDTH * array.count, 0);
        [scroll addSubview:imageV];
    }
    
    [self createPageControl];//page显示
    
    if (!timer)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(circleScroll) userInfo:nil repeats:YES];
        timeIndex = 1;
    }
    
}

-(void)circleScroll
{
    CATransition *animation = [CATransition animation];
    animation.type = @"cube";
    animation.duration = 0.5;
    
    if (dataArray.count>0 && timeIndex<dataArray.count)
    {
        scroll.contentOffset=CGPointMake(timeIndex*self.frame.size.width,0);
    }
    else if (timeIndex >= dataArray.count)
    {
        scroll.contentOffset = CGPointMake((timeIndex%dataArray.count) * SCREENWIDTH, 0);
    }
    animation.subtype = kCATransitionFromRight;
    [scroll.layer addAnimation:animation forKey:nil];
    
    UIPageControl *pageControl = (UIPageControl *)[self viewWithTag:200];
    pageControl.currentPage = scroll.contentOffset.x/scroll.frame.size.width;
    
    timeIndex++;
}

-(void)createPageControl
{
    //设置坐标点的时候,x为0,宽度设为屏幕宽度即可,会居中显示
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scroll.frame.size.height-40, self.frame.size.width, 40)];
    //pageControl点的数量
    pageControl.numberOfPages = dataArray.count;
    //设置当前点的所在位置
    pageControl.currentPage = 0;
    //设置当前点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //设置没有选中的点的颜色
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //当点击左右的时候设置选中的点不会动
    pageControl.userInteractionEnabled = NO;
    pageControl.tag = 200;
    [self addSubview:pageControl];
}

#pragma mark -- 按钮的选择事件

-(void)selectedButton:(UIButton *)btn
{
    if (_block)
    {
        _block(btn.tag-100);
    }
    
}

@end
