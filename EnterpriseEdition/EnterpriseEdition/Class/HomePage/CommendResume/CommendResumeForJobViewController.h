//
//  CommendResumeForJobViewController.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommendResumeForJobTableViewCell.h"
#import "FiltrateView.h"
@interface CommendResumeForJobViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CommendResumeForJobTableViewCellDelegate,FiltrateViewDelegate>
{
    
    IBOutlet UITableView *dataTableView;
    
    NSMutableArray *dataArray;
    //选中状态的标志
    NSMutableArray *chooseArray;
}
@end
