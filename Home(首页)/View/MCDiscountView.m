//
//  MCDiscountView.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/6.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCDiscountView.h"
#import "MCRecommendModel.h"

@implementation MCDiscountView

//H 500
-(void)loadData:(NSArray *)array
{

    MCRecommendModel *info1 = array[0];
    MCRecommendModel *info2 = array[1];
    MCRecommendModel *info3 = array[2];
    MCRecommendModel *info4 = array[3];
   // NSLog(@"%@",info1);
    //抢特价折扣
    [self.image1 setImageWithURL:[NSURL URLWithString:info1.photo] placeholderImage:[UIImage imageNamed:@"placeholder_v"]];
    [self.image2 setImageWithURL:[NSURL URLWithString:info2.photo] placeholderImage:[UIImage imageNamed:@"placeholder_v"]];
    [self.image3 setImageWithURL:[NSURL URLWithString:info3.photo] placeholderImage:[UIImage imageNamed:@"placeholder_v"]];
    [self.image4 setImageWithURL:[NSURL URLWithString:info4.photo] placeholderImage:[UIImage imageNamed:@"placeholder_v"]];
   
    
    //价格进行字符串分割(<em>8399</em>元起)
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"<em></em>"];
    NSArray *newArr1 = [info1.price componentsSeparatedByCharactersInSet:set];
    NSArray *newArr2 = [info2.price componentsSeparatedByCharactersInSet:set];
    NSArray *newArr3 = [info3.price componentsSeparatedByCharactersInSet:set];
    NSArray *newArr4 = [info4.price componentsSeparatedByCharactersInSet:set];
    self.price1.text = newArr1[4];
    self.price2.text = newArr2[4];
    self.price3.text = newArr3[4];
    self.price4.text = newArr4[4];
   
    
    self.describe1.text = [NSString stringWithFormat:@"%@",info1.title];
    self.describe2.text = [NSString stringWithFormat:@"%@",info2.title];
    self.describe3.text = [NSString stringWithFormat:@"%@",info3.title];
    self.describe4.text = [NSString stringWithFormat:@"%@",info4.title];
    
    self.discount1.text = [NSString stringWithFormat:@"%@",info1.priceoff];
    self.discount2.text = [NSString stringWithFormat:@"%@",info2.priceoff];
    self.discount3.text = [NSString stringWithFormat:@"%@",info3.priceoff];
    self.discount4.text = [NSString stringWithFormat:@"%@",info4.priceoff];
    
}

@end
