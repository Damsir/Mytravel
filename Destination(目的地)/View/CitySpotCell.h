//
//  CitySpotCell.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/30.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCitySpotList.h"

@interface CitySpotCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *title;



-(void)setCellWithInfo:(CitySpotModel *)model;

@end
