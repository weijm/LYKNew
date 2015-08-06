//
//  LocationViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/14.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController
+(id)shareInstance
{
    static LocationViewController *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        instance = [self new];
    });
    return instance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //添加地图
//    _mapView = [[QMapView alloc] initWithFrame:self.view.frame];
//    _mapView.delegate = self;
//    [self.view addSubview:_mapView];
//    _mapView.showsUserLocation = YES;
    

    
    
    [self.navigationController.navigationBar setBarTintColor:kNavigationBgColor];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //导航栏下面是否显示内容
    [self.navigationController.navigationBar setTranslucent:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadLocation
{
    //添加地图
    _mapView = [[QMapView alloc] initWithFrame:self.view.frame];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    isStart = NO;
}
-(void)startLocation
{
    _mapView.showsUserLocation = YES;
    isStart = YES;
}
-(void)stopLocation
{
    _mapView.showsUserLocation = NO;
    isStart = NO;

}
#pragma mark - QMapViewDelegate
-(void)mapViewWillStartLocatingUser:(QMapView *)mapView
{
    //获取开始定位的状态
    
}
-(void)mapViewDidStopLocatingUser:(QMapView *)mapView
{
    //获取停止定位的状态
    
}
-(void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setDouble:userLocation.location.coordinate.latitude forKey:kLatitude];
    [userDefault setDouble:userLocation.location.coordinate.longitude forKey:kLongitude];
    [userDefault synchronize];
    if (!isStart) {
        _mapView.showsUserLocation = NO;
    }
    
}
@end
