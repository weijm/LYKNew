//
//  CommendResumeForJobTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellHeaderView.h"
#import "CellMiddleView.h"
@class UIButton_Custom;

@protocol CommendResumeForJobTableViewCellDelegate <NSObject>

//点击选中按钮
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected;

@end

@interface CommendResumeForJobTableViewCell : UITableViewCell
{
    __weak IBOutlet UIView *subView;
    
    CellHeaderView *headerView;
    CellMiddleView *middleView;
    
    __weak IBOutlet NSLayoutConstraint *bgToRight;
    __weak IBOutlet NSLayoutConstraint *bgToLeft;
    
    __weak IBOutlet NSLayoutConstraint *chooseBgToLeft;
    
    __weak IBOutlet UIView *chooseBg;
    
    __weak IBOutlet UIButton_Custom *chooseBt;
}
@property (nonatomic,weak) id<CommendResumeForJobTableViewCellDelegate> delegate;
@property (nonatomic) BOOL isShowRateView;
@property (nonatomic) int isShowTopBg;
/**
 加载数据
 */
-(void)loadSearchResumeData:(NSDictionary*)dictionary;
/**
 选中按钮的点击事件
 */
- (IBAction)chooseAction:(id)sender;
/**
 全选时 出现选择按钮
 */
-(void)changeLocation:(BOOL)show Selected:(int)isSelected;
@end
