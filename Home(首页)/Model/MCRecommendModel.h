//
//  MCRecommendModel.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/6.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol MCRecommendModel <NSObject>

@end

@interface MCRecommendModel : JSONModel

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *end_date;
@property(nonatomic,copy) NSString *photo;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *priceoff;
@property(nonatomic,copy) NSString *url;

@end

@interface MCRecommendInfo : JSONModel

@property(nonatomic,strong) NSArray<MCRecommendModel> *slide;
@property(nonatomic,strong) NSArray<MCRecommendModel> *subject;
@property(nonatomic,strong) NSArray<MCRecommendModel> *discount;

@end
