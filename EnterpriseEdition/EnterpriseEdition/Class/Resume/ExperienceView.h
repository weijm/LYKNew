//
//  ExperienceView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExperienceView : UIView
{
    //工作时间
    __weak IBOutlet UILabel *timeLab;
    //公司名称
    __weak IBOutlet UILabel *orgLab;
    //职位 行业
    
    __weak IBOutlet UILabel *positionLab;
    //工作内容
    
    __weak IBOutlet UILabel *contentLab;
   }
-(void)loadData:(NSDictionary*)dictioanry;
@end
