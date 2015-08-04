//
//  PositionShowTableViewCell.h
//  职位展示的cell
//
//  Created by wjm on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
#import "Session.h"
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
    
    IBOutlet NSLayoutConstraint *positionImgWidth;
    
    IBOutlet NSLayoutConstraint *positionImgHeight;
    
    //急标志
    
    IBOutlet UIImageView *urgentImg;
    //有效期lab
    IBOutlet UILabel *validTimeLab;
    //职位相关信息
    
    IBOutlet UILabel *positionInfo;
    //职位名称
    
    IBOutlet UILabel *positoinName;
    //职位标题
    IBOutlet UILabel *positionTitle;
    
    //信息距离上面的距离和距离下面的距离
    IBOutlet NSLayoutConstraint *bgToTop;
    IBOutlet NSLayoutConstraint *bgToBottom;
    //简历数量图标
    
    IBOutlet UIImageView *resumeNumberImg;
    
    IBOutlet UILabel *resumeNumberLab;
    //倒计时视图的父视图
    IBOutlet UIView *rightBg;
    
    CircleProgressView *circleProgressView;
    
    NSTimeInterval remainingTime;
}
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) Session *session;

@property(nonatomic,weak) id<PositionShowTableViewCellDelegate> delegate;
@property (nonatomic) BOOL showCheckImg;
/**
 加载数据
 */
-(void)loadPositionData:(NSDictionary*)dictionary;
/**
 选中按钮的点击事件
 */
- (IBAction)chooseAction:(id)sender;
/**
 全选时 出现选择按钮
 */
-(void)changeLocation:(BOOL)show Selected:(int)isSelected;
@end
