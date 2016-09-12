//
//  MCSpotCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/23.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCSpotCell.h"


@interface MCSpotCell ()<UIAlertViewDelegate>

@end

@implementation MCSpotCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    NSArray *images = @[@"spot",@"spot1",@"spot2",@"spot3",@"spot4"];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 0.6*SCREENWIDTH, 110)];
    image.image = [UIImage imageNamed:images[arc4random_uniform(5)]];
    image.layer.cornerRadius = 5;
    image.clipsToBounds = YES;
    _image = image;
    [self.contentView addSubview:image];
    
    UILabel *spotName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+20, image.frame.origin.y+5, self.frame.size.width-CGRectGetMaxX(image.frame)+20 , 30)];
    _spotName = spotName;
    spotName.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:spotName];
    
    UIImageView *backStar = [[UIImageView alloc] initWithFrame:CGRectMake(spotName.frame.origin.x, CGRectGetMaxY(spotName.frame)+10, 65, 23)];
    backStar.image = [UIImage imageNamed:@"StarsBackground"];
    [self.contentView addSubview:backStar];
    
    UIImageView *star = [[UIImageView alloc] initWithFrame:backStar.frame];
    star.image = [UIImage imageNamed:@"StarsForeground"] ;
    _star = star;
    [self.contentView addSubview:star];
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(spotName.frame.origin.x, CGRectGetMaxY(star.frame)+10, spotName.frame.size.width, 20)];
    _date = date;
    date.textColor = [UIColor orangeColor];
    date.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:date];
    
    UILabel *favour = [[UILabel alloc] initWithFrame:CGRectMake(image.bounds.size.width-80, image.frame.origin.y+5, 40, 30)];
    favour.text = @"收藏";
    favour.font = [UIFont systemFontOfSize:18];
    favour.textColor = [UIColor whiteColor];
    [self.contentView addSubview:favour];
    UIButton *collection = [UIButton buttonWithType:UIButtonTypeCustom];
    collection.frame = CGRectMake(CGRectGetMaxX(favour.frame), favour.frame.origin.y-6, 40, 40);
    [collection setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [collection addTarget:self action:@selector(collection) forControlEvents:UIControlEventTouchUpInside];
    collection.tag = 1000;
    [self.contentView addSubview:collection];
}

-(void)setCellWithSpot:(MCSpotList *)spot
{
    UIButton *collection = (id)[self.contentView viewWithTag:1000];
    [collection setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    collection.userInteractionEnabled = YES;
    
    _spotName.text = spot.result.name;
    _date.text = spot.date;
    
    CGFloat width = 65 * [spot.result.star floatValue]/5.0;
    CGRect frame = _star.frame;
    frame.size.width = width;
    _star.frame = frame;
    //从左向右剪切,超出的部分切去
    _star.contentMode = UIViewContentModeLeft;
    _star.clipsToBounds = YES;
}

#pragma mark -- 收藏
-(void)collection
{
    static BOOL isFirst = YES;
    // 判断用户是否是已经登录
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isLoginState = [[defaults objectForKey:@"isLoginState"] boolValue];
    if(isLoginState)
    {
        if (isFirst)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确定要收藏吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未登录,请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIButton *collection = (id)[self.contentView viewWithTag:1000];
    if (buttonIndex == 1)
    {
        //收藏成功就不能再次收藏
        collection.userInteractionEnabled = NO;
        //收藏成功改变图片
        [collection setImage:[UIImage imageNamed:@"like_press"] forState:UIControlStateNormal];
        NSArray *array = [[DBManager sharedDBManager] recieveDBData];
        if (array.count == 0)
        {
            //收藏
            NSDictionary *dataDic = @{@"url":_spot.result.url,@"name":_spot.result.name ,@"star":_spot.result.star,@"date":_spot.date};
            [[DBManager sharedDBManager] insertDataWithDictionary:dataDic];
        }
        else
        {
            for (int i=0; i<array.count; i++)
            {
                NSDictionary *oldDic = array[i];
                if ([oldDic[@"url"] isEqualToString:_spot.result.url])
                {
                    NSLog(@"====--%@",oldDic[@"url"]);
                    break;
                }
                else if(i==array.count-1)
                {
                    //收藏
                    NSDictionary *dataDic = @{@"url":_spot.result.url,@"name":_spot.result.name ,@"star":_spot.result.star,@"date":_spot.date};
                    [[DBManager sharedDBManager] insertDataWithDictionary:dataDic];
                }
            }
        }
        
    }
    else
    {
        return;
    }

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
