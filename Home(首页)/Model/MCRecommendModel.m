//
//  MCRecommendModel.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/6.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCRecommendModel.h"

@implementation MCRecommendModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}


@end

@implementation MCRecommendInfo

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
+(JSONKeyMapper *)keyMapper
{
    JSONKeyMapper *keyMapper = [[JSONKeyMapper alloc] initWithDictionary:@{@"data.slide":@"slide",@"data.subject":@"subject",@"data.discount":@"discount"}];
    return keyMapper;
}

@end
