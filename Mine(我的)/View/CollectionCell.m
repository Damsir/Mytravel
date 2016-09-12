//
//  CollectionCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/3.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    NSArray *images = @[@"spot",@"spot1",@"spot2",@"spot3",@"spot4"];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 0.6*SCREENWIDTH, 110)];
    
    image.image = [UIImage imageNamed:images[arc4random_uniform(5)]];
    image.layer.cornerRadius = 5;
    image.clipsToBounds = YES;
    _image = image;
    [self.contentView addSubview:image];
    
    UILabel *spotName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+20, image.frame.origin.y+5, self.frame.size.width-CGRectGetMaxX(image.frame)+20 , 30)];
    _spotName = spotName;
    spotName.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:spotName];
    
    UIImageView *backStar = [[UIImageView alloc] initWithFrame:CGRectMake(spotName.frame.origin.x, CGRectGetMaxY(spotName.frame)+10, 65, 23)];
    backStar.image = [UIImage imageNamed:@"StarsBackground"];
    [self.contentView addSubview:backStar];
    
    UIImageView *star = [[UIImageView alloc] initWithFrame:backStar.frame];
    star.image = [UIImage imageNamed:@"StarsForeground"] ;
    _star = star;
    [self.contentView addSubview:star];
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(spotName.frame.origin.x, CGRectGetMaxY(star.frame)+10, spotName.frame.size.width, 20)];
    _date = date;
    date.textColor = [UIColor orangeColor];
    date.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:date];
    
}

-(void)setCellWithDataBaseArray:(NSDictionary *)dataDic
{
    _spotName.text = dataDic[@"name"];
    _date.text = dataDic[@"date"];
    CGFloat width = 65 * [dataDic[@"star"] floatValue]/5.0;
    CGRect frame = _star.frame;
    frame.size.width = width;
    _star.frame = frame;
    //从左向右剪切,超出的部分切去
    _star.contentMode = UIViewContentModeLeft;
    _star.clipsToBounds = YES;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
