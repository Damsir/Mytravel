//
//  MyAnnotationView.h
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface  MyAnnotationView: MKAnnotationView

//引用我们定义的大头针的model
@property(nonatomic,strong)MyAnnotation *myInfo;

@end