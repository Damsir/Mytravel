//
//  DestinationLocationViewController.h
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationLocationViewController : UIViewController

//定位的城市名回调
@property(nonatomic,strong) void(^locationNameBlock)(NSString *site);

@end
