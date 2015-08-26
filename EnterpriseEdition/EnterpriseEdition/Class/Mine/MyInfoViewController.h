//
//  MyInfoViewController.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    __weak IBOutlet UITableView *dataTableView;

    
}
@end
