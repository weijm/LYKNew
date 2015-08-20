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
@property (nonatomic,strong) NSString *sex ;//用户性别
@property (nonatomic) int resumeID;//简历的ID
@property (nonatomic) BOOL fromCollected;//是否是收藏的简历

@property (nonatomic,strong) NSString *jobID;//职位ID
- (IBAction)makeCall:(id)sender;

- (IBAction)collectedAction:(id)sender;

@end
