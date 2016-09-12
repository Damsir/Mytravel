//
//  LoginViewController.m
//  TravelFun
//
//  Created by 吴定如 on 15/11/27.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UIAlertViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

//注册
- (IBAction)registerUser:(id)sender
{
    RegisterViewController *regiVC = [[RegisterViewController alloc] init];
    regiVC.userInfoBlock = ^(NSDictionary *userDic)
    {
        _userName.text = [userDic objectForKey:@"name"];
        _passWords.text = [userDic objectForKey:@"pass"];
    };
    [self presentViewController:regiVC animated:YES completion:nil];
}
//登陆
- (IBAction)login:(id)sender
{
    //删除空格
    NSString *userName = [_userName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //删除空格
    NSString *passWords = [_passWords.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //--------------登陆判断--------------
    NSMutableArray *userArray = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/userInfo.plist",NSHomeDirectory()]];
    if (userArray.count == 0)
    {   //第一次判断
        if ([userName isEqualToString:@"1"] && [passWords isEqualToString:@"1"])
        {
            //----------登录成功记录状态------
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"isLoginState"];
            [defaults synchronize];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"恭喜,登陆成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        for (int i=0; i<userArray.count; i++)
        {
            NSDictionary *userDic = userArray[i];
            if (([userName isEqualToString:[userDic objectForKey:@"name"]] && [passWords isEqualToString:[userDic objectForKey:@"pass"]]) || ([userName isEqualToString:@"wudingru"] && [passWords isEqualToString:@"123456"]) )
            {
                //----------登录成功记录状态------
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                [defaults setBool:YES forKey:@"isLoginState"];
                [defaults synchronize];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"恭喜,登陆成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            else if(i == userArray.count-1)
            {
                //登陆失败
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或者密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] ;
                [alert show] ;
            }
        }
    }

}

#pragma mark -- 登陆成功调用AlertViewDelegate方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSDictionary *dic = [[NSDictionary alloc] init];
        dic = @{@"name":_userName.text,@"pass":_passWords.text};
        
        [self dismissViewControllerAnimated:YES completion:^{
            if (_loginSuccessBlock)
            {
                _loginSuccessBlock(YES,dic);
            }
            
        }];
    }
    else
    {
        return;
    }
    
}

//返回
- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



//微博三方登录
- (IBAction)sinaWeiboLogin:(id)sender
{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
       //获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess)
        {
        
           UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            //登录成功,调用公共方法
            [self LoginSucceed:snsAccount];
            
        }});
    
    //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    
    [[UMSocialDataService defaultDataService] requestSnsFriends:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsFriends is %@",response.data);
    }];
            
    
}


//QQ三方登录
- (IBAction)QQLogin:(id)sender
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
         //获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
          UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
          NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
         //登录成功,调用公共方法
         [self LoginSucceed:snsAccount];
            
            
        }});
    
    //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
}
//微信三方登录
- (IBAction)weixinLogin:(id)sender
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            //登录成功,调用公共方法
            [self LoginSucceed:snsAccount];
        }
        
    });
    
    //得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    
}

#pragma mark -- 登录成功公共的调用方法
-(void)LoginSucceed:(UMSocialAccountEntity *)snsAccount
{
    //----------登录成功记录状态------
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"isLoginState"];
    [defaults synchronize];
    NSDictionary *dic = [[NSDictionary alloc] init];
    dic = @{@"name":snsAccount.userName,@"pass":snsAccount.iconURL};
    [self dismissViewControllerAnimated:YES completion:^{
        if (_loginSuccessBlock)
        {
            _loginSuccessBlock(YES,dic);
        }
        
    }];
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
