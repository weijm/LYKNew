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

@interface OpenPositionViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PositionTableViewCellDelegate>
{
    __weak IBOutlet UITableView *dataTableView;
    //当前编辑的视图
    UIView *editView;
    //tableView距离下面的距离
    __weak IBOutlet NSLayoutConstraint *dataTableViewToBottom;
    
    __weak IBOutlet NSLayoutConstraint *dataTableViewToTop;
    __weak IBOutlet NSLayoutConstraint *lineWidth;
    
    __weak IBOutlet NSLayoutConstraint *promptTotop;
}
@property (nonatomic) BOOL isEditAgain;//是否再次编辑
@property (nonatomic) BOOL fromPositionManager;//是否从职位管理里面进入的添加
@property (nonatomic,strong) NSDictionary *infoDic;
/**
 将数据保存到本地
 */
- (IBAction)saveDataAction:(id)sender;
/**
 提交要发布的职位
 */
- (IBAction)commitAction:(id)sender;



@end
