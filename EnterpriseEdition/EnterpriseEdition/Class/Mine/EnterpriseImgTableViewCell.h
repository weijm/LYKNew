//
//  EnterpriseImgTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EnterpriseImgTableViewCellDelegate <NSObject>
@optional
-(void)addPicture:(int)index;

@end
@interface EnterpriseImgTableViewCell : UITableViewCell
{
    __weak IBOutlet UILabel *titleLab;
    __weak IBOutlet UIImageView *requiredMarkImg;
    
    __weak IBOutlet NSLayoutConstraint *xingHeight;
    __weak IBOutlet NSLayoutConstraint *xingWidth;
    //添加按钮的宽高
    
    __weak IBOutlet NSLayoutConstraint *addImgHeight;
    __weak IBOutlet NSLayoutConstraint *addImgWidth;
    
    __weak IBOutlet NSLayoutConstraint *lineHeight;
    
    __weak IBOutlet UIImageView *imgView;
    
    __weak IBOutlet UIView *promptView;
}
@property(nonatomic,weak) id<EnterpriseImgTableViewCellDelegate> delegate;
/**
 初始化cell的标题
 */
-(void)initData:(NSDictionary*)dictionary;
/**
 加载图片
 */
-(void)loadImg:(NSObject*)obj;
/**
 添加图片事件
 */
- (IBAction)addPictureAction:(id)sender;

@end
