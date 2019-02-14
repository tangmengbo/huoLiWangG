//
//  HomeWebViewController.h
//  SeeYou
//
//  Created by 周璟琳 on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface HomeWebViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView * webView;
//@property(nonatomic,strong)WKWebView * webView;

@property(nonatomic,strong)NSString * titleStr;

@property(nonatomic,strong)NSString * url;

@end
