//
//  MCScrollView.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/5.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCScrollView : UIView

//广告页面加载
-(void)setAdiverseWithData:(NSArray *)array;

//按钮回调block
@property(nonatomic,copy) selectedBlock block;

@end
