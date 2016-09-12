//
//  MCDiscountView.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/6.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCDiscountView : UIView

@property (weak, nonatomic) IBOutlet UIView *backView1;
@property (weak, nonatomic) IBOutlet UIView *backView2;
@property (weak, nonatomic) IBOutlet UIView *backView3;
@property (weak, nonatomic) IBOutlet UIView *backView4;

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;

@property (weak, nonatomic) IBOutlet UILabel *describe1;
@property (weak, nonatomic) IBOutlet UILabel *describe2;
@property (weak, nonatomic) IBOutlet UILabel *describe3;
@property (weak, nonatomic) IBOutlet UILabel *describe4;

@property (weak, nonatomic) IBOutlet UILabel *discount1;
@property (weak, nonatomic) IBOutlet UILabel *discount2;
@property (weak, nonatomic) IBOutlet UILabel *discount3;
@property (weak, nonatomic) IBOutlet UILabel *discount4;

@property (weak, nonatomic) IBOutlet UILabel *price1;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UILabel *price3;
@property (weak, nonatomic) IBOutlet UILabel *price4;

-(void)loadData:(NSArray *)array;

@end
