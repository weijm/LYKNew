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
    __weak IBOutlet UIView *littleInfoBg;
    //展开的信息背景
    __weak IBOutlet UIView *infoBg;
    //联系电话label
    
    __weak IBOutlet UILabel *phoneLab;
    //邮箱
    
    __weak IBOutlet UILabel *mailLab;
    //联系地址
    
    __weak IBOutlet UILabel *addressLab;
    
    __weak IBOutlet NSLayoutConstraint *addressToTop;
    //什么信息都为空的时候显示
    __weak IBOutlet UITextField *emptyView;
}
@property(nonatomic,copy) void(^lookIdentityInfo)(void);
- (IBAction)lookUpInfo:(id)sender;

-(void)showInfo:(BOOL)isShow;
@end
