//
//  MCFindView.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/6.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCFindView.h"
#import "MCRecommendModel.h"

@implementation MCFindView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createView];
    }
    return self;
}

-(void)createView
{
    // H 315
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.bounds.size.width-40, 40)];
    titleLab.text = @">>游趣新发现";
    titleLab.textColor = [UIColor orangeColor];
    [self addSubview:titleLab];
    
    UIImageView *firstImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, self.bounds.size.width-10, 120)];
    UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(firstImg.frame)+10, (self.bounds.size.width-20)/2.0, 120)];
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImg.frame)+10,leftImg.frame.origin.y, (self.bounds.size.width-20)/2.0, 120)];
    firstImg.image = [UIImage imageNamed:@"placeholder_h"];
    leftImg.image = [UIImage imageNamed:@"placeholder_v"];
    rightImg.image = [UIImage imageNamed:@"placeholder_v"];
    [self addSubview:firstImg];
    [self addSubview:leftImg];
    [self addSubview:rightImg];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(leftImg.frame)+5, self.bounds.size.width, 10)];
    lab.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    [self addSubview:lab];
    
}

-(void)loadData:(NSArray *)array{
    
    // H 290
    
    
    UIImageView *firstImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, self.bounds.size.width-10, 120)];
    UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(firstImg.frame)+10, (self.bounds.size.width-20)/2.0, 120)];
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImg.frame)+10,leftImg.frame.origin.y, (self.bounds.size.width-20)/2.0, 120)];
    [self addSubview:firstImg];
    [self addSubview:leftImg];
    [self addSubview:rightImg];
    firstImg.userInteractionEnabled = YES;
    leftImg.userInteractionEnabled = YES;
    rightImg.userInteractionEnabled = YES;
    
   
    
    MCRecommendModel *model1 = array[0];
    MCRecommendModel *model2 = array[1];
    MCRecommendModel *model3 = array[2];
    
    [firstImg setImageWithURL:[NSURL URLWithString:model1.photo]];
    [leftImg setImageWithURL:[NSURL URLWithString:model2.photo]];
    [rightImg setImageWithURL:[NSURL URLWithString:model3.photo]] ;
    
}


@end
