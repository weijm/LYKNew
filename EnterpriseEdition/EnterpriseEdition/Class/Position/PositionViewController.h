//
//  PositionViewController.h
//  职位
//
//  Created by wjm on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PositionShowTableViewCell.h"
@interface PositionViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PositionShowTableViewCellDelegate>
{
    int categaryType;//headerView上的选择类型 1有效职位 2下线职位 3待审核职位
    
    __weak IBOutlet BaseTableView *dataTableView;
    
    

}
@end
