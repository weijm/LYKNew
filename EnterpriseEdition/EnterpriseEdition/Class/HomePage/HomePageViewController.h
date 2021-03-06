//
//  HomePageViewController.h
//  app首页
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    
    __weak IBOutlet UITableView *contentTableView;
    
}
/**
 应聘部分的点击事件
 */
-(void)hireAction:(NSInteger)index;
/**
 查看简历
 */
-(void)lookupPersonalResume:(NSInteger) index;

/**
 重新加载hireView
 */
-(void)loadEmtyHireView;
@end
