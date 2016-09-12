//
//  PracticeHeader.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/22.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCDetailInfo.h"

@protocol PracticeHeaderDelegate <NSObject>

-(void)reloadHeaderHeight:(CGFloat)height;

@end

@interface PracticeHeader : UIView

@property(nonatomic,weak) UIImageView *image;
@property(nonatomic,weak) UILabel *userName;
@property(nonatomic,weak) UILabel *visit;
@property(nonatomic,weak) UIImageView *userIcon;
@property(nonatomic,weak) UILabel *storyName;
@property(nonatomic,weak) UILabel *introduce;

-(void)setHeaderWithTarget:(SpotModel *)spotModel andUser:(MCUserInfo *)user;

@property(nonatomic,assign) id<PracticeHeaderDelegate>delegate;

@end
