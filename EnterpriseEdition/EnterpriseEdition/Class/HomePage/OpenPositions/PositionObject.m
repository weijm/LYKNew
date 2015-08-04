//
//  PositionObject.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionObject.h"

@implementation PositionObject
//单实例
+(id)shareInstance
{
    static PositionObject *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        instance = [self new];
    });
    return instance;
}
@end
