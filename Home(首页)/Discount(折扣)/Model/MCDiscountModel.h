//
//  MCDiscountModel.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/14.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "JSONModel.h"

@protocol MCDiscountModel <NSObject>

@end

@interface DiscountInfo : JSONModel

@property(nonatomic,strong) NSArray <MCDiscountModel> *data;

@end


@interface MCDiscountModel : JSONModel

@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *buy_price;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *end_date;
@property(nonatomic,copy)NSString *lastminute_des;
@property(nonatomic,copy)NSString *url;

@end
