//
//  CommendResumeTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommendResumeTableViewCell : UITableViewCell
{
    
    IBOutlet UIImageView *urgentImg;
    
    IBOutlet UILabel *positionTitle;
    
    IBOutlet UILabel *positionInfo;
}
/**
 加载数据
 */
-(void)loadSubViewData:(NSDictionary*)dictionary;
@end
