//
//  MCShareViewCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/7.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCShareViewCell.h"

@implementation MCShareViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createCellView];
    }
    return self;
}

-(void)createCellView
{
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREENWIDTH-40, 40)];
    _titleLab.font = [UIFont systemFontOfSize:18];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.textColor = [UIColor colorWithRed:255/255.0 green:126/255.0 blue:57/255.0 alpha:1.0];
    [self.contentView addSubview:_titleLab];
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_titleLab.frame), SCREENWIDTH-40, 200)];
    _imageV.layer.cornerRadius = 5;
    _imageV.clipsToBounds = YES;
    _imageV.userInteractionEnabled = YES;
    [self.contentView addSubview:_imageV];
    
    UIImageView *likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)-100, CGRectGetMaxY(_imageV.frame)-30, 25, 25)];
    likeImage.image = [UIImage imageNamed:@"like"];
    [self.contentView addSubview:likeImage];
    
    _likeCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(likeImage.frame)+10, likeImage.frame.origin.y, 60, 25)];
    _likeCount.textColor = [UIColor orangeColor];
    [self.contentView addSubview:_likeCount];
    
    UIButton *playImg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    playImg.center = _imageV.center;
    [playImg setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [playImg addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    _playImg = playImg;
    
    [self.contentView addSubview:playImg];
}

-(void)setUIWithModel:(SpecialVideoModel *)model
{
    _playImg.alpha = 1.0;
    [_imageV setImageWithURL:[NSURL URLWithString:model.videoCoverUrl] placeholderImage:[UIImage imageNamed:@"placeholder_h"]];
    _titleLab.text = model.title;
    _likeCount.text = [NSString stringWithFormat:@"%@", model.statfavour];
}

//播放视频
-(void)playVideo
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoWithInView:AndWithplayUrl:AndWithImageUrl:)])
    {
        _playImg.alpha = 0;
        [self.delegate playVideoWithInView:_imageV AndWithplayUrl:_model.playUrl AndWithImageUrl:_model.videoCoverUrl];
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
