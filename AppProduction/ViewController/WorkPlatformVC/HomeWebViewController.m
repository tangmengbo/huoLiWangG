//
//  HomeWebViewController.m
//  SeeYou
//
//  Created by 周璟琳 on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeWebViewController.h"

@interface HomeWebViewController ()

@end

@implementation HomeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = self.titleStr;
    
    [self showNewLoadingView:nil view:self.view];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.webView.delegate = self;
    [self.webView setMediaPlaybackRequiresUserAction:NO];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]]];
    [self.view addSubview: self.webView];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:request];



}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)leftClick
{

    [self.navigationController popViewControllerAnimated:YES];
   
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    [self showLoadingGifView];
    
    return YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self hideNewLoadingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
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
