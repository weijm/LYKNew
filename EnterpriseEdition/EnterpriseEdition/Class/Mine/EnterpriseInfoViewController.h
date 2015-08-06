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

@interface EnterpriseInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,EnterpriseBaseTableViewCellDelegate,EnterpriseImgTableViewCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    __weak IBOutlet UILabel *promptLab;
    
    __weak IBOutlet UITableView *infoTableView;
    
    __weak IBOutlet NSLayoutConstraint *infoTableViewToTop;
    __weak IBOutlet NSLayoutConstraint *infoTableViewToBottom;
    
    __weak IBOutlet NSLayoutConstraint *proWidth;
    __weak IBOutlet NSLayoutConstraint *proHeight;
}
- (IBAction)saveEnterpriseInfo:(id)sender;

@end
