//
//  NowHiringViewController.h
//  急招
//
//  Created by wjm on 15/7/17.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NowHiringTableViewCell.h"
@interface NowHiringViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NowHiringTableViewCellDelegate>
{
    
  
    __weak IBOutlet UITableView *dataTableView;
    int categaryType;
    NSMutableArray *receivedArray;
    NSMutableArray *commendArray;
}
@end
