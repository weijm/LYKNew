//
//  SetPasswordViewController.h
//  忘记密码中的设置密码
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterTableViewCell.h"
@interface SetPasswordViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,RegisterTableViewCellDelegate>
{
    __weak IBOutlet NSLayoutConstraint *dataTableViewToTop;
   
}
@property (nonatomic,strong) NSString *verifyCode;
@end
