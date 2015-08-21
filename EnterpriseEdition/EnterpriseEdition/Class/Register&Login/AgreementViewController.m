//
//  AgreementViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"E朝朝企业版条款";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"qiyexieyi" ofType:@"html"];
      NSString*htmlstring=[[NSString alloc] initWithContentsOfFile:filepath  encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlstring baseURL:nil];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
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
