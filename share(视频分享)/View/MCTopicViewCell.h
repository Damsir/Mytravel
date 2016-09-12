//
//  MCTopicViewCell.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/17.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialVideoModel.h"

@protocol MCTopicViewCellDelegate <NSObject>

-(void)playVideoWithInView:(UIView *)view AndWithplayUrl:(NSString *)url AndWithImageUrl:(NSString *)image;

@end

@interface MCTopicViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *focus;
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;
@property (weak, nonatomic) IBOutlet UIButton *zangImage;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIImageView *rankImage;



-(void)setUIWithModel:(SpecialVideoModel *)model;
@property(nonatomic,strong) SpecialVideoModel *model;
//播放视频代理
@property(nonatomic,assign) id<MCTopicViewCellDelegate>delegate;

@end
