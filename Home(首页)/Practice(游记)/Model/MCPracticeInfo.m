//
//  MCPracticeInfo.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCPracticeInfo.h"

@implementation MCPracticeInfo

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"hot_spot_list":@"data.hot_spot_list"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"hot_spot_list":@"MCPracticemodel"};
}

@end

@implementation MCPracticemodel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"user":@"MCUseModel"};
}

@end

@implementation MCUseModel


@end









