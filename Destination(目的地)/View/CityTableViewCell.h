//
//  CityTableViewCell.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/30.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCDestinationList.h"

@interface CityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *chineseName;
@property (weak, nonatomic) IBOutlet UILabel *englishName;

-(void)setUIWithInfoDestinationModel:(subListModel *)model;

@end
