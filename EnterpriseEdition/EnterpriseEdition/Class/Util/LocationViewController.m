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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //添加地图
    _mapView = [[QMapView alloc] initWithFrame:self.view.frame];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    

    
    
    [self.navigationController.navigationBar setBarTintColor:kNavigationBgColor];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //导航栏下面是否显示内容
    [self.navigationController.navigationBar setTranslucent:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    _mapView.showsUserLocation = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"location== %@",mapView.userLocation.title);
}
@end
