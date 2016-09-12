//
//  MCCitySpotList.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/30.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>

//1.
@interface MCCitySpotList : NSObject

@property(nonatomic,strong) NSArray *tourBriefList;

@end

//2.
@interface CitySpotModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *soldprice_yuan;
@property (nonatomic, copy) NSString *marketprice_yuan;
@property (nonatomic, strong) NSNumber *tour_id;//需要传入下个页面参数

@property(nonatomic,strong) NSArray *tour_image_url;//图片

@end

