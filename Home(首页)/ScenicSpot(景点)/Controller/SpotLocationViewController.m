//
//  SpotLocationViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright (c) 2015年 Dam. All rights reserved.
//

#import "SpotLocationViewController.h"
//地图使用的系统库
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotationView.h"

@interface SpotLocationViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>//地图的代理协议

@property (nonatomic,strong) MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLGeocoder *geocoder;//地图经纬度编码，反编码
@property(nonatomic,strong) CLPlacemark *placeMark;//位置信息

@end

@implementation SpotLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createMapView];
    [self createBackBtn];
   
}
-(void)createBackBtn
{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

-(void)createMapView
{
    //MKMapView是系统集成的 地图视图，以可视化view的方式展现地图
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    //    设置地图是否支持滑动
    [_mapView setScrollEnabled:YES];
    //    设置地图是否支持旋转
    [_mapView setRotateEnabled:YES];
    //    设置地图是否支持缩放捏合
    [_mapView setZoomEnabled:YES];
    
    
    //给地图添加自定义大头针(纬度,经度)
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[_model.location objectForKey:@"lat"] floatValue],[[_model.location objectForKey:@"lng"] floatValue]);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.8, 0.8));
    //MKCoordinateSpan 这个是设置跨度
    [_mapView setRegion:region];
    
    MyAnnotation *point = [[MyAnnotation alloc]initWithCLLocation:coordinate];
    point.Title = @"景点位置";
    point.Subtitle = _model.name;
    [_mapView addAnnotation:point];
    
    //定位当前位置
    [self location];
}
#pragma mark -- 定位当前位置
-(void)location
{
    // 是否开启了定位
    if([CLLocationManager locationServicesEnabled])
    {
        // 创建一个定位的管理类
        self.locationManager=[[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        // 验证提示用户是否开启定位功能
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
        // 开始刷新定位功能
        [self.locationManager startUpdatingLocation];
        //刷新频率
        self.locationManager.distanceFilter = 100.0;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.mapView.showsUserLocation=YES;
    CLLocation *location=locations.firstObject;
   // NSLog(@"经纬度＝＝＝＝＝:%f,%f",location.coordinate.latitude,location.coordinate.longitude);
    //把响应的地图经纬度转成地址
    //初始化一个地图经纬度转码器
    self.geocoder=[[CLGeocoder alloc]init];
    //转码经纬度为地址
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
    {
        //转码后地址对像
        _placeMark = placemarks.firstObject;
        NSLog(@"--%@===%@",_placeMark.name,_placeMark.locality);
        
    }];
    
    CLLocationCoordinate2D coordinate1 = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude);
    
    MyAnnotation *point1 = [[MyAnnotation alloc]initWithCLLocation:coordinate1];
    point1.Title = @"您当前的位置";
    point1.Subtitle = _placeMark.name;
    [_mapView addAnnotation:point1];
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}
#pragma mark -- 目标定位
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    //大头针的复用机制，不用重复创建相同的大头针
    static NSString *identifier = @"myMap";
    
    MyAnnotationView *view = (MyAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!view)
    {
        view = [[MyAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        [view setCanShowCallout:YES];
        [view setEnabled:YES];
        [view setImage:[UIImage imageNamed:@"IconDestination"]];
        
        // 设置自定义View
//        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30.0)];
//        lab.center = CGPointMake(view.center.x+5, view.center.y-20);
//        lab.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
//        lab.textAlignment = NSTextAlignmentCenter;
//        lab.font=[UIFont systemFontOfSize:16.0];
//        lab.numberOfLines=0;
//        lab.text = _model.name ;
//        [view addSubview:lab];
        
    }
    return view;
}

//选择大头针
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //这个方法类似 tableview 的cell选择
    MyAnnotationView *view1 = (MyAnnotationView *)view;
    NSLog(@"%@",view1.myInfo.Subtitle);
//    NSLog(@"%@",view1.myInfo.Title);
    
}









-(void)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   // [self dismissViewControllerAnimated:YES completion:nil];
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
