//
//  MyAnnotation.h
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>

{
    // 设置一个全局的经纬度变量
    CLLocationCoordinate2D coordinate;
}

@property(strong,nonatomic)NSString *Title;
@property(strong,nonatomic)NSString *Subtitle;

@property(strong,nonatomic)id model;

//创建一个自定义的大头针对象
-(id)initWithCLLocation:(CLLocationCoordinate2D)Coordinate;

@end

