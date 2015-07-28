//
//  ReferenceView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferenceView : UIView
{
    
    IBOutlet UIButton *expBt;
}
@property (nonatomic,copy) void(^lookExampleAction)(void);
/**
 查看样例
 */
- (IBAction)lookUpExample:(id)sender;

@end
