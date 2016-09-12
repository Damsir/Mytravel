//
//  AdvertiseView.h
//  Advertisement
//
//  Created by 吴定如 on 15/10/24.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertiseView : UIView

@property (nonatomic,assign) UIEdgeInsets boardWidth;
@property (nonatomic,strong) UIColor *boardColor;

-(instancetype)initWithFrame:(CGRect)frame withImagesURLArray:(NSArray *)imgUrlArray withCallBack:(void(^)(NSInteger chooseIndex))callBack;

@end
