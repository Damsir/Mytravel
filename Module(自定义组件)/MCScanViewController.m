//
//  MCScanViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/11/19.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MCScanViewController.h"
#import <AVFoundation/AVFoundation.h>//扫一扫功能库

@interface MCScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

//  扫一扫的会话层
@property (nonatomic,strong)AVCaptureSession *session;

// 扫描的视图层,以视频录像的方式展现
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation MCScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor colorWithRed:180/255.0 green:250/255.0 blue:254/255.0 alpha:1.0];
//    [self createBackBtn];/
    [self Scan];
}
#pragma mark -- 扫一扫实现
-(void)Scan
{
    // 初始化设备样式
    AVCaptureDevice *device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error;
    
    // 初始化输入流
    AVCaptureDeviceInput *input=[[AVCaptureDeviceInput alloc]initWithDevice:device error:&error];
    
    if (error)
    {
        // 通常的错误是无设备可用
        NSLog(@"%@",error);
        return;
    }
    
    // 定义数据输出流
    AVCaptureMetadataOutput *output=[[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 会话
    AVCaptureSession *session=[[AVCaptureSession alloc]init];
    
    // 把输入输出流添加到会话上面
    [session addInput:input];
    [session addOutput:output];
    
    // 设置输出扫描的对象为二维码
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 视频类型的视图扫描,把会话添加到视频视图里面
    AVCaptureVideoPreviewLayer *preView=[[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
    // 把视频类型的layer 添加到我的视图控制器上面,添加到最上层
    preView.frame=CGRectMake(0, 0, self.view.layer.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:preView above:0];
    
    //开始会话
    self.session=session;
    self.previewLayer=preView;
    [self.session startRunning];


}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // 找到扫描得到的数据里面的设备数据
    AVMetadataMachineReadableCodeObject *objec=metadataObjects.firstObject;
    NSLog(@"%@",objec.stringValue);
    
    if(self.session)
    {
        // 停止扫描会话
        [self.session stopRunning];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:objec.stringValue]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- 返回按钮
-(void)createBackBtn
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(15, 25, 40, 40);
    [btn setImage:[UIImage imageNamed:@"detailBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
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
