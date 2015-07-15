//
//  Util.m
//  公共方法类
//
//  Created wjm  on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "Util.h"

@implementation Util
#pragma mark -  获取不同设备视图的宽度
+(float)myXOrWidth:(float)xOrWidth
{
    float var1 = autoSizeScaleX;
    float newVar = xOrWidth *var1;
    return newVar;
}
#pragma mark - 获取不同设备的视图高度
+(float)myYOrHeight:(float)yOrHeight
{
    float var1 = autoSizeScaleY;
    float newVar = yOrHeight *var1;
    return newVar;
}
#pragma mark -正则表达式 手机号码验证

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10 * 中国移动：China Mobile
     11 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12 */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15 * 中国联通：China Unicom
     16 * 130,131,132,152,155,156,185,186
     17 */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20 * 中国电信：China Telecom
     21 * 133,1349,153,180,189
     22 */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25 * 大陆地区固话及小灵通
     26 * 区号：010,020,021,022,023,024,025,027,028,029
     27 * 号码：七位或八位
     28 */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 根据数组中的类名称，title，image 生成tabbar的Viewcontrollers
+(NSMutableArray*)generateViewControllerByName:(NSDictionary*)classInfoDic
{
    NSArray *titleArray = [classInfoDic objectForKey:@"title"];
    NSArray *classArray = [classInfoDic objectForKey:@"name"];
    NSArray *imageArray = [classInfoDic objectForKey:@"image"];
    NSMutableArray *vcArray = [[NSMutableArray alloc] initWithCapacity:titleArray.count];
    for (int i =0; i < [classArray count]; i++) {
        NSString *classString = [NSString stringWithFormat:@"%@ViewController",classArray[i]];
        //创建控制器
        UIViewController *vc = [[NSClassFromString(classString) alloc] init];
        //设置title
        if (titleArray.count>0) {
            vc.title = titleArray[i];
            
        }
        //设置image
        if (imageArray.count>0) {
            vc.tabBarItem.image = [UIImage imageNamed:imageArray[i]];
        }
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:vc];
        if (kDeviceVersion >=7.0) {
            //设置navigation的背景
            [navigation.navigationBar setBarTintColor:kNavigationBgColor];
           // 设置navigation的title颜色
            NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
            textAttrs[NSForegroundColorAttributeName]=[UIColor whiteColor];
            [navigation.navigationBar setTitleTextAttributes:textAttrs];
        }
        [vcArray addObject:navigation];
    }
    return vcArray;
}
#pragma mark - 获取bundle下文件的路径
+(NSString*)getBundlePath:(NSString*)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@""];
    return filePath;
}
//根据颜色获取对应色值的图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
//随机生成颜色
+(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
// 随机生成匹配度
+(NSInteger)randomRate
{
    CGFloat result = (arc4random() % 9 + 1)*10+(arc4random() % 9 + 1);
    return result;
}
//根据总数和每行显示的个数计算行数
+(int)getRow:(int)total eachCount:(int)count
{
    int row;
    if (total%count ==0) {
        row = total/count;
    }else
    {
        row = total/count+1;
    }
    return row;
}
@end
