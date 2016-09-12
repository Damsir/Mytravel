//
//  OurDetailViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/28.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "OurDetailViewController.h"

@interface OurDetailViewController ()

@end

@implementation OurDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:180/255.0 green:250/255.0 blue:254/255.0 alpha:1.0];
    [self createUI];
}

-(void)createUI
{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"iconfont-back-1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    icon.center = CGPointMake(SCREENWIDTH/2.0, 100);
    icon.image = [UIImage imageNamed:@"AppIcon60x60"];
    icon.layer.cornerRadius = 10;
    icon.clipsToBounds = YES;
    [self.view addSubview:icon];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    title.center = CGPointMake(SCREENWIDTH/2.0, CGRectGetMaxY(icon.frame)+20);
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"游趣v1.0";
    [self.view addSubview:title];
    
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(title.frame)+30, SCREENWIDTH-20, 100)];
    detail.numberOfLines = 0;
   // detail.font = [UIFont systemFontOfSize:15];
    detail.text = @"游趣是一款记录旅行轨迹,图文并茂而且有视频分享和播放功能,让你如同亲临其中,可以查看景点信息,还能根据你的目的地查询天气状况的APP.";
    [self.view addSubview:detail];
    
    UILabel *contact = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(detail.frame)+20, SCREENWIDTH-20, 30)];
    contact.text = @"联系我们:";
    [self.view addSubview:contact];
    
    UILabel *QQ = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(contact.frame)+10, SCREENWIDTH-20, 30)];
    QQ.text = @"QQ:876285298";
    [self.view addSubview:QQ];
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(QQ.frame)+10, SCREENWIDTH-20, 30)];
    author.text = @"作者:吴定如";
    [self.view addSubview:author];
    UILabel *other = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(author.frame)+10, SCREENWIDTH-20, 30)];
    other.text = @"参与制作:李康";
    [self.view addSubview:other];
    
}
-(void)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
