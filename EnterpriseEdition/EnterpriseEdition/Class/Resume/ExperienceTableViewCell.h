//
//  ExperienceTableViewCell.h
//  实习经验cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleView;
@interface ExperienceTableViewCell : UITableViewCell
{
    IBOutlet TitleView *titleView;
    
    
    IBOutlet UITextField *emptyView;
    
    IBOutlet UIView *infobg;
}
-(void)loadExperience:(NSArray*)array;
@end
