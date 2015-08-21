//
//  ChangePasswordViewController.h
//  修改密码
//
//  Created by wjm on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePasswordTableViewCell.h"
@interface ChangePasswordViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ChangePasswordTableViewCellDelegate>
{
    UITextField *currentTextField;
    NSMutableArray *contentArray;
    
    __weak IBOutlet UILabel *phoneLab;
    
    
    __weak IBOutlet NSLayoutConstraint *tableToBottom;
    __weak IBOutlet NSLayoutConstraint *nextBtToLine;
}
/**
 下一步的触发事件
 */
- (IBAction)nextAction:(id)sender;
@end
