//
//  SearchResumeViewController.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/20.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResumeTableViewCell.h"
#import "FiltrateView.h"
@class BaseTableView;
@interface SearchResumeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,SearchResumeTableViewCellDelegate,FiltrateViewDelegate>
{
   
    __weak IBOutlet BaseTableView *dataTableView;
    
    NSMutableArray *dataArray;
    //选中状态的标志
    NSMutableArray *chooseArray;
}

@end
