//
//  NSString+Extension.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString(Extension)
//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
