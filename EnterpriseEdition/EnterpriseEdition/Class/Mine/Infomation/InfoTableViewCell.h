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
    IBOutlet UIView *subView;
    IBOutlet NSLayoutConstraint *bgToRight;
    IBOutlet NSLayoutConstraint *bgToLeft;
    
    IBOutlet NSLayoutConstraint *chooseBgToLeft;
    
    IBOutlet UIView *chooseBg;
    
    IBOutlet UIButton_Custom *chooseBt;
    
    //图标
    IBOutlet UIImageView *iconImg;
    //标题
    IBOutlet UILabel *titleLab;
    
    //信息
    
    IBOutlet UILabel *infoLab;
    //时间
    
    IBOutlet UILabel *timeLab;
    
    IBOutlet NSLayoutConstraint *iconWidth;
    
    IBOutlet NSLayoutConstraint *iconHeight;
    
    IBOutlet NSLayoutConstraint *blineWidth;
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
