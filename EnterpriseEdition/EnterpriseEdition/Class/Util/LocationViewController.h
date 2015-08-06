//
//  LocationViewController.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/14.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMapKit/QMapKit.h>
@interface LocationViewController : UIViewController<QMapViewDelegate>
{
    QMapView *_mapView;
    BOOL isStart;
}
+(id)shareInstance;
//初始化定位
-(void)loadLocation;
//开始定位
-(void)startLocation;
//停止定位
-(void)stopLocation;
@end
