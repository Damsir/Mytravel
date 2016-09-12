//
//  MCDetailCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCDetailCell.h"
#import "PracticeHeader.h"

@implementation MCDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initDetailCell];
    }
    return self;
}

-(void)initDetailCell
{
    
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH-20, 35)];
    _detail = detail;
    detail.numberOfLines = 0;
    detail.textColor = [UIColor orangeColor];
    detail.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:detail];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(detail.frame)+5, SCREENWIDTH-20, 190)];
    image.layer.cornerRadius = 5;
    image.clipsToBounds = YES;
    _image = image;
    [self.contentView addSubview:image];

}

-(void)setCellWithModel:(MCDetailModel *)detail
{
    [_image setImageWithURL:[NSURL URLWithString:detail.photo] placeholderImage:[UIImage imageNamed:@"placeholder_h"]];
    _detail.text = detail.text;
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
