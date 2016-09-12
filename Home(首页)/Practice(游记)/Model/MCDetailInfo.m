//
//  MCDetailInfo.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCDetailInfo.h"
// 1.
@implementation MCDetailInfo

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"spot":@"data.spot",@"user":@"data.trip.user"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"spot":@"SpotModel",@"user":@"MCUserInfo"};
}

@end

//2.
@implementation SpotModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"target":@"MCTargetModel",@"detail_list":@"MCDetailModel"};
}

@end

//3.
@implementation MCTargetModel

@end

//4.
@implementation MCDetailModel


@end

//5.
@implementation MCUserInfo


@end

