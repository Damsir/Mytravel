//
//  MCPracticeCell.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/21.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPracticeInfo.h"

@interface MCPracticeCell : UICollectionViewCell

@property(nonatomic,weak) UIImageView *image;
@property(nonatomic,weak) UIImageView *userIcon;
@property(nonatomic,weak) UILabel *title;
@property(nonatomic,weak) UILabel *userName;

-(void)setCellWithInfo:(MCPracticemodel *)model;

@end
