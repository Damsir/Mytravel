//
//  MCDiscountCell.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/12.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCDiscountModel.h"

@interface MCDiscountCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *enddateLabel;
@property (weak, nonatomic) IBOutlet UILabel *discontLabel;

-(void)setCellWithInfo:(MCDiscountModel *)model;

@end
