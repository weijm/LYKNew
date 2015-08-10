//
//  EducationView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/8/10.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EducationView : UIView
{
    __weak IBOutlet UILabel *timeLab;
    
    __weak IBOutlet UILabel *schoolLab;
    
    __weak IBOutlet UILabel *proLab;
}
-(void)loadData:(NSDictionary*)dictionary;
@end
