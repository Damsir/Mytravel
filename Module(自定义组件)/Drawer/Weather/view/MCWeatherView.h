//
//  MCWeatherView.h
//  TravelFun
//
//  Created by 吴定如 on 15/11/25.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCWeatherModel.h"

@interface MCWeatherView : UITableViewCell

@property(nonatomic,weak) UILabel *cityName;
@property(nonatomic,weak) UILabel *weather;
@property(nonatomic,weak) UILabel *temp;
@property(nonatomic,weak) UILabel *date;

-(void)setWeatherViewWithModel:(WeatherModel *)model;

@end
