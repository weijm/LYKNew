//
//  ForgetPasswordViewController.h
//  忘记密码
//
//  Created by wjm on 15/7/25.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterTableViewCell.h"
@interface ForgetPasswordViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,RegisterTableViewCellDelegate>
{
    __weak IBOutlet NSLayoutConstraint *dataTableViewToTop;
    
    __weak IBOutlet UILabel *bottomLab;


}
@end
