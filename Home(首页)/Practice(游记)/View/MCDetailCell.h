//
//  MCDetailCell.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCDetailInfo.h"

@interface MCDetailCell : UITableViewCell

@property(nonatomic,weak) UIImageView *image;

@property(nonatomic,weak) UILabel *detail;

-(void)setCellWithModel:(MCDetailModel *)detail;

@end
