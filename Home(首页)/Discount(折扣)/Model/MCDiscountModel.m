//
//  MCDiscountModel.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/14.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCDiscountModel.h"

@implementation MCDiscountModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation DiscountInfo

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
