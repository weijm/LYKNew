//
//  RegisterUserViewController.h
//  注册
//
//  Created by wjm on 15/7/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterTableViewCell.h"
@interface RegisterUserViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,RegisterTableViewCellDelegate>
{
    __weak IBOutlet NSLayoutConstraint *dataTableViewToTop;
    __weak IBOutlet UITableView *dataTableView;
    __weak IBOutlet UILabel *topLab;
    
}
@end
