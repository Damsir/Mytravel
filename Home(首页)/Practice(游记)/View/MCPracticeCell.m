//
//  MCPracticeCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCPracticeCell.h"

@implementation MCPracticeCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120)];
    _image = image;
    [self.contentView addSubview:image];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame)+5, self.frame.size.width, 20)];
    _title = titleLab;
    titleLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:titleLab];
    
    
    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLab.frame)+5, 30, 30)];
    _userIcon = userIcon;
    userIcon.layer.cornerRadius = userIcon.frame.size.width/2.0;
    userIcon.clipsToBounds = YES;
    [self.contentView addSubview:userIcon];
    
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userIcon.frame)+10, userIcon.frame.origin.y+5, self.frame.size.width-40, 20)];
    _userName = userName;
    userName.textColor = [UIColor orangeColor];
    userName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:userName];
    
}

-(void)setCellWithInfo:(MCPracticemodel *)model
{
    [_image setImageWithURL:[NSURL URLWithString:model.cover_image] placeholderImage:[UIImage imageNamed:@"placeholder_v"]];
    _title.text = model.index_title;
    _userName.text = model.user.name;
    [_userIcon setImageWithURL:[NSURL URLWithString:model.user.avatar_l] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholder"]];
}


@end
