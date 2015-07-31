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
    IBOutlet UILabel *titleLab;
    IBOutlet UIImageView *requiredMarkImg;
    
    IBOutlet NSLayoutConstraint *xingHeight;
    IBOutlet NSLayoutConstraint *xingWidth;
    //添加按钮的宽高
    
    IBOutlet NSLayoutConstraint *addImgHeight;
    IBOutlet NSLayoutConstraint *addImgWidth;
    
    IBOutlet NSLayoutConstraint *lineHeight;
}
@property(nonatomic,weak) id<EnterpriseImgTableViewCellDelegate> delegate;
-(void)initData:(NSDictionary*)dictionary;
- (IBAction)addPictureAction:(id)sender;

@end
