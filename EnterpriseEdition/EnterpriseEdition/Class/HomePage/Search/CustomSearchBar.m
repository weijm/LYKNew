//
//  CustomSearchBar.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/3.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "CustomSearchBar.h"

@implementation CustomSearchBar



- (void)layoutSubviews
{
    UITextField *searchField = [self valueForKey:@"_searchField"];
//    if (searchField) {
//        searchField.textColor = [UIColor whiteColor];
//    }
//
//    for(id view in self.subviews)
//    {
//        if([view isKindOfClass:[UITextField class]])
//        {
//            searchField = view;
//            break;
//        }
//    }
    
    if(!(searchField == nil))
    {
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextFillRect(context, rect);
        UIImage * bgImage = [[UIImage alloc] init];
        bgImage = UIGraphicsGetImageFromCurrentImageContext();
        
        
        searchField.background = [UIImage imageNamed:@"resume_search_bg"];;
//        searchField.backgroundColor =
        searchField.placeholder = @"搜索                                                      ";
        searchField.borderStyle = UITextBorderStyleBezel;
        UIImage *image = [UIImage imageNamed: @"homepage_search_bt"];
        UIImageView *iView = [[UIImageView alloc] initWithImage:image];
        [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];//新加代码，修改placeholder文字颜色，上截图时没这效果，测试可行
        searchField.leftView = iView;
    }
    
    [super layoutSubviews];
}
@end
