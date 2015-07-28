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
@interface EnterpriseContactViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EnterpriseBaseTableViewCellDelegate,EnterpriseImgTableViewCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UILabel *promptLab;
    
    
    IBOutlet UITableView *infoTableView;
}
- (IBAction)saveAndCommit:(id)sender;

@end
