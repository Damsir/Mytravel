//
//  MineViewController.m
//  TravelFun
//
//  Created by 吴定如 on 15/11/26.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "LoginViewController.h"//登陆
#import "SuggestionViewController.h"//建议
#import "MyCollectViewController.h"//收藏

static CGFloat ImageOriginHight = 300.0f;
static CGFloat TempHeight = 15.0f;

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UMSocialUIDelegate>
{
    UIImageView *header;
    UITableView *MineTable;
    UIButton *icon;//用户头像
    UIButton *login;//登陆按钮
    UIImagePickerController *imagePicker;
    UIImage *image;//选择的头像
    long long size;//缓存大小
    NSString *path;//缓存路径
    NSInteger isClickIcon;//区分点击的是头像还是登录按钮
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMineView];
    //[self checkLastLoginUser];
    
}
//检测上次登录账户是否存在
-(void)checkLastLoginUser
{
    NSMutableArray *userArray = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/userInfo.plist",NSHomeDirectory()]];
    NSLog(@"====----====%@=====%@",userArray,NSHomeDirectory());
    if (userArray.count == 0)
    {
        return;
    }
    else
    {
        
        NSDictionary *userDic = [userArray lastObject];
        icon.userInteractionEnabled = YES;//登陆成功可设置头像
        NSString *userName = userDic[@"name"];
        [login setTitle:[NSString stringWithFormat:@"Hi,%@",userName] forState:UIControlStateNormal];
        login.titleLabel.font = [UIFont systemFontOfSize:12];
        //----------登录成功记录状态------
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"isLoginState"];
        [defaults synchronize];
    }
    if (![login.titleLabel.text isEqualToString:@"点此登录"])
    {
        [login addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)createMineView
{
    MineTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    MineTable.contentInset = UIEdgeInsetsMake(ImageOriginHight, 0, 0, 0);
    MineTable.tableFooterView = [[UIView alloc] init];
    MineTable.delegate=self;
    MineTable.dataSource=self;
    [self.view addSubview:MineTable];
    [MineTable registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineTableViewCell"];

    
    header = [[UIImageView alloc] initWithFrame:CGRectMake(0, -ImageOriginHight-TempHeight, SCREENWIDTH, ImageOriginHight+TempHeight)];
    header.userInteractionEnabled = YES;
    header.image = [UIImage imageNamed:@"my"];
    [MineTable addSubview:header];
    
    
    icon = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    icon.tag = 1000;
    icon.userInteractionEnabled = NO;
    icon.center = CGPointMake(SCREENWIDTH/2.0, header.bounds.size.height/2.0+20);
    icon.layer.cornerRadius = icon.bounds.size.width/2.0;
    icon.clipsToBounds = YES;
    [icon setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [icon addTarget:self action:@selector(changeIcon) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:icon];
    icon.imageView.contentMode=UIViewContentModeScaleAspectFill;
    
    login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.tag = 1001;
    [login setTitle:@"点此登录" forState:UIControlStateNormal];
    login.backgroundColor = [UIColor whiteColor];
    login.layer.cornerRadius = 15;
    login.clipsToBounds = YES;
    [login setTitleColor:[UIColor colorWithRed:34/255.0 green:171/255.0 blue:38/255.0 alpha:1] forState:UIControlStateNormal];
    login.frame = CGRectMake(0, 0, 100, 30);
    login.center = CGPointMake(SCREENWIDTH/2.0, header.bounds.size.height/2.0+80);
    if ([login.titleLabel.text isEqualToString:@"点此登录"])
    {
        [login addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [header addSubview:login];
    
}
#pragma mark -- 更换头像
-(void)changeIcon
{
    isClickIcon = icon.tag;
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
    sheet.delegate = self;
    [sheet showInView:self.view];
}

#pragma mark -- sheet代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //选取头像的代理
    if (isClickIcon == icon.tag)
    {
        if (buttonIndex == 0)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else if (buttonIndex == 1)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else
        {
            return;
        }
        [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
        //[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePicker animated:YES completion:nil];
    }
    //登录按钮的代理
    else if (isClickIcon == login.tag)
    {
        //------------ 注销登录----------
        if (buttonIndex == 0)
        {
            //----------注销成功记录状态------
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setBool:NO forKey:@"isLoginState"];
            [defaults synchronize];
            
            [icon setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
            icon.userInteractionEnabled = NO;//注销成功不可设置头像
            
            [login setTitle:@"点此登录" forState:UIControlStateNormal];
            login.titleLabel.font = [UIFont systemFontOfSize:18];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注销成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        else if (buttonIndex == 1)
        {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.view.window.rootViewController presentViewController:loginVC animated:YES completion:nil];
        }
        else
        {
            return;
        }
    }
}
//图片库方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image = info[@"UIImagePickerControllerOriginalImage"];
    [icon setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
   
}

#pragma mark -- 登陆
-(void)Login
{
    isClickIcon = login.tag;
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    if ([login.titleLabel.text isEqualToString:@"点此登录"])
    {
        loginVC.loginSuccessBlock = ^(BOOL isSuccees,NSDictionary *userDic)
        {
            if (isSuccees)
            {
                [icon setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:userDic[@"pass"]] placeholderImage:[UIImage imageNamed:@"login"]];
                //[icon setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:userDic[@"pass"]] placeholderImage:[UIImage imageNamed:@"login"]];
                
                icon.userInteractionEnabled = YES;//登陆成功可设置头像
                
                NSString *userName = userDic[@"name"];
                [login setTitle:[NSString stringWithFormat:@"Hi,%@",userName] forState:UIControlStateNormal];
                login.titleLabel.font = [UIFont systemFontOfSize:12];
                
                if (![login.titleLabel.text isEqualToString:@"点此登录"])
                {
                    [login addTarget:self action:@selector(ChangeLoginState) forControlEvents:UIControlEventTouchUpInside];
                }
            };
        };
      [self.view.window.rootViewController presentViewController:loginVC animated:YES completion:nil];
        
    }
   
}
#pragma mark -- 注销以及切换账号
-(void)ChangeLoginState
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"注销",@"切换账号", nil];
    [sheet showInView:self.view];
}


#pragma mark -- table代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titles = @[@"我的收藏",@"建议反馈",@"清除缓存",@"分享游趣"];
    NSArray *images = @[@"collection",@"idea",@"clear",@"ShareMyAPP"];
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell"];
    cell.title.text = titles[indexPath.row];
    cell.image.image = [UIImage imageNamed:images[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark -- hearder放大效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat Offset_y  = scrollView.contentOffset.y;
    CGFloat Offset_x = (Offset_y + ImageOriginHight)/1.5;
    
    if ( ABS(Offset_y) > ImageOriginHight)
    {
        CGRect frame = MineTable.frame;
        frame.origin.y = Offset_y - TempHeight;
        frame.size.height =  -Offset_y + TempHeight;
        frame.origin.x = Offset_x;
        frame.size.width = SCREENWIDTH +  ABS(Offset_x)*2;
        header.frame = frame;
        
        icon.bounds = CGRectMake(0, 0, 60-Offset_x/4.0, 60-Offset_x/4.0);
        icon.center = CGPointMake((SCREENWIDTH+ ABS(Offset_x)*2)/2.0,(-Offset_y + TempHeight) /2.0+20);
        icon.layer.cornerRadius = (60-Offset_x/4.0)/2.0;
        
        login.center = CGPointMake((SCREENWIDTH+ ABS(Offset_x)*2)/2.0,(-Offset_y + TempHeight) /2.0+80);
    }
}

#pragma mark -- Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0)
    {
        MyCollectViewController *collectVC = [[MyCollectViewController alloc] init];
        [self.view.window.rootViewController presentViewController:collectVC animated:YES completion:nil];
    }
    else if (indexPath.row == 1)
    {
        SuggestionViewController *suggestVC = [[SuggestionViewController alloc] init];
        [self.view.window.rootViewController presentViewController:suggestVC animated:YES completion:nil];
    }
    else if (indexPath.row == 3)
    {
        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"564d338fe0f55a9b9f009196" shareText:@"游趣-一款非常棒的旅行APP,让你的周末不再烦恼!" shareImage:[UIImage imageNamed:@"login"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone, UMShareToRenren,UMShareToSina,UMShareToTencent,nil] delegate:self];
    }
    
    //清理缓存
    else
    {
        dispatch_async(
          dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                , ^{
                    NSString *CachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    NSLog(@"CachesPath路径:%@", CachesPath);
                    
                    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:CachesPath];
                    NSLog(@"files个数:%ld",[files count]);
                    for (NSString *p in files) {
                        
                        path = [CachesPath stringByAppendingPathComponent:p];
                        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                            NSError *error;
                            size = [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
                            NSLog(@"==%lf",size/1024.0/1024.0);
                            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                        }
                    }
                [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    }
}
-(void)clearCacheSuccess
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"共有缓存: %.2lfMB",size/1024.0/1024.0] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
  
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
          NSLog(@"清理成功");
    }
    else
    {
        return;
    }
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
