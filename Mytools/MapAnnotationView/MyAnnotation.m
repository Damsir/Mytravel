//
//  MyAnnotation.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

-(id)initWithCLLocation:(CLLocationCoordinate2D)Coordinate{
    self = [super init];
    if (self)
    {
        coordinate = Coordinate;
    }
    return self;
}

//在地图里面重写MKAnnotation  就得重写coordina方法
-(CLLocationCoordinate2D)coordinate
{
    return coordinate;
}

-(NSString *)title
{
    return _Title;
}

-(NSString *)subtitle
{
    return _Subtitle;
}

@end

