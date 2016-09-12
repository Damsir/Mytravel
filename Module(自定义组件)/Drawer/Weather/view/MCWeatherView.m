//
//  MCWeatherView.m
//  TravelFun
//
//  Created by 吴定如 on 15/11/25.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCWeatherView.h"

@implementation MCWeatherView

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
    UILabel *cityName = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 0.8*self.bounds.size.width , 20)];
    cityName.text = @"北京";
    cityName.textAlignment = NSTextAlignmentCenter;
    cityName.textColor = [UIColor whiteColor];
    cityName.font = [UIFont systemFontOfSize:24.0];
    _cityName = cityName;
    [self.contentView addSubview:cityName];
    
    UILabel *weather = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cityName.frame)+20, 0.8*self.bounds.size.width , 20)];
    weather.text = @"晴";
    weather.textColor = [UIColor whiteColor];
    weather.textAlignment = NSTextAlignmentCenter;
    _weather = weather;
    weather.font = [UIFont systemFontOfSize:20.0];
    [self.contentView addSubview:weather];
    
    UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(weather.frame)+20, 0.8*self.bounds.size.width , 40)];
    temp.text = @"-8° ~ 0°";
    temp.textColor = [UIColor whiteColor];
    temp.textAlignment = NSTextAlignmentCenter;
    _temp = temp;
    temp.font = [UIFont systemFontOfSize:42.0];
    [self.contentView addSubview:temp];
    
    NSDate *Date = [NSDate date];
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(temp.frame)+10, 0.8*self.bounds.size.width , 30)];
    date.textAlignment = NSTextAlignmentCenter;
    date.textColor = [UIColor whiteColor];
    NSString *text = [NSString stringWithFormat:@"%@",Date];
    NSString *text1 = [text substringToIndex:11];
    date.text = text1;
    _date = date;
    date.font = [UIFont systemFontOfSize:20.0];
    [self.contentView addSubview:date];
    
    
}

-(void)setWeatherViewWithModel:(WeatherModel *)model
{
    if (model.city)
    {
        _cityName.text = model.city;
        _date.text = [NSString stringWithFormat:@"%@ , %@", model.time,model.date];
        _temp.text = [NSString stringWithFormat:@"%@° ~ %@°",model.l_tmp,model.h_tmp];
        _weather.text = model.weather;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
