//
//  MCEnjoyList.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/20.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCEnjoyList.h"

@implementation MCEnjoyList

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"product_list":@"MCEnjoyModel"};
}

@end

@implementation MCEnjoyModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"user":@"MCUserModel"};
}

@end

@implementation MCUserModel


@end