//
//  InfoViewController.h
//  信息首页
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoTableViewCell.h"

@interface InfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,InfoTableViewCellDelegate>
{
    
    __weak IBOutlet UITableView *dataTableView;
    NSMutableArray *dataArray;
}
@end
