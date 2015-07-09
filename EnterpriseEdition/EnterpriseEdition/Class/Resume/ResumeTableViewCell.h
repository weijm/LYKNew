//
//  ResumeTableViewCell.h
//  简历自定义cell
//
//  Created by wjm on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResumeTableViewCell : UITableViewCell
{
    IBOutlet UIView *bg;
    
}
-(void)loadSubView:(NSArray*)array;
@end
