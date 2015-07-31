//
//  ClaimPositionTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/28.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIButton_Custom;
@protocol ClaimPositionTableViewCellDelegate <NSObject>

//点击选中按钮
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected;

@end
@interface ClaimPositionTableViewCell : UITableViewCell
{
    IBOutlet UIButton_Custom *chooseBt;
    
    IBOutlet NSLayoutConstraint *lineHeight;
}
@property(nonatomic,weak) id<ClaimPositionTableViewCellDelegate> delegate;

/**
 全选时 出现选择按钮
 */
-(void)changeLocation:(BOOL)show Selected:(int)isSelected;
/**
 选中按钮的点击事件
 */
- (IBAction)chooseAction:(id)sender;
@end
