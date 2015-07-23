//
//  PositionShowTableViewCell.h
//  职位展示的cell
//
//  Created by wjm on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIButton_Custom;

@protocol PositionShowTableViewCellDelegate <NSObject>

//点击选中按钮
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected;

@end
@interface PositionShowTableViewCell : UITableViewCell
{
    IBOutlet UIButton_Custom *chooseBt;
    
    IBOutlet UIView *chooseBg;
    
    IBOutlet UIView *subView;
    
    IBOutlet NSLayoutConstraint *bgToRight;
    IBOutlet NSLayoutConstraint *bgToLeft;
    
    IBOutlet NSLayoutConstraint *chooseBgToLeft;
    
}
@property(nonatomic,weak) id<PositionShowTableViewCellDelegate> delegate;
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
