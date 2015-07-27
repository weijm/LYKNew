//
//  EnterpriseInfoViewController.h
//  企业资料
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnterpriseBaseTableViewCell.h"
#import "EnterpriseImgTableViewCell.h"
#import "FiltratePickerView.h"

@interface EnterpriseInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EnterpriseBaseTableViewCellDelegate,EnterpriseImgTableViewCellDelegate,UIActionSheetDelegate>
{
    IBOutlet UILabel *promptLab;
    
    
    IBOutlet UITableView *infoTableView;
    
    IBOutlet NSLayoutConstraint *infoTableViewToTop;
    IBOutlet NSLayoutConstraint *infoTableViewToBottom;
}
@end
