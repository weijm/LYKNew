//
//  IdentityTableViewCell.h
//  身份信息Cell
//
//  Created by wjm on 15/7/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdentityTableViewCell : UITableViewCell
{
    //收起来的背景
    IBOutlet UIView *littleInfoBg;
    //展开的信息背景
    IBOutlet UIView *infoBg;
    //联系电话label
    
    IBOutlet UILabel *phoneLab;
    //邮箱
    
    IBOutlet UILabel *mailLab;
    //联系地址
    
    IBOutlet UILabel *addressLab;
    
    IBOutlet NSLayoutConstraint *addressToTop;
    //什么信息都为空的时候显示
    IBOutlet UITextField *emptyView;
    
}
@property(nonatomic,copy) void(^lookIdentityInfo)(void);
- (IBAction)lookUpInfo:(id)sender;

-(void)showInfo:(BOOL)isShow;
@end
