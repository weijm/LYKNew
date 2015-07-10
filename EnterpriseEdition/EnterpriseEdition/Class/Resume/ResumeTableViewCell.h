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
@class ResumeTableViewCell;

@protocol ResumeTableViewCellDelegate <NSObject>

@optional
-(void)revertLeftOrRightSwipView:(ResumeTableViewCell*)cell selected:(BOOL)isSelected;

@end
@interface ResumeTableViewCell : UITableViewCell
{
    IBOutlet UIView *deleteBg;
    IBOutlet UIView *collectdBg;
    IBOutlet UIView *bg;
    
    CellHeaderView *headerView;
    CellMiddleView *middleView;
}
@property (nonatomic,assign) id<ResumeTableViewCellDelegate> delegate;
-(void)loadSubView:(NSDictionary*)dictionary;
-(void)revertView;
@end
