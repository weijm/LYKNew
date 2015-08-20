//
//  NdUncaughtExceptionHandler.h
//  EnterpriseEdition
//
//  Created by lyk on 15/8/19.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NdUncaughtExceptionHandler : NSObject
{
}
+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler*)getHandler;
@end
