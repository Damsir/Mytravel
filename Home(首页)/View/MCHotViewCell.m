//
//  MCHotViewCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/6.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCHotViewCell.h"

@implementation MCHotViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setUIWithInfoModel:(MCHotModel *)model
{
    [self.icon setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:[UIImage imageNamed:@"placeholder_h"]] ;
    [self.userIcon setImageWithURL:[NSURL URLWithString:model.userHeadImg] placeholderImage:[UIImage imageNamed:@"unlogin_forpad"]];
    _userIcon.layer.cornerRadius = 20;
    _userIcon.layer.masksToBounds = YES;
    _userIcon.layer.borderWidth = 2;
    _userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    self.title.text = model.title;
    self.name.text = [NSString stringWithFormat:@"👤 %@",model.userName];
    self.visit.text = [NSString stringWithFormat:@"%@",model.viewCount];
    self.reply.text = [NSString stringWithFormat:@"%@",model.commentCount];
    self.like.text = [NSString stringWithFormat:@"%@",model.likeCount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
