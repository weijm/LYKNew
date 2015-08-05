//
//  ResumeInfoViewController.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIButton_Custom;
@interface ResumeInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *infoTableView;
    __weak IBOutlet NSLayoutConstraint *lineWidth;

    __weak IBOutlet UIButton_Custom *colletedBt;
    
    __weak IBOutlet UIButton *callBt;
}

- (IBAction)makeCall:(id)sender;

- (IBAction)collectedAction:(id)sender;

@end
