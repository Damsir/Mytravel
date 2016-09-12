//
//  MCSpotList.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/23.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCSpotList.h"

//1.
@implementation MCSpotList

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"result":@"MCResultModel"};
}

@end
//2.
@implementation MCResultModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"ticket_info":@"MCTicketInfo"};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Description":@"description"};
}

@end
//3.
@implementation MCTicketInfo

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"attention":@"MCAttentionModel"};
}


@end

//4.
@implementation MCAttentionModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Description":@"description"};
}
@end
