//
//  CertificateTableViewCell.h
//  荣誉证书cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleView;
@interface CertificateTableViewCell : UITableViewCell
{

    __weak IBOutlet TitleView *titleView;
    
    __weak IBOutlet UITextField *emptyView;

    __weak IBOutlet UIView *infobg;

}
-(void)loadCertificate:(NSObject*)obj;
@end
