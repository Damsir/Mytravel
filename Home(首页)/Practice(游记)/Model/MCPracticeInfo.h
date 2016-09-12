//
//  MCPracticeInfo.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCPracticeInfo : NSObject

@property(nonatomic,copy) NSString *status;
@property(nonatomic,strong) NSArray *hot_spot_list;

@end

//数据详情
@class MCUseModel;

@interface MCPracticemodel : NSObject

@property (nonatomic, copy) NSString *index_title;
@property (nonatomic, copy) NSString *cover_image;
@property (nonatomic, strong) NSNumber *spot_id;
@property(nonatomic,strong) MCUseModel *user;


@end

//用户详情
@interface MCUseModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar_l;



@end

