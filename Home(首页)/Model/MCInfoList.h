//
//  MCInfoList.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/14.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "JSONModel.h"
#import "MCHotModel.h"
#import "MCDiscountModel.h"

@interface MCInfoList : JSONModel

@property(nonatomic,strong) NSArray<MCHotModel> *books;


@end
