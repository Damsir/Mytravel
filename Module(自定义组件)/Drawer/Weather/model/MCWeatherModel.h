//
//  MCWeatherModel.h
//  TravelFun
//
//  Created by 吴定如 on 15/11/25.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@class WeatherModel;
@interface MCWeatherModel : NSObject

@property(nonatomic,strong) WeatherModel *model;

@end

@interface WeatherModel : NSObject

@property (nonatomic, copy) NSString *postCode;//邮编
@property (nonatomic, copy) NSString *h_tmp;//最高气温
@property (nonatomic, copy) NSString *temp;//气温
@property (nonatomic, strong) NSNumber *longitude;//经度
@property (nonatomic, copy) NSString *time;//发布时间
@property (nonatomic, strong) NSNumber *latitude;//海拔
@property (nonatomic, copy) NSString *l_tmp;//最低气温
@property (nonatomic, copy) NSString *WD;//风向
@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, copy) NSString *date;//日期
@property (nonatomic, copy) NSString *weather;//天气情况
@property (nonatomic, copy) NSString *city;//城市
@property (nonatomic, copy) NSString *citycode;//城市编码
@property (nonatomic, copy) NSString *WS;//风力
@property (nonatomic, copy) NSString *sunrise;//日出时间
@property (nonatomic, copy) NSString *altitude;//维度
@property (nonatomic, copy) NSString *sunset; //日落时间

@end
