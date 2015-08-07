//
//  BaseTableView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/8/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UITableView
@property (nonatomic,copy)void(^refreshData)(void);
- (void)setupRefresh;
- (void)footerRereshing;
- (void)stopRefresh;
@end
