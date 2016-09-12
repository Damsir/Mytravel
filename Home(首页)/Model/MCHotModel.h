//
//  MCHotModel.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/6.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol MCHotModel <NSObject>

@end

@interface MCHotModel : JSONModel

@property(nonatomic,copy) NSString *headImage;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *userName;

@property(nonatomic,strong) NSNumber *viewCount;
@property(nonatomic,strong) NSNumber *commentCount;
@property(nonatomic,strong) NSNumber *likeCount;

@property(nonatomic,copy) NSString *userHeadImg;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,copy) NSString *startTime;
@property(nonatomic,copy) NSString *routeDays;
@property(nonatomic,copy) NSString *bookUrl;

@end
