//
//  ResumeTableViewCell.h
//  简历自定义cell
//
//  Created by wjm on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellHeaderView;
@class CellMiddleView;

@interface ResumeTableViewCell : UITableViewCell
{
    IBOutlet UIView *bg;
    
    CellHeaderView *headerView;
    CellMiddleView *middleView;
}
-(void)loadSubView:(NSDictionary*)dictionary;
@end
