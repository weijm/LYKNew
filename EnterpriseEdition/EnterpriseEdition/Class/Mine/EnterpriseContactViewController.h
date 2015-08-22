//
//  EnterpriseContactViewController.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnterpriseBaseTableViewCell.h"
#import "EnterpriseImgTableViewCell.h"
@interface EnterpriseContactViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,EnterpriseBaseTableViewCellDelegate,EnterpriseImgTableViewCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    __weak IBOutlet UILabel *promptLab;

    
    
    __weak IBOutlet UITableView *infoTableView;

}
@property (nonatomic) int isFromRegister;
- (IBAction)saveAndCommit:(id)sender;

@end
