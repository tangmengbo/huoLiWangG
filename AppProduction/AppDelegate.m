//
//  AppDelegate.m
//  AppProduction
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UICKeyChainStore.h"
#import "NetworkManager.h"



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //初始化高德地图
     [AMapServices sharedServices].apiKey = GaoDeKey;
    //讯飞初始化
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",XunFeiAPPID];
    [IFlySpeechUtility createUtility:initString];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    
    if ([userInfo isKindOfClass:[NSDictionary class]]) {
        
        NSNumber * typeNumber = [userInfo objectForKey:@"logintype"];
        if (typeNumber.intValue==1)//网格长

        {
            [self resetWangGeZhangTabBar];
            
        }
        else if (typeNumber.intValue==2)//网格员
        {
            [self resetWanGeYuanTabBar];
            
        }
        else if (typeNumber.intValue==3||typeNumber.intValue==6)//兼职网格员和民众
        {
            [self resetJianZhiAndMinZhongTabBar];
        }
        else if (typeNumber.intValue==4)//综治
        {
            [self resetZongZhiTabBar];
        }
        
        
      
    }
    else
    {
        [self resetNotLoginTabBar];
    }
    
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

-(void)setTabBarHidden
{
    self.rootBar.bottomView.hidden = YES;
}
-(void)setTabBarShow
{
    self.rootBar.bottomView.hidden = NO;
}
-(void)selectTabBarAtIndex:(int)index
{
    [self.rootBar setItemSelected:index];
}
-(void)resetWangGeZhangTabBar
{
    
    WorkPlatformHomeViewController * homeVC = [[WorkPlatformHomeViewController alloc] init];
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:homeVC];


    GongZuoTaiZhangViewController * spxVC = [[GongZuoTaiZhangViewController alloc] init];
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:spxVC];

    BaoLiaoHomeViewController * centerVC = [[BaoLiaoHomeViewController alloc] init];
    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:centerVC];

    OwnerHomeViewController * chaterVC = [[OwnerHomeViewController alloc] init];
    UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:chaterVC];


    NSArray * array = [[NSArray alloc] initWithObjects:nav1,nav2,nav3,nav4, nil];
    self.rootBar = [[SJTabBarController alloc] init];
    [self.rootBar initTabBar:1];

    self.rootBar.viewControllers = array;
    self.window.rootViewController = self.rootBar;
    
}
-(void)resetWanGeYuanTabBar
{
    WangGeYuanHomeViewController * homeVC = [[WangGeYuanHomeViewController alloc] init];
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    
    GongZuoTaiZhangViewController * spxVC = [[GongZuoTaiZhangViewController alloc] init];
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:spxVC];
    
    
    OwnerHomeViewController * chaterVC = [[OwnerHomeViewController alloc] init];
    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:chaterVC];
    
    
    NSArray * array = [[NSArray alloc] initWithObjects:nav1,nav2,nav3, nil];
    self.rootBar = [[SJTabBarController alloc] init];
    [self.rootBar initTabBar:2];
    
    self.rootBar.viewControllers = array;
    self.window.rootViewController = self.rootBar;
}
-(void)resetJianZhiAndMinZhongTabBar
{
    JianZhiAndMinZhongViewController   * loginVC = [[JianZhiAndMinZhongViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
}
-(void)resetZongZhiTabBar
{
    ZongZhiViewController   * loginVC = [[ZongZhiViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
}
-(void)resetNotLoginTabBar
{
    LoginViewController   * loginVC = [[LoginViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
}
-(void)setIntroduceTabbar
{
    
}



@end
