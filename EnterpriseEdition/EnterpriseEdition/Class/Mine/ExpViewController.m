//
//  ExpViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ExpViewController.h"

@interface ExpViewController ()

@end

@implementation ExpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"样例";
    UIImage *img = [UIImage imageNamed:@"exp@2x.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-img.size.width)/2, (kHeight-img.size.height)/2, img.size.width, img.size.height)];
    imgView.image = img;
    [self.view addSubview:imgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
