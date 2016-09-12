//
//  MCWeatherViewController.h
//  TravelFun
//
//  Created by 吴定如 on 15/11/26.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCWeatherModel.h"

@interface MCWeatherViewController : UIViewController

@property(nonatomic,strong) void(^wetherBlock)(WeatherModel *model);
@end
