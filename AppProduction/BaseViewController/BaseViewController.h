//
//  BaseViewController.h
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/9/14.
//  Copyright (c) 2015年 唐蒙波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJTabBarController.h"
#import "Header.h"
#import <AVFoundation/AVFoundation.h>

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>
{
}
@property (nonatomic, strong)CloudClient * baseCloudClient;
@property (nonatomic, strong)UIView * navView;
@property (nonatomic,strong)UIView  * statusBarView;
@property (nonatomic,strong)UIButton * leftButton;
@property (nonatomic,strong)UIImageView * backImageView;
@property (nonatomic,strong)UILabel * titleLale;
@property (nonatomic,strong)SJTabBarController * rootBar;

@property (nonatomic,strong)UILabel * tipLable;
@property (nonatomic,strong)UIView * loadingView;

@property (nonatomic,strong)UIView * loadingBottomView;

@property(nonatomic,strong)NSString * loadingViewAlsoFullScreen;


-(void)showNewLoadingView:(NSString *)message view:(UIView *)view;
-(void)showLoginLoadingView:(NSString *)message view:(UIView *)view;
-(void)hideNewLoadingView;

-(void)setTabBarHidden;
-(void)setTabBarShow;
-(void)setSelectItem:(int)index;

@property(nonatomic,strong)UIImageView * gifLoadingImageView;
-(void)showLoadingGifView;
-(void)hideLoadingGifView;



@end
