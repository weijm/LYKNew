//
//  PositionInfoViewController.h
//  职位详情
//
//  Created by wjm on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UITextView *proTextView;
    IBOutlet UIView *promptBg;
    
    
    IBOutlet NSLayoutConstraint *tableViewToTop;
    
}
@property (nonatomic) BOOL reviewTips;
@end
