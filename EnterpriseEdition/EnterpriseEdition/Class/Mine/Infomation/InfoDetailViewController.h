//
//  InfoDetailViewController.h
//  信息详情
//
//  Created by wjm on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property(nonatomic,strong) NSDictionary *infoDictionary;
@end
