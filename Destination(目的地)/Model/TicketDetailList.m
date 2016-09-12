//
//  TicketDetailList.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "TicketDetailList.h"
//1.
@implementation TicketDetailList


@end
//2.
@implementation DetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Description":@"description"};
}

@end