//
//  PositionInfoViewController.h
//  职位详情
//
//  Created by wjm on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
    __weak IBOutlet UITableView *dataTableView;
    __weak IBOutlet UITextView *proTextView;
    __weak IBOutlet UIView *promptBg;
    
    __weak IBOutlet NSLayoutConstraint *tableViewToTop;
    
    
}
@property (nonatomic) BOOL reviewTips;
@property (nonatomic,strong) NSString  *jobId;
@property (nonatomic) BOOL isUrgent;
@end
