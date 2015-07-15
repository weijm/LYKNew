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
@property(nonatomic,strong) QMapView *mapView;
@end
