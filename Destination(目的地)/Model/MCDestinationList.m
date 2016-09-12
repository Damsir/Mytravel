//
//  MCDestinationList.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/30.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "MCDestinationList.h"

@implementation MCDestinationList

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"data":@"DestinationModel"};
}

@end

//2.
@implementation DestinationModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"imgUrl":@"image.imgUrl"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"subList":@"subListModel"};
}

@end
//3.
@implementation subListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"imgUrl":@"image.imgUrl"};
}

@end