//
//  MyAnnotationView.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "MyAnnotationView.h"

@interface MyAnnotationView ()

@end

@implementation MyAnnotationView

-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.myInfo = annotation;
    }
    return self;
}


@end
