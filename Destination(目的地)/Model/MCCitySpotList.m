//
//  MCCitySpotList.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/30.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "MCCitySpotList.h"
//1.
@implementation MCCitySpotList

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"tourBriefList":@"data.tourBriefList"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"tourBriefList":@"CitySpotModel"};
}

@end
//2.
@implementation CitySpotModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Description":@"description"};
}

@end