//
//  SpotDetailView.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/23.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSpotList.h"
//更新cell的高度
@protocol SpotDetailViewDelegate <NSObject>

-(void)reloadCellheight:(CGFloat)height;

@end

@interface SpotDetailView : UITableViewCell

@property(nonatomic,weak) UILabel *title;
@property(nonatomic,weak) UILabel *star;
@property(nonatomic,weak) UILabel *telephone;
@property(nonatomic,weak) UILabel *abstract;
@property(nonatomic,weak) UILabel *Description;
@property(nonatomic,weak) UILabel *price;
@property(nonatomic,weak) UILabel *openTime;
@property(nonatomic,weak) UILabel *attenName;
@property(nonatomic,weak) UILabel *attention;

-(void)setCellWithSpot:(MCSpotList *)spot;
@property(nonatomic,assign) id<SpotDetailViewDelegate>delegate;

@end
