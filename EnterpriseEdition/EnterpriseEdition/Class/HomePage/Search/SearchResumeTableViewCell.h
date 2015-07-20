//
//  SearchResumeTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/20.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellHeaderView.h"
#import "CellMiddleView.h"
@class UIButton_Custom;

@protocol SearchResumeTableViewCellDelegate <NSObject>

//点击选中按钮
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected;

@end
@interface SearchResumeTableViewCell : UITableViewCell
{
    
    IBOutlet UIView *subView;
    
    CellHeaderView *headerView;
    CellMiddleView *middleView;
    
    IBOutlet NSLayoutConstraint *bgToRight;
    IBOutlet NSLayoutConstraint *bgToLeft;
    
    IBOutlet NSLayoutConstraint *chooseBgToLeft;
    
    IBOutlet UIView *chooseBg;
    
    IBOutlet UIButton_Custom *chooseBt;
}
@property (nonatomic,weak) id<SearchResumeTableViewCellDelegate> delegate;
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
