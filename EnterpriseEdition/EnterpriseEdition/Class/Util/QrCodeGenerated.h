//
//  QrCodeGenerated.h
//  EnterpriseEdition
//
//  Created by lyk on 15/9/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QrCodeGenerated : NSObject
/**
 单实例
 */
+(id)sharedInstance;

/**
 将字符窜生成对应的二维码
 */
-(UIImage*)generatedQrCodeImageByContent:(NSString*)contentString;
@end
