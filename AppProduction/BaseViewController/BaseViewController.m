//
//  BaseViewController.m
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/9/14.
//  Copyright (c) 2015年 唐蒙波. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+GIF.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.baseCloudClient = [CloudClient getInstance];
    
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.rootBar = delegate.rootBar;
    
    self.statusBarView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 20)];
    self.statusBarView.backgroundColor = UIColorFromRGB(0x5077AA);
    [self.view addSubview:self.statusBarView];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, VIEW_WIDTH, 44*BILIY)];
    self.navView.backgroundColor = UIColorFromRGB(0x5077AA);
    [self.view addSubview:self.navView];
    
    
    self.titleLale = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44*BILIY)];
    self.titleLale.textColor = [UIColor blackColor];
    self.titleLale.textAlignment = NSTextAlignmentCenter;
    self.titleLale.font = [UIFont fontWithName:@"Helvetica-Bold" size:16*BILI];
    [self.navView addSubview:self.titleLale];
    
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  0, 60, 44*BILIY)];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.navView addSubview:self.leftButton];
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (44*BILIY-18*BILI)/2, 18*18/30*BILI, 18*BILI)];
    self.backImageView.image = [UIImage imageNamed:@"white_back"];
    [self.leftButton addSubview:self.backImageView];
    
    
    self.loadingBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-60)];
    self.loadingBottomView.backgroundColor = [UIColor blackColor];
    self.loadingBottomView.alpha = 0.5;
    
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2, (VIEW_HEIGHT-60-80)/2, 200, 70)];
    self.loadingView.backgroundColor = [UIColor blackColor];
    self.loadingView.layer.cornerRadius = 10;
    self.loadingView.alpha = 0.8;
    
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityView startAnimating];
    activityView.frame = CGRectMake(20, 25, 20, 20);
    [self.loadingView addSubview:activityView];
    
    self.tipLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 300, 70)];
     self.tipLable.text = @"正在加载...";
     self.tipLable.textColor = [UIColor whiteColor];
     self.tipLable.font = [UIFont systemFontOfSize:15];
    [self.loadingView addSubview: self.tipLable];
    
    self.gifLoadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-50*BILI)/2, (VIEW_HEIGHT-50*BILI)/2, 50*BILI, 50*BILI)];
    self.gifLoadingImageView.image = [UIImage imageNamed:@"loadingData"];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
//    if ([@"shenHeZhong" isEqualToString:[Common getShenHeStatusStr]]) {
//
//        return UIStatusBarStyleLightContent;
//
//    }
//    else
//    {
//        return UIStatusBarStyleDefault;
//
//    }
    
    return UIStatusBarStyleLightContent;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
  

}
-(void)viewWillDisappear:(BOOL)animated
{

    
    
}

-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightClick
{
    
}

-(void)showLoadingView:(NSString *)message view:(UIView *)view
{
   
    [self.view addSubview:self.loadingView];
    self.loadingView.hidden = NO;
    
}
-(void)hideLoadingView
{
    self.loadingView.hidden = YES;
}
-(void)showNewLoadingView:(NSString *)message view:(UIView *)view
{
    if ([message isKindOfClass:[NSString class]]) {
        
        self.tipLable.text = message;
    }
    else
    {
        self.tipLable.text = @"正在加载...";
    }
    self.loadingBottomView.frame = CGRectMake(0, self.loadingBottomView.frame.origin.y, VIEW_WIDTH, VIEW_HEIGHT-self.loadingBottomView.frame.origin.y);
    
    if ([@"yes" isEqualToString:self.loadingViewAlsoFullScreen]) {
        
        self.loadingBottomView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    }
    [self.view addSubview:self.loadingBottomView];
    [self.view addSubview:self.loadingView];
}
-(void)showLoginLoadingView:(NSString *)message view:(UIView *)view
{
    if ([message isKindOfClass:[NSString class]]) {
        
        self.tipLable.text = message;
    }
    else
    {
        self.tipLable.text = @"正在加载...";
    }
    self.loadingBottomView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.view addSubview:self.loadingBottomView];
    [self.view addSubview:self.loadingView];
}
-(void)showLoadingGifView
{
    
    self.loadingBottomView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.view addSubview:self.loadingBottomView];
    [self.view addSubview:self.gifLoadingImageView];
    
    CABasicAnimation* rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    
    rotationAnimation.duration = 9;
    
    rotationAnimation.cumulative = NO;
    
    //一直重复
    rotationAnimation.repeatCount = ULLONG_MAX;
    
    [self.gifLoadingImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

}
-(void)hideNewLoadingView
{
    [self.loadingView removeFromSuperview];
    [self.loadingBottomView removeFromSuperview];
    [self.gifLoadingImageView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)setTabBarHidden
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setTabBarHidden];
}
-(void)setTabBarShow
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setTabBarShow];
}
-(void)setSelectItem:(int)index
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate selectTabBarAtIndex:index];
}




@end
