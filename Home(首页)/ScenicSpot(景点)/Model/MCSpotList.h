//
//  MCSpotList.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/23.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCResultModel,MCTicketInfo,MCAttentionModel;
//1.
@interface MCSpotList : NSObject

@property(nonatomic,copy) NSString *date;

@property(nonatomic,strong) MCResultModel *result;

@end
//2.
@interface MCResultModel : NSObject

@property(nonatomic,copy) NSString *url;//作为数据库的key
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *telephone;
@property(nonatomic,copy) NSString *star;//星级
@property(nonatomic,copy) NSString *abstract;//吸引理由(优势)
@property(nonatomic,copy) NSString *Description;

@property(nonatomic,copy) NSDictionary *location;//经纬度(lng,lat)

@property(nonatomic,strong) MCTicketInfo *ticket_info;

@end
//3.
@interface MCTicketInfo : NSObject

@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *open_time;

@property(nonatomic,strong) NSArray *attention;

@end
//4.
@interface MCAttentionModel : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *Description;

@end

