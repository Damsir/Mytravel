//
//  AdvertiseView.m
//  Advertisement
//
//  Created by 吴定如 on 15/10/24.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "AdvertiseView.h"
#import "UIImageView+AFNetworking.h"

@interface AdvertiseView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *adView;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSMutableArray *imageViews;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSTimer *timer;
//回调block,返回当前是第几页
@property (nonatomic,strong) void (^callBack)(NSInteger chooseIndex);

@end

@implementation AdvertiseView

-(instancetype)initWithFrame:(CGRect)frame withImagesURLArray:(NSArray *)imgUrlArray withCallBack:(void(^)(NSInteger chooseIndex))callBack
{
    if(self = [super initWithFrame:frame])
    {
        _images = imgUrlArray;
        _callBack = callBack;
        
        [self startScroll];
        [self configUI];
        [self createPageControl];
    }
    return self;
    
}
#pragma mark --  定时循环播放广告页
-(void)startScroll
{
    if(!_timer)
    {
        _timer  = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
}

-(void)timerRun
{
    [UIView animateWithDuration:0.5 animations:^{
        _adView.contentOffset = CGPointMake(_adView.bounds.size.width*2, 0);
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:_adView];
    }];
}

#pragma mark -- 创建界面
-(void)configUI
{
    //获取当前第几页的手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseOne:)];
    [self addGestureRecognizer:tap];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView];
    scrollView.backgroundColor = [UIColor whiteColor];
    _adView = scrollView;
    
    _imageViews = [NSMutableArray array];
    for(int i = 0; i < 3; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width*i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
        [scrollView addSubview:imgView];
        [_imageViews addObject:imgView];
    }
    
    scrollView.bounces = NO;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width*3, scrollView.bounds.size.height);
    
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    
    scrollView.pagingEnabled = YES;
    
    scrollView.delegate = self;
    
    [self showImageByIndex:_currentIndex];
}

#pragma mark -- 改变广告页图片,根据当前页码

-(void)showImageByIndex:(NSInteger)index
{
    for(int i = -1;i <= 1; i++)
    {
        UIImageView *imgView = _imageViews[i+1];
        //imgView.image = _images[[self trueIndexFromIndex:index+i]];
        [imgView setImageWithURL:_images[[self trueIndexFromIndex:index+i]]];
    }
}

#pragma mark -- 校正当前页码

-(NSInteger)trueIndexFromIndex:(NSInteger)index
{
    
    if(index==-1)
    {
        return _images.count-1;
    }
    else if(index == _images.count)
    {
        return 0;
    }
    return index;
}

#pragma mark -- scrollView滑动手势代理

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;
    
    if(contentOffset.x == 0)
    {
        _currentIndex = [self trueIndexFromIndex:_currentIndex-1];
    }
    else if(contentOffset.x == scrollView.bounds.size.width*2)
    {
        _currentIndex = [self trueIndexFromIndex:_currentIndex+1];
    }
    //同步广告页的图片
    [self showImageByIndex:_currentIndex];
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    //同步PageControl位置的显示
    [self changeCurrentPageByIndex:_currentIndex];
}


#pragma mark -- 获取当前页面

-(void)chooseOne:(UITapGestureRecognizer *)tap
{
    _callBack(_currentIndex);
}
#pragma mark -- 循环数字btn

-(void)createPageControl
{
    //设置坐标点的时候,x为0,宽度设为屏幕宽度即可,会居中显示
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
    //pageControl点的数量
    pageControl.numberOfPages = _images.count;
    //设置当前点的所在位置
    pageControl.currentPage = 0;
    //设置当前点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //设置没有选中的点的颜色
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //当点击左右的时候设置选中的点不会动
    pageControl.userInteractionEnabled = NO;
    pageControl.tag = 101;
    
    //***不要加在ScrollView上,加在ScrollView上在翻页的时候会导致pageControl会被推到其他位置***
    [self addSubview:pageControl];
    
    [self changeCurrentPageByIndex:_currentIndex];
}

#pragma mark -- 移除广告页

-(void)dismissMe:(UIButton *)sender
{
    [self removeFromSuperview];
}

#pragma mark -- 改变btn显示,根据当前页码

-(void)changeCurrentPageByIndex:(NSInteger)index
{
    UIPageControl *page = (UIPageControl *)[self viewWithTag:101];
    page.currentPage = index;
    
}

#pragma mark --setter方法
-(void)setBoardWidth:(UIEdgeInsets)boardWidth
{
    _boardWidth = boardWidth;
    _adView.frame = CGRectMake(_boardWidth.left, _boardWidth.top, self.bounds.size.width-_boardWidth.left-_boardWidth.right, self.bounds.size.height-_boardWidth.bottom-_boardWidth.top);
    
    for(int i = 0; i < _imageViews.count;i++)
    {
        UIImageView *imageView = _imageViews[i];
        imageView.frame = CGRectMake(_adView.bounds.size.width*i, 0, _adView.bounds.size.width, _adView.bounds.size.height);
    }
    
    _adView.contentOffset = CGPointMake(_adView.bounds.size.width, 0);
    
    _adView.contentSize = CGSizeMake(_adView.bounds.size.width*3, _adView.bounds.size.height);
    
}

-(void)setBoardColor:(UIColor *)boardColor
{
    _boardColor = boardColor;
    self.backgroundColor = _boardColor;
}


@end
