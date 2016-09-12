//
//  RegisterViewController.h
//  TravelFun
//
//  Created by 吴定如 on 15/11/27.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;



@property(nonatomic,strong) void(^userInfoBlock)(NSDictionary *userDic);

@end
