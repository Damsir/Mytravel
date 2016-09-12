//
//  UIView+ProgressView.m
//  UICollectionViewAndHttp
//
//  Created by smith on 15/11/3.
//  Copyright © 2015年 smith. All rights reserved.
//

#import "UIView+ProgressView.h"

#define BACKVIEW_TAG 6666



@implementation UIView (ProgressView)


- (void)showJiaZaiWithBool:(BOOL)isShow WithAnimation:(BOOL)isHave
{
    if (isShow)
    {
        UIView * backView = [self viewWithTag:BACKVIEW_TAG] ;
        if (backView)
        {
            return ;
        }
        //第一个层级
        backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] ;
        backView.tag = BACKVIEW_TAG ;
        [self addSubview:backView] ;
        
        
        //第二个层级 是用来做透明度用的
        UIView * subBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] ;
        
        subBackView.backgroundColor = [UIColor blackColor] ;
        
        subBackView.alpha = 0.2f ;
        
        [backView addSubview:subBackView] ;
        
        //第三层级 菊花
        UIView * blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 100)] ;
        blackView.layer.cornerRadius = 10 ;
        blackView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0] ;
        blackView.center = self.center;
        [backView addSubview:blackView] ;
        

        if (!isHave)
        {
            UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] ;
            activity.center = CGPointMake(blackView.frame.size.width/2, blackView.frame.size.height/2-15) ;
            [activity startAnimating] ;
            [blackView addSubview:activity] ;
        }
        
        else 
        {
            NSMutableArray *imagesArray = [NSMutableArray array];
            for (int i=0; i<6; i++)
            {
                NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"loading_%d.png",i] ofType:nil];
                UIImage *image = [UIImage imageWithContentsOfFile:path];
                [imagesArray addObject:image];
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            imageView.center = CGPointMake(blackView.frame.size.width/2, blackView.frame.size.height/2-10) ;
            [blackView addSubview:imageView];
            
            imageView.animationImages = imagesArray;
            imageView.animationDuration = 1;
            [imageView startAnimating];
            
        }
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width,20)];
        lab.text = @"正在加载...";
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.center = CGPointMake(blackView.frame.size.width/2, blackView.frame.size.height/2+25);
        lab.textAlignment = NSTextAlignmentCenter;
        [blackView addSubview:lab];
        
        //加到最上层
        [self bringSubviewToFront:backView];
        
    }
    else
    {
        UIView * backView = [self viewWithTag:BACKVIEW_TAG] ;
        [backView removeFromSuperview] ;
    }
}


@end
