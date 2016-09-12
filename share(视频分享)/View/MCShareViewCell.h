//
//  MCShareViewCell.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/7.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialVideoModel.h"

@protocol MCShareViewCellDelegate <NSObject>

-(void)playVideoWithInView:(UIView *)view AndWithplayUrl:(NSString *)url AndWithImageUrl:(NSString *)image;

@end

@interface MCShareViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleLab;

@property(nonatomic,strong) UIImageView *imageV;

@property(nonatomic,strong) UILabel *likeCount;
@property(nonatomic,weak) UIButton *playImg;

-(void)setUIWithModel:(SpecialVideoModel *)model;

@property(nonatomic,strong) SpecialVideoModel *model;

//播放视频代理
@property(nonatomic,assign) id <MCShareViewCellDelegate> delegate;

@end
