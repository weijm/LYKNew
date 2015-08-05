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
    IBOutlet UITableView *infoTableView;
    IBOutlet NSLayoutConstraint *lineWidth;

    IBOutlet UIButton_Custom *colletedBt;
    
    IBOutlet UIButton *callBt;
}

- (IBAction)makeCall:(id)sender;

- (IBAction)collectedAction:(id)sender;

@end
