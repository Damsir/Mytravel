//
//  MCDestinationList.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/30.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class subListModel ;
@interface MCDestinationList : NSObject

@property(nonatomic,strong) NSArray *data;

@end
//2.
@interface DestinationModel : NSObject

@property (nonatomic, copy) NSString *chineseName;
@property (nonatomic, copy) NSString *englishName;

@property(nonatomic,copy) NSString *imgUrl;//需转义
@property(nonatomic,strong) NSArray *subList;

@end
//3.
@interface subListModel : NSObject

@property (nonatomic, copy) NSString *chineseName;
@property (nonatomic, copy) NSString *englishName;
@property (nonatomic, strong) NSNumber *locationId;//城市Id

@property(nonatomic,copy) NSString *imgUrl;//需转义

@end


