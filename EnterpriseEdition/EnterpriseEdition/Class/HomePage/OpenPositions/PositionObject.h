//
//  PositionObject.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface PositionObject : NSObject
/**
 单实例
 */
+(id)shareInstance;
/**
 获取省市区的id
 */
-(int)getProvinceOrCityOrAreas:(int)fid Name:(NSString*)name;
/**
 获取行业的id
 */
-(int)getIndustryIds:(int)fid Name:(NSString*)name;
/**
 获取职位名称的Ids
 */
-(int)getJobTypeIds:(int)fid Name:(NSString*)name;
/**
 获取民族
 */
-(NSString*)getNationStringById:(int)nationID;
@end
