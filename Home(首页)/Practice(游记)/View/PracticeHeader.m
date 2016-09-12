//
//  PracticeHeader.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/22.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "PracticeHeader.h"

@implementation PracticeHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createHeader];
    }
    return self;
}

-(void)createHeader
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 180)];
    image.alpha = 0.65;
    _image = image;
    [self addSubview:image];
    
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.7*image.frame.size.width, 30)];
    userName.center = CGPointMake(image.frame.size.width/2.0, image.frame.size.height/2.0);
    userName.textAlignment = NSTextAlignmentCenter;
    userName.font = [UIFont boldSystemFontOfSize:16.0];
    userName.textColor = [UIColor whiteColor];
    _userName = userName;
    [self addSubview:userName];
    
    UILabel *visit = [[UILabel alloc] initWithFrame:CGRectMake(image.frame.size.width-120, CGRectGetMaxY(image.frame)-30, 100, 20)];
    visit.textColor = [UIColor whiteColor];
    visit.font = [UIFont boldSystemFontOfSize:16.0];
    _visit = visit;
    [self addSubview:visit];
    
    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(image.frame)+5, 30, 30)];
    userIcon.layer.cornerRadius = userIcon.frame.size.width/2.0;
    userIcon.layer.borderWidth = 1;
    userIcon.layer.borderColor = [UIColor orangeColor].CGColor;
    userIcon.clipsToBounds = YES;
    _userIcon = userIcon;
    [self addSubview:userIcon];
    
    
    UILabel *storyName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.75*image.frame.size.width, 30)];
    storyName.center = CGPointMake(self.frame.size.width/2.0, userIcon.frame.origin.y + storyName.frame.size.height/2.0);
    storyName.textColor = [UIColor orangeColor];
    storyName.textAlignment = NSTextAlignmentCenter;
    storyName.font = [UIFont systemFontOfSize:14.0];
    _storyName = storyName;
    [self addSubview:storyName];
    
    UILabel *introduce = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userIcon.frame), CGRectGetMaxY(userIcon.frame)+5, 0.7 * image.frame.size.width, 50)];
    introduce.numberOfLines = 0;
    introduce.font = [UIFont systemFontOfSize:14.0];
    _introduce = introduce;
    [self addSubview:introduce];
   
    
}

-(void)setHeaderWithTarget:(SpotModel *)spotModel andUser:(MCUserInfo *)user
{
     MCTargetModel *target = spotModel.target;
     _storyName.text = target.title;
     _userName.text = [NSString stringWithFormat:@"本游记由 %@ 撰写",user.name];
    
    _visit.text = [NSString stringWithFormat:@"浏览:%@ 次",spotModel.view_count];
    [_userIcon setImageWithURL:[NSURL URLWithString:user.avatar_l] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholder"]];
    _introduce.text = user.user_desc;
    [_image setImageWithURL:[NSURL URLWithString:spotModel.cover_image] placeholderImage:[UIImage imageNamed:@"placeholder_h"]];
    
    CGRect rect = [user.user_desc boundingRectWithSize:CGSizeMake(0.7*self.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
    CGFloat height = rect.size.height+225.0;
    [_introduce setFrame:CGRectMake(CGRectGetMaxX(_userIcon.frame), CGRectGetMaxY(_userIcon.frame)+5, _image.frame.size.width - 2*CGRectGetMaxX(_userIcon.frame), rect.size.height)];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadHeaderHeight:)])
    {
        [self.delegate reloadHeaderHeight:height];
    }
   
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
