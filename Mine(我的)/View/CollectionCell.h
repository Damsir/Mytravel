//
//  CollectionCell.h
//  Mytravel
//
//  Created by 吴定如 on 15/12/3.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UITableViewCell

@property (weak, nonatomic) UIImageView *image;
@property (weak, nonatomic) UILabel *spotName;
@property (weak, nonatomic) UIImageView *star;
@property (weak, nonatomic) UILabel *date;

-(void)setCellWithDataBaseArray:(NSDictionary *)dataDic;

@end
