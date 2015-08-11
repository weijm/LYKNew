//
//  ResumeInfoViewController.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIButton_Custom;
@interface ResumeInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *infoTableView;
    __weak IBOutlet NSLayoutConstraint *lineWidth;

    __weak IBOutlet UIButton_Custom *colletedBt;
    
    __weak IBOutlet UIButton *callBt;
}
@property (nonatomic) int userID;//简历对应的用户id
@property (nonatomic) int resumeID;//简历的ID
@property (nonatomic) BOOL fromCollected;//是否是收藏的简历
- (IBAction)makeCall:(id)sender;

- (IBAction)collectedAction:(id)sender;

@end
