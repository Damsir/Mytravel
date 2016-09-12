//
//  PracticeAdView.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "PracticeAdView.h"

@interface PracticeAdView ()<UIScrollViewDelegate>

{
    NSTimer *timer;
    NSInteger timeIndex;//记录当前是哪个广告
    NSArray *images;
}

@end

@implementation PracticeAdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createAD];
    }
    return self;
}

-(void)createAD
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 170)];
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.bounces = NO;
    scroll.delegate = self;
    scroll.tag = 100;
    [self addSubview:scroll];
    
    images = @[@"http://photos.breadtrip.com/covers_2015_11_13_619c71902af06401c721589abdbd9df8.jpg",@"http://photos.breadtrip.com/covers_2015_11_18_57b6ed6671f35450ba1b82ab9e81d577.png",@"http://photos.breadtrip.com/covers_2015_11_18_df480611b1ae63a8b27c49800677a28e.png",@"http://photos.breadtrip.com/covers_2015_11_12_fd393c51c5ee595951d984cbf1a4b594.jpg",@"http://photos.breadtrip.com/covers_2015_11_12_7d1fdbdc722aaad28eefc7de302ce3d8.jpg"];
    for (int i=0 ; i<images.count; i++)
    {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH * i, 0, SCREENWIDTH, 170)];
        imageV.userInteractionEnabled = YES;
        [imageV setImageWithURL:[NSURL URLWithString:images[i]] placeholderImage:[UIImage imageNamed:@"placeholder_h"]];
        scroll.contentSize = CGSizeMake(SCREENWIDTH * images.count, 0);
        [scroll addSubview:imageV];
    }
    if (!timer)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(rippleEffectScroll) userInfo:nil repeats:YES];
        timeIndex = 1;
    }
}

-(void)rippleEffectScroll
{
    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.duration = 2.2;
    
    UIScrollView *scroll = (id)[self viewWithTag:100];
    
    if (images.count>0 && timeIndex < images.count)
    {
        scroll.contentOffset=CGPointMake(timeIndex * self.frame.size.width,0);
    }
    else if (timeIndex >= images.count)
    {
        scroll.contentOffset = CGPointMake((timeIndex%images.count) * SCREENWIDTH, 0);
    }
    animation.subtype = kCATransitionFromRight;
    [scroll.layer addAnimation:animation forKey:nil];

    timeIndex ++;
}

@end
