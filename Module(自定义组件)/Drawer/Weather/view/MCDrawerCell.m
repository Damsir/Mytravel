//
//  MCDrawerCell.m
//  TravelFun
//
//  Created by 吴定如 on 15/11/26.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCDrawerCell.h"

@implementation MCDrawerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        [self createWeatherView];
    }
    return self;
}

-(void)createWeatherView
{
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 0.80*self.bounds.size.width , 20)];
    text.textAlignment = NSTextAlignmentCenter;
    text.textColor = [UIColor colorWithRed:34/255.0 green:171/255.0 blue:78/255.0 alpha:0.9];;
    text.font = [UIFont systemFontOfSize:20.0];
    _text = text;
    [self.contentView addSubview:text];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
