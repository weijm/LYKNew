//
//  ChangePasswordViewController.h
//  修改密码
//
//  Created by wjm on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePasswordTableViewCell.h"
@interface ChangePasswordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ChangePasswordTableViewCellDelegate>
{
    UITextField *currentTextField;
    NSMutableArray *contentArray;
}
/**
 下一步的触发事件
 */
- (IBAction)nextAction:(id)sender;
@end