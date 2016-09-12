//
//  MCDetailInfo.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SpotModel,MCTargetModel,MCDetailModel,MCUserInfo;
//1.
@interface MCDetailInfo : NSObject

@property(nonatomic,strong) SpotModel *spot;
@property(nonatomic,strong) MCUserInfo *user;


@end

//2.
@interface SpotModel : NSObject

@property(nonatomic,strong) MCTargetModel *target;
@property(nonatomic,strong) NSArray *detail_list;

@property(nonatomic,copy) NSString *view_count;
@property(nonatomic,copy) NSString *cover_image;
@property(nonatomic,copy) NSString *share_url ;//分享链接

@end

//3.游记起始地等
@interface MCTargetModel : NSObject


@property (nonatomic, strong) NSNumber *min_price;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;


@end

//4.游记详细步骤
@interface MCDetailModel : NSObject


@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSNumber *photo_height;
@property (nonatomic, strong) NSNumber *photo_width;
@property (nonatomic, copy) NSString *photo;

@end

//5.
@interface MCUserInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar_l;
@property (nonatomic, copy) NSString *user_desc;


@end
