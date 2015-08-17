//
//  WebSourceViewController.m
//  EnterpriseEdition
//
//  Created by lyk on 15/8/15.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "WebSourceViewController.h"

@interface WebSourceViewController ()<UIWebViewDelegate>
{
    UIWebView *htmlWebView;
}
@end

@implementation WebSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"详情";
    self.view.backgroundColor = kCVBackgroundColor;
    //导航条的颜色
    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:kNavigationBgColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self initWebView];

    [self performSelector:@selector(loadSubView) withObject:nil afterDelay:0.0];
    
    

}
-(void)initWebView
{
    htmlWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, self.view.frame.size.height)];
    htmlWebView.delegate = self;
    htmlWebView.backgroundColor = [UIColor clearColor];
    htmlWebView.opaque = NO;
    for (UIView *subView in [htmlWebView subviews]) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView *shadowView in [subView subviews]) {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    shadowView.hidden = YES;
                }
            }
        }
    }
    NSURL *url = [NSURL URLWithString:_sourceString];
    
    [htmlWebView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:htmlWebView];

}
-(void)loadSubView
{
    [self showHUD:@"加载数据中"];
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
#pragma mark - webView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [htmlWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self hideHUD];
   }

@end
