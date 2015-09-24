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
@class UIButton_Custom;
@protocol ResumeTableViewCellDelegate <NSObject>

@optional
//取消左右滑动出现的功能
-(void)revertLeftOrRightSwipView:(ResumeTableViewCell*)cell selected:(BOOL)isSelected;
//点击选中按钮
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected;
@end
@interface ResumeTableViewCell : UITableViewCell
{
   //全选按钮背景
    
    __weak IBOutlet UIView *chooseBg;
//    //删除按钮背景
//    __weak IBOutlet UIView *deleteBg;
//    //收藏按钮背景
//    __weak IBOutlet UIView *collectdBg;
    
    //cell上的内容背景
   
    __weak IBOutlet UIView *bg;
    
    CellHeaderView *headerView;
    CellMiddleView *middleView;
    //bg的相对左右距离
    
    __weak IBOutlet NSLayoutConstraint *bgToLeft;
    
    
    __weak IBOutlet NSLayoutConstraint *bgToRight;
    
    __weak IBOutlet NSLayoutConstraint *bgToTop;
    
    
    __weak IBOutlet NSLayoutConstraint *bgToBottom;
  
    //chooseBg相对左边的距离
    
    __weak IBOutlet NSLayoutConstraint *chooseToLeft;
    
    
   
    __weak IBOutlet UIButton_Custom *chooseBt;
    
}
@property (nonatomic,assign) id<ResumeTableViewCellDelegate> delegate;
@property (nonatomic) int isShowTopBg;
/**
 加载视图上的内容
 */
-(void)loadSubView:(NSDictionary*)dictionary;
/**
 还原左右滑动视图
 */
//-(void)revertView;
/**
 全选时 出现选择按钮
 */
-(void)changeLocation:(BOOL)show Selected:(int)isSelected;
/**
 选择按钮的触发事件
 */
- (IBAction)chooseAction:(id)sender;

@end
