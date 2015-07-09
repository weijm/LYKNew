//
//  HomePageViewController.h
//  app首页
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    
}
/**
 应聘部分的点击事件
 */
-(void)hireAction:(NSInteger)index;
/**
 查看某个人的简历
 */
-(void)lookupPersonalResume:(NSInteger) index;
@end
