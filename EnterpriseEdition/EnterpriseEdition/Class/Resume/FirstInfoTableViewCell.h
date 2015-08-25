//
//  FirstInfoTableViewCell.h
//  EnterpriseEdition
//
//  Created by lyk on 15/8/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstInfoTableViewCell : UITableViewCell
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
    
    __weak IBOutlet UILabel *politicalLab;
    
    //什么信息都为空的时候显示
    __weak IBOutlet UITextField *emptyView;
    __weak IBOutlet UILabel *showDownloadCountLab;
    
    NSDictionary *infoDic;
}
@property(nonatomic,copy) void(^lookIdentityInfo)(void);
@property (nonatomic,strong) NSString *retaimCount;
- (IBAction)lookUpInfo:(id)sender;

-(void)showInfo:(BOOL)isShow;

-(void)loadData:(NSDictionary*)dic;

-(void)loadRetaimCount:(NSString*)downloadCount;
@end
