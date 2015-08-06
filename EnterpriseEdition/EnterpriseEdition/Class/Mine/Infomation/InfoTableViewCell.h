//
//  InfoTableViewCell.h
//  消息的Cell
//
//  Created by wjm on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIButton_Custom;
@protocol InfoTableViewCellDelegate <NSObject>

//点击选中按钮
-(void)clickedChooseBtAction:(int)index Selected:(NSString*)isSelected;

@end
@interface InfoTableViewCell : UITableViewCell
{
    __weak IBOutlet UIView *subView;
    __weak IBOutlet NSLayoutConstraint *bgToRight;
    __weak IBOutlet NSLayoutConstraint *bgToLeft;
    
    __weak IBOutlet NSLayoutConstraint *chooseBgToLeft;
    
    __weak IBOutlet UIView *chooseBg;
    
    __weak IBOutlet UIButton_Custom *chooseBt;
    //图标
    __weak IBOutlet UIImageView *iconImg;
    //标题
    __weak IBOutlet UILabel *titleLab;
    //信息
    __weak IBOutlet UILabel *infoLab;
    //时间
    
    __weak IBOutlet UILabel *timeLab;
    
    __weak IBOutlet NSLayoutConstraint *iconWidth;
    
    __weak IBOutlet NSLayoutConstraint *iconHeight;
    
    __weak IBOutlet NSLayoutConstraint *blineHeight;
}
@property (nonatomic,weak) id<InfoTableViewCellDelegate> delegate;
/**
 加载数据
 */
-(void)loadInfoData:(NSDictionary*)dictionary;
/**
 选中按钮的点击事件
 */
- (IBAction)chooseAction:(id)sender;
/**
 全选时 出现选择按钮
 */
-(void)changeLocation:(BOOL)show Selected:(int)isSelected;
@end
