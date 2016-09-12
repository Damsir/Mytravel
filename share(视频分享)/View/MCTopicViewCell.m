//
//  MCTopicViewCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/17.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCTopicViewCell.h"

@implementation MCTopicViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setUIWithModel:(SpecialVideoModel *)model
{
    _playBtn.alpha = 1.0;
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_image setImageWithURL:[NSURL URLWithString:model.videoCoverUrl] placeholderImage:[UIImage imageNamed:@"placeholder_h"]];
    _image.layer.cornerRadius = 5;
    _image.clipsToBounds = YES;
    _title.text = model.title;
    _userImage.image = [UIImage imageNamed:@"AvatarPlaceholder"];
    _userName.text = model.nickname;
    
    _commentImage.image = [UIImage imageNamed:@"video_comment"];
    _comment.text = [NSString stringWithFormat:@"%@",model.statComment];
    _likeImage.image = [UIImage imageNamed:@"like_select_like_circle"];
    _likeCount.text = [NSString stringWithFormat:@"%@",model.statfavour];
    
}
//播放视频
- (IBAction)playVideo:(id)sender
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoWithInView:AndWithplayUrl:AndWithImageUrl:)])
    {
        _playBtn.alpha = 0;
        [self.delegate playVideoWithInView:_image AndWithplayUrl:_model.playUrl AndWithImageUrl:_model.videoCoverUrl];
    }
}


//关注
- (IBAction)changeFocusImage:(id)sender
{
    
    [_focus setImage:[UIImage imageNamed:@"focus_followed"] forState:UIControlStateNormal];
}

//赞
- (IBAction)changeFavourImageAndCount:(id)sender
{
    [_zangImage setImage:[UIImage imageNamed:@"likeNoClickIconActive"] forState:UIControlStateNormal];
    
    UILabel *like = (UILabel *)[self.contentView viewWithTag:301];
    int num = [like.text intValue];
    like.text = [NSString stringWithFormat:@"%d",num+1];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
