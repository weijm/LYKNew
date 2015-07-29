//
//  VersionViewController.m
//  版本说明
//
//  Created by wjm on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "VersionViewController.h"

@interface VersionViewController ()

@end

@implementation VersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"版本说明";
    
    if (kIphone6plus) {
        versionimgHeiht.constant = versionimgHeiht.constant*1.5;
        versonimgWidth.constant = versonimgWidth.constant*1.5;
        versionimgY.constant = -200;
    }
    
    self.view.backgroundColor = Rgb(230, 244, 253, 1.0);
    [self initItems];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 编辑按钮
-(void)initItems
{
    CGRect frame = CGRectMake(0, 0, 50, 30);
    
    UIButton *leftBt = [[UIButton alloc] initWithFrame:frame];
    [leftBt setImage:[UIImage imageNamed:@"back_bt"] forState:UIControlStateNormal];
    UIEdgeInsets imageInsets = leftBt.imageEdgeInsets;
    leftBt.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left-30, imageInsets.bottom, imageInsets.right+20);
    [leftBt addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}
-(void)leftAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
