//
//  MCEnjoyCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/20.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCEnjoyCell.h"

@interface MCEnjoyCell()<UIAlertViewDelegate>

@end

@implementation MCEnjoyCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setUIWithModel:(MCEnjoyModel *)model
{
    [_image setImageWithURL:[NSURL URLWithString:model.title_page] placeholderImage:[UIImage imageNamed:@"placeholder_h"]];
    _image.layer.cornerRadius = 5;
    _image.clipsToBounds = YES;
    _title.text = model.title;
    [_userIcon setImageWithURL:[NSURL URLWithString:model.user.avatar_l] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholder"]];
    _userIcon.layer.cornerRadius = _userIcon.frame.size.width/2.0;
    _userIcon.clipsToBounds = YES;
    _time.text = [NSString stringWithFormat:@"%@  %@",model.date_str,model.address];
    _likeCount.text = [NSString stringWithFormat:@"%@",model.like_count];
    _price.text = [NSString stringWithFormat:@"￥%@",model.price];
    if (model.tab_list.count == 1)
    {
        _category.text = [NSString stringWithFormat:@"%@",model.tab_list[0]];
    }
    else if (model.tab_list.count == 2)
    {
        _category.text = [NSString stringWithFormat:@"%@&%@",model.tab_list[0],model.tab_list[1]];
    }
    
}


- (IBAction)changeImageAndCollect:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确定要收藏吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [_likeImage setImage:[UIImage imageNamed:@"like_press"] forState:UIControlStateNormal];
        _likeCount.text = [NSString stringWithFormat:@"%d",[_likeCount.text intValue]+1];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
