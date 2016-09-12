//
//  MCWeatherModel.m
//  TravelFun
//
//  Created by 吴定如 on 15/11/25.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCWeatherModel.h"

@implementation MCWeatherModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"model":@"WeatherModel"};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"model":@"retData"};
}

@end

@implementation WeatherModel


@end
