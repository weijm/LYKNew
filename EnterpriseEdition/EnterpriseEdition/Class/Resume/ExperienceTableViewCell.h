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

    __weak IBOutlet TitleView *titleView;
    
    
    __weak IBOutlet UITextField *emptyView;

    
    __weak IBOutlet UIView *infobg;

}
-(void)loadExperience:(NSArray*)array;
@end
