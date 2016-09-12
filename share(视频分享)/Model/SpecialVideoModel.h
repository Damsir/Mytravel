//
//  SpecialVideoModel.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/16.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialVideoModel : NSObject

@property (nonatomic, copy) NSString *videoCoverUrl;//图片
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, strong) NSNumber *statPlay;//播放次数
@property (nonatomic, strong) NSNumber *statComment;//评论
@property (nonatomic, strong) NSNumber *statfavour;//喜欢
@property (nonatomic, copy) NSString *playUrl;//播放链接
@property (nonatomic,copy) NSString *nickname;//作者呢称

@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *memo;

@end
