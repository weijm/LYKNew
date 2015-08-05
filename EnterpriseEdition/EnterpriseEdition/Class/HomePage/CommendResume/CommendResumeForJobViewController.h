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
    
    __weak IBOutlet UITableView *dataTableView;
   
    
    NSMutableArray *dataArray;
    //选中状态的标志
    NSMutableArray *chooseArray;
}
@property (nonatomic) BOOL isForPisition;//职位收到的简历进入
@end
