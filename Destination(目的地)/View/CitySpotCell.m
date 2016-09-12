//
//  CitySpotCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/30.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "CitySpotCell.h"

@implementation CitySpotCell


-(void)setCellWithInfo:(CitySpotModel *)model
{
    [_image setImageWithURL:[NSURL URLWithString:[model.tour_image_url[0] objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"placeholder_h"]];
    _image.layer.cornerRadius = 5;
    _image.clipsToBounds = YES;
    _title.text = model.name;
    _price.text = [NSString stringWithFormat:@"现价:￥%@", model.soldprice_yuan];
    _discount.text = [NSString stringWithFormat:@"%@折",model.discount];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
