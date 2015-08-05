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
@interface SearchResumeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,SearchResumeTableViewCellDelegate,FiltrateViewDelegate>
{
   
    __weak IBOutlet UITableView *dataTableView;
    NSMutableArray *dataArray;
    //选中状态的标志
    NSMutableArray *chooseArray;
}

@end
