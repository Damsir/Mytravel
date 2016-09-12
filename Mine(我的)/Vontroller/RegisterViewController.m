//
//  RegisterViewController.m
//  TravelFun
//
//  Created by 吴定如 on 15/11/27.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

//返回
- (IBAction)Back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//确认注册
- (IBAction)sureRegister:(id)sender
{
    //删除空格
    NSString *userName = [_userName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //删除空格
    NSString *passWords = [_passWord.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //--------------注册-----------------
    if ([_userName.text isEqualToString:@""] || [_passWord.text isEqualToString:@""])
    {
        //注册失败
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"确定" destructiveButtonTitle:nil otherButtonTitles:@"账号或者密码不能为空", nil];
        [sheet showInView:self.view];
    }
    else
    {
        //注册成功
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
        [alert show] ;
        NSMutableArray *users = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/userInfo.plist",NSHomeDirectory()]];
        if (!users)
        {
            users = [NSMutableArray array];
        }
        
        NSDictionary *dic = [[NSDictionary alloc] init];
        dic = @{@"name":userName,@"pass":passWords};
        
        [users addObject:dic];
        
        [users writeToFile:[NSString stringWithFormat:@"%@/Documents/userInfo.plist",NSHomeDirectory()] atomically:YES];
        NSLog(@"%@",NSHomeDirectory());
        
        [self dismissViewControllerAnimated:YES completion:^{
            _userInfoBlock(dic);
        }];
    }

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
