//
//  MyCodeViewController.h
//  EnterpriseEdition
//
//  Created by lyk on 15/9/17.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCodeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSDictionary *infoDic;
@end
