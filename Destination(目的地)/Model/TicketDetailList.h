//
//  TicketDetailList.h
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DetailModel;
//1.
@interface TicketDetailList : NSObject

@property(nonatomic,strong) DetailModel *data;

@end
//2.
@interface DetailModel : NSObject

@property(nonatomic,copy) NSString *name;
@property (nonatomic, copy) NSString *Description;//转义
@property(nonatomic,copy) NSString *cancel_policy ;//退改说明
//@property(nonatomic,copy) NSString *product_desc;//产品描述
@property(nonatomic,copy) NSString *usageProfile ;//使用方法
@property(nonatomic,copy) NSString *attentionProfile ;//特别注意

@property(nonatomic,strong) NSArray *image_url;
@property(nonatomic,copy) NSString *tourUrl;//分享链接

@end
