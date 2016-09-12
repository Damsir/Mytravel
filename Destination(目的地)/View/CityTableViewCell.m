//
//  CityTableViewCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/30.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "CityTableViewCell.h"

@implementation CityTableViewCell


-(void)setUIWithInfoDestinationModel:(DestinationModel *)model
{
    [_image setImageWithURL:[NSURL URLWithString:model.imgUrl ]placeholderImage:[UIImage imageNamed:@"placeholder_h"]];
    _image.layer.cornerRadius = 10;
    _image.clipsToBounds = YES;
    _chineseName.text = model.chineseName;
    _englishName.text = model.englishName;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
