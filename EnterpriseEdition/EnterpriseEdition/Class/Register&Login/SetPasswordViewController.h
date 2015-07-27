//
//  SetPasswordViewController.h
//  忘记密码中的设置密码
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterTableViewCell.h"
@interface SetPasswordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RegisterTableViewCellDelegate>
{
    IBOutlet NSLayoutConstraint *dataTableViewToTop;
}
@end
