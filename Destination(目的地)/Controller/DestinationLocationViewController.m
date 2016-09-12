//
//  DestinationLocationViewController.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/1.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "DestinationLocationViewController.h"
//地图使用的系统库
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotationView.h"

@interface DestinationLocationViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>//地图的代理协议

@property (nonatomic,strong) MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLGeocoder *geocoder;//地图经纬度编码，反编码
@property(nonatomic,strong) CLPlacemark *placeMark;//位置信息

@end

@implementation DestinationLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMapView];
    [self createBackBtn];

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
    self.mapView.showsUserLocation = YES;
    CLLocation *location=locations.firstObject;
     NSLog(@"经纬度＝＝＝＝＝:%f,%f",location.coordinate.latitude,location.coordinate.longitude);
    //把响应的地图经纬度转成地址
    //初始化一个地图经纬度转码器
    self.geocoder=[[CLGeocoder alloc]init];
    //转码经纬度为地址
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
     {
         //转码后地址对像
         _placeMark = placemarks.firstObject;
          NSLog(@"------- %@ ====== %@",_placeMark.name,_placeMark.locality);
     }];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(1.1, 1.1));
    //MKCoordinateSpan 这个是设置跨度
    [_mapView setRegion:region];
    
    MyAnnotation *point = [[MyAnnotation alloc]initWithCLLocation:coordinate];
    point.Title = @"您当前的位置";
    point.Subtitle = _placeMark.name;
    [_mapView addAnnotation:point];
    
}
//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
}
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
        
    }
    return view;
}

-(void)createBackBtn
{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}
-(void)Back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"====%@",_placeMark.locality);
        _locationNameBlock(_placeMark.locality);
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
