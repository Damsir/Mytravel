//
//  MCDiscountCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/12.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCDiscountCell.h"

@implementation MCDiscountCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setCellWithInfo:(MCDiscountModel *)model
{
    [_picView setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"placeholder_v"]];
    _priceLabel.text = [NSString stringWithFormat:@"%@元起",model.buy_price];
    _enddateLabel.text = model.end_date;
    _discontLabel.text = model.lastminute_des;
    _titleLabel.text = model.title;
}

@end
