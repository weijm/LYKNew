//
//  CertificateView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificateView : UIView
{
    __weak IBOutlet UILabel *titleLab;
    __weak IBOutlet UIView *bottomBg;
    
    __weak IBOutlet UIImageView *cerImg;
    
    NSString *pictureUrl;
    
    __weak IBOutlet NSLayoutConstraint *cerImgWidth;
    
    __weak IBOutlet NSLayoutConstraint *cerImgHeight;
    
    UIImageView *cerImgView;
}
-(void)loadData:(NSDictionary*)dictionary;

-(void)loadSubView:(NSDictionary*)dictionary;
@end
