//
//  MCSpotCell.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/23.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSpotList.h"

@interface MCSpotCell : UITableViewCell

@property (weak, nonatomic) UIImageView *image;
@property (weak, nonatomic) UILabel *spotName;
@property (weak, nonatomic) UIImageView *star;
@property (weak, nonatomic) UILabel *date;

@property(nonatomic,strong) MCSpotList *spot;
-(void)setCellWithSpot:(MCSpotList *)spot;

@end
