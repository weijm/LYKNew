//
//  OpenPositionViewController.h
//  发布职位
//
//  Created by wjm on 15/7/17.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltratePickerView.h"
#import "PositionTableViewCell.h"

@interface OpenPositionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PositionTableViewCellDelegate>
{
    IBOutlet UITableView *dataTableView;
    //当前编辑的视图
    UIView *editView;
    //tableView距离下面的距离
    IBOutlet NSLayoutConstraint *dataTableViewToBottom;
    
    IBOutlet NSLayoutConstraint *dataTableViewToTop;
}
/**
 将数据保存到本地
 */
- (IBAction)saveDataAction:(id)sender;
/**
 提交要发布的职位
 */
- (IBAction)commitAction:(id)sender;



@end
