//
//  SpotDetailView.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/23.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "SpotDetailView.h"

@implementation SpotDetailView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createCell];
    }
    return self;
}

-(void)createCell
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH, 20)];
    title.font = [UIFont boldSystemFontOfSize:20.0];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor orangeColor];
    _title = title;
    [self.contentView addSubview:title];
    
    UILabel *star = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(title.frame)+10, 120, 20)];
    star.font = [UIFont systemFontOfSize:16.0];
    _star = star;
    [self.contentView addSubview:star];
    
    UILabel *telephone = [[UILabel alloc] initWithFrame:CGRectMake(star.frame.origin.x, CGRectGetMaxY(star.frame)+5, SCREENWIDTH-20, 20)];
    telephone.font = [UIFont systemFontOfSize:16.0];
    telephone.numberOfLines = 0;
    _telephone = telephone;
    [self.contentView addSubview:telephone];
    
    UILabel *abstract = [[UILabel alloc] initWithFrame:CGRectMake(telephone.frame.origin.x, CGRectGetMaxY(telephone.frame)+5, SCREENWIDTH-20, 20)];
    abstract.font = [UIFont systemFontOfSize:16.0];
    abstract.numberOfLines = 0;
    _abstract = abstract;
    [self.contentView addSubview:abstract];
    
    //变高
    UILabel *Description = [[UILabel alloc] initWithFrame:CGRectMake(abstract.frame.origin.x, CGRectGetMaxY(abstract.frame)+5, SCREENWIDTH-20, 20)];
    Description.font = [UIFont systemFontOfSize:16.0];
    Description.numberOfLines = 0;
    _Description = Description;
    [self.contentView addSubview:Description];
    
    //变高
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(Description.frame.origin.x, CGRectGetMaxY(Description.frame)+5, SCREENWIDTH-20, 20)];
    price.font = [UIFont systemFontOfSize:16.0];
    price.numberOfLines = 0;
    _price = price;
    [self.contentView addSubview:price];
    //变高
    UILabel *openTime = [[UILabel alloc] initWithFrame:CGRectMake(price.frame.origin.x, CGRectGetMaxY(price.frame)+5, SCREENWIDTH-20, 20)];
    openTime.font = [UIFont systemFontOfSize:16.0];
    openTime.numberOfLines = 0;
    _openTime = openTime;
    [self.contentView addSubview:openTime];
}

-(void)setCellWithSpot:(MCSpotList *)spot
{
    MCResultModel *resultModel = spot.result;
    _title.text = resultModel.name;
    _star.text = [NSString stringWithFormat:@"景点星级: %@ 星",resultModel.star];
    _telephone.text = [NSString stringWithFormat:@"预定电话: %@ ",resultModel.telephone];
    _abstract.text = [NSString stringWithFormat:@"景点特色: %@",resultModel.abstract];
    //变高
    _Description.text = [NSString stringWithFormat:@"景点简介: %@",resultModel.Description];
    _price.text = [NSString stringWithFormat:@"景点票价: %@",resultModel.ticket_info.price];
    _openTime.text = [NSString stringWithFormat:@"开放时间: %@", resultModel.ticket_info.open_time];
    //电话
    CGRect telRect = [resultModel.telephone boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
    [_telephone setFrame:CGRectMake(_star.frame.origin.x, CGRectGetMaxY(_star.frame)+10, SCREENWIDTH-20, telRect.size.height)];
    //特点
    CGRect speRect = [resultModel.abstract boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
    [_abstract setFrame:CGRectMake(_telephone.frame.origin.x, CGRectGetMaxY(_telephone.frame)+10, SCREENWIDTH-20, speRect.size.height)];
    //简介
    CGRect desRect = [resultModel.Description boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
    [_Description setFrame:CGRectMake(_abstract.frame.origin.x, CGRectGetMaxY(_abstract.frame)+10, SCREENWIDTH-20, desRect.size.height)];
    //票相关
    CGRect TicketRect1 = [resultModel.ticket_info.price boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
    [_price setFrame:CGRectMake(_Description.frame.origin.x, CGRectGetMaxY(_Description.frame)+10, SCREENWIDTH-20, TicketRect1.size.height)];
    
    CGRect TicketRect2 = [resultModel.ticket_info.open_time boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
    [_openTime setFrame:CGRectMake(_price.frame.origin.x, CGRectGetMaxY(_price.frame)+10, SCREENWIDTH-20,TicketRect2.size.height)];
    
    CGFloat cellHeight = 70+telRect.size.height+speRect.size.height+desRect.size.height+TicketRect1.size.height + TicketRect2.size.height+50;
    //cell高度代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadCellheight:)])
    {
        [self.delegate reloadCellheight:cellHeight];
    }
    
    

    
    //自定义字体
    NSRange  range = {0,5} ;
    NSMutableAttributedString *starAtt = [[NSMutableAttributedString alloc] initWithString:_star.text] ;
    [starAtt addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range] ;
    [starAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:range] ;
    _star.attributedText = starAtt ;
    NSMutableAttributedString *telephoneAtt = [[NSMutableAttributedString alloc] initWithString:_telephone.text] ;
    [telephoneAtt addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range] ;
    [telephoneAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:range] ;
    _telephone.attributedText = telephoneAtt ;
    NSMutableAttributedString *abstrctAtt = [[NSMutableAttributedString alloc] initWithString:_abstract.text] ;
    [abstrctAtt addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range] ;
    [abstrctAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:range] ;
    _abstract.attributedText = abstrctAtt ;
    NSMutableAttributedString *desAtt = [[NSMutableAttributedString alloc] initWithString:_Description.text] ;
    [desAtt addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range] ;
    [desAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:range] ;
    _Description.attributedText = desAtt ;
    NSMutableAttributedString *priceAtt = [[NSMutableAttributedString alloc] initWithString:_price.text] ;
    [priceAtt addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range] ;
    [priceAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:range] ;
    _price.attributedText = priceAtt ;
    NSMutableAttributedString *openAtt = [[NSMutableAttributedString alloc] initWithString:_openTime.text] ;
    [openAtt addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range] ;
    [openAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:range] ;
    _openTime.attributedText = openAtt ;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
