//
//  MCHotViewCell.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/6.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCHotModel.h"

@interface MCHotViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *visit;
@property (weak, nonatomic) IBOutlet UILabel *reply;
@property (weak, nonatomic) IBOutlet UILabel *like;


-(void)setUIWithInfoModel:(MCHotModel *)model;

@end
