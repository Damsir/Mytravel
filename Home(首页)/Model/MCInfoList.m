//
//  MCInfoList.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/14.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCInfoList.h"

@implementation MCInfoList

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
+(JSONKeyMapper *)keyMapper
{
    JSONKeyMapper *keyMapper = [[JSONKeyMapper alloc] initWithDictionary:@{@"data.books":@"books"}];
    return keyMapper;
}

@end
