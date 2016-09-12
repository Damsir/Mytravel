//
//  MCEnjoyList.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/20.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCEnjoyList : NSObject

@property(nonatomic,copy) NSString *next_start;

@property(nonatomic,strong) NSArray *product_list;

@end

@class MCUserModel;
@interface MCEnjoyModel : NSObject

@property (nonatomic, copy) NSString *date_str;//日期
@property (nonatomic, copy) NSString *title_page;//图片
@property (nonatomic, strong) NSNumber *stock;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *address;//地址
@property (nonatomic, strong) NSNumber *product_id;
@property (nonatomic, strong) NSNumber *like_count;


@property(nonatomic,strong) NSArray *tab_list;//分类
@property(nonatomic,strong) MCUserModel *user;

@end

@interface MCUserModel : NSObject

@property(nonatomic,copy) NSString *avatar_l ;//用户头像
@property(nonatomic,copy) NSString *name;

@end
