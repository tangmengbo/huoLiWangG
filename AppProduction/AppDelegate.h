//
//  AppDelegate.h
//  AppProduction
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate,UIWebViewDelegate>
{
    int count;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)SJTabBarController * rootBar;

@property(nonatomic,strong)CloudClient * cloudClient;


- (void)setTabBarHidden;
-(void)setTabBarShow;
-(void)selectTabBarAtIndex:(int)index;

-(void)resetWangGeZhangTabBar;
-(void)resetWanGeYuanTabBar;
-(void)resetJianZhiAndMinZhongTabBar;
-(void)resetZongZhiTabBar;
-(void)resetNotLoginTabBar;



@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)UIView * sliderScrollBottomView;
@property(nonatomic,strong)UIScrollView * sliderScrollView;
@property(nonatomic,strong)UIButton * allButton ;

@property(nonatomic,assign)BOOL allowRotation;//是否允许转向

@end

