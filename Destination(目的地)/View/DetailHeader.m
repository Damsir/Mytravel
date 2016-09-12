//
//  DetailHeader.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "DetailHeader.h"
#import "AdvertiseView.h"

@implementation DetailHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 170)];
        imageV.tag = 1000;
        imageV.userInteractionEnabled = YES;
        imageV.image = [UIImage imageNamed:@"placeholder_v"];
        [self addSubview:imageV];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageV.frame), SCREENWIDTH-20, 40)];
        title.numberOfLines = 0;
        title.textColor = [UIColor orangeColor];
        title.font = [UIFont systemFontOfSize:15];
        _title = title;
        [self addSubview:title];
    }
    return self;
}

-(void)setHeaderViewWithInfo:(DetailModel *)model
{
    UIImageView *imageV = (id)[self viewWithTag:1000];
    NSMutableArray *images = [NSMutableArray array];
    for (int i=0; i< model.image_url.count; i++)
    {
        NSURL *url = [NSURL URLWithString:[model.image_url[i] objectForKey:@"url"]];
        [images addObject:url];
    }
    
    AdvertiseView *adView = [[AdvertiseView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 170) withImagesURLArray:images withCallBack:^(NSInteger chooseIndex) {
        
    }];
    [imageV addSubview:adView];
    _title.text = model.name;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
