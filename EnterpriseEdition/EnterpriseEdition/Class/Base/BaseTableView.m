//
//  BaseTableView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "BaseTableView.h"
#import "MJRefresh.h"

@implementation BaseTableView

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    
    
    self.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.footerRefreshingText = @"加载更多数据";
}
- (void)footerRereshing
{
    //实际请求数据
    self.refreshData();
    // 1.添加假数据
    //    for (int i = 0; i<5; i++) {
    //        [self.fakeData addObject:MJRandomData];
    //    }
    
    // 2.2秒后刷新表格UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self reloadData];
//        NSLog(@"footerRereshing footerEndRefreshing");
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self footerEndRefreshing];
//    });
}

- (void)stopRefresh
{
    [self footerEndRefreshing];
}

@end
