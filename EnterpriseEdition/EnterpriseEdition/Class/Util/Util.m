//
//  Util.m
//  公共方法类
//
//  Created wjm  on 15/7/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "Util.h"

@implementation Util
#pragma mark - 获取不同设备字体的大小
+(float)myFontSize:(float)fontSize
{
    float _fontSize = fontSize;
    if (kIphone5||kIphone4) {
        _fontSize = fontSize-2;
    }else if(kIphone6plus)
    {
        _fontSize = fontSize+1;
    }
    return _fontSize;
}
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

//+ (BOOL)isMobileNumber:(NSString *)mobileNum
//{
//    
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10 * 中国移动：China Mobile
//     11 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12 */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15 * 中国联通：China Unicom
//     16 * 130,131,132,152,155,156,185,186
//     17 */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20 * 中国电信：China Telecom
//     21 * 133,1349,153,180,189
//     22 */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    /**
//     25 * 大陆地区固话及小灵通
//     26 * 区号：010,020,021,022,023,024,025,027,028,029
//     27 * 号码：七位或八位
//     28 */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}

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
//判断字符串是否为空
+(NSString*)getCorrectString:(NSString*)string
{
    if (string == nil) {
        return @"";
    }
    if ([[[string class] description] isEqualToString:@"NSNull"]) {
        return @"";
    }
    if ([string isKindOfClass:[NSString class]]) {
        if (string!=nil && ![string isEqualToString:@"<null>"]) {
            return string;
        }else
        {
            return @"";
        }
    }
    return string;
}
//验证码密码
+(BOOL)checkPassWord:(NSString *)passWord
{
    //正则表达式
    NSString *passRules=@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    //谓词匹配
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",passRules];
    BOOL isMatch=[pred evaluateWithObject:passWord];
    if(passWord.length==0)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"密码不能为空", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else if(passWord.length<6)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"密码不能少于6位数", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else if(!isMatch)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"请输入6～16位字母和数字组合的密码", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else
    {
        return YES;
    }
}
//检查手机号码
+ (BOOL)checkTelephone:(NSString *)phone
{
    if ([phone length] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"手机号码不能为空", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else  if ([phone length]>11) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"手机号码不得超过11位", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }

    NSString *regex = @"^((100)|(13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9]))\\d{8}$";
    //谓词匹配
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phone];
    if (!isMatch) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}
/**
 校验网址正确
 */
+(BOOL)checkWebSite:(NSString*)string
{
    NSString *regex = @"\\bwww?.[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    //谓词匹配
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    if (!isMatch) {
        
        return NO;
    }
    return YES;

}
//提示信息
+(void)showPrompt:(NSString*)promptString
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(promptString, nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
+(BOOL)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}
+(BOOL)isPureInt:(NSString*)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    NSInteger val;
    
    return [scan scanInteger:&val]&&[scan isAtEnd]&&[string integerValue]>0;
}
#pragma mark - 文件的相关操作
+(void)printBugContent
{
    NSArray *array = [self getSubFileInDocument];
    NSLog(@"array == %@",array);
    for (int i =0; i< [array count]; i++) {
        NSString *fileName = [array objectAtIndex:i];
        if ([fileName hasSuffix:@".txt"]) {
            NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self documentPath],fileName];
            NSString *fileStr = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"fileString %d == %@",i,fileStr);
        }
    }
}
// 获取document下得子文件
+(NSArray*)getSubFileInDocument
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //在这里获取应用程序Documents文件夹里的文件及文件夹列表
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [documentPaths objectAtIndex:0];
    
    NSError *error = nil;
    
    NSArray *fileList = nil;
    
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    
    fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];
    return fileList;

    
}
//document的路径
+(NSString*)documentPath
{
    NSString *docPath = nil;
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docPath = [searchPaths firstObject];
    return docPath;
}
// 复制原文件到指定目录
+(BOOL)copyFile:(NSString*)originalPath To:(NSString*)targetPath
{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSError *error;
    if (![filemanager copyItemAtPath:originalPath toPath:targetPath error:&error]) {
        NSLog(@"copy file error %@",[error localizedDescription]);
        return NO;
    }
    return YES;
}
// 用户的数据库文件路径
+(NSString*)getSQLitePath
{
    NSString *dbPath = [NSString stringWithFormat:@"%@/data.sqlite",[self documentPath]];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if (![filemanager fileExistsAtPath:dbPath]) {
        NSString *bundelPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite"];
        if (![self copyFile:bundelPath To:dbPath]) {
            NSLog(@"getSQLitePath copy file error");
        }
    }
    return dbPath;
}
// 图片保存路径
+(NSString *)getFileDir
{
    NSString *fileDir;
    fileDir = [[Util documentPath] stringByAppendingPathComponent:@"File"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return fileDir;
}
// 判断文件是否存在
+(BOOL)isExistsFile:(NSString*)filePath
{
    NSFileManager *filemanage = [NSFileManager defaultManager];
    
    return [filemanage fileExistsAtPath:filePath];
}
//将json转换为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+(int)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
    
}
+(NSString*)getPositionTitle:(NSString*)title
{
    NSString *tit = [self getCorrectString:title];
    NSString *resultStr = nil;
    
    if ([tit length]>4) {
         resultStr = [NSString stringWithFormat:@"%@...收到的简历",[tit substringToIndex:4]];
    }else
    {
        resultStr = [NSString stringWithFormat:@"%@收到的简历",tit];
    }
    return resultStr;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}




@end
