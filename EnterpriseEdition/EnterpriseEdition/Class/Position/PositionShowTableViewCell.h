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
    __weak IBOutlet UIButton_Custom *chooseBt;
    
    __weak IBOutlet UIView *chooseBg;
    
    __weak IBOutlet UIView *subView;
    
    __weak IBOutlet NSLayoutConstraint *bgToRight;
    __weak IBOutlet NSLayoutConstraint *bgToLeft;
    
    
    __weak IBOutlet NSLayoutConstraint *chooseBgToLeft;
    
    __weak IBOutlet NSLayoutConstraint *positionImgWidth;
    
    __weak IBOutlet NSLayoutConstraint *positionImgHeight;
    //急标志
    
    __weak IBOutlet UIImageView *urgentImg;
    //有效期lab
    __weak IBOutlet UILabel *validTimeLab;
    //职位相关信息
    
    __weak IBOutlet UILabel *positionInfo;
    //职位名称
    
    __weak IBOutlet UILabel *positoinName;
    //职位标题
    __weak IBOutlet UILabel *positionTitle;
    //信息距离上面的距离和距离下面的距离
    __weak IBOutlet NSLayoutConstraint *bgToTop;
    __weak IBOutlet NSLayoutConstraint *bgToBottom;
    //简历数量图标
    
    __weak IBOutlet UIImageView *resumeNumberImg;
    
    __weak IBOutlet UILabel *resumeNumberLab;
    //倒计时视图的父视图
    __weak IBOutlet UIView *rightBg;
    
    CircleProgressView *circleProgressView;
    
    NSTimeInterval remainingTime;
    
    
}
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) Session *session;
@property (nonatomic)  BOOL isShowTimeLab;
@property(nonatomic,weak) id<PositionShowTableViewCellDelegate> delegate;
@property (nonatomic) BOOL showCheckImg;
//@property (nonatomic,strong) NSDictionary *urgentDictionary;
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
