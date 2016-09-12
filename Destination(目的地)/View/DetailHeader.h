//
//  DetailHeader.h
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketDetailList.h"

@interface DetailHeader : UIView

@property(nonatomic,weak) UILabel *title;

-(void)setHeaderViewWithInfo:(DetailModel *)model;

@end
