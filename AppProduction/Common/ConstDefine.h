//
//  ConstDefine.h
//  AppProduction
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#ifndef ConstDefine_h
#define ConstDefine_h



//是否是正式环境0:测试，1:正式
#define IS_FORMAL_ENVIRONMENT 0
	
#if IS_FORMAL_ENVIRONMENT
#pragma mark 接口 生产
#define HTTP_REQUESTURL    @"https://api.cyoulive.net/api/calling"


#else
#pragma mark 接口 测试
#define HTTP_REQUESTURL @"http://117.34.72.95:8282/hlwgxt/"//@"http://api-sy-stage.51findme.com/api/calling"
#endif


#define GaoDeKey @"8bc6dd12c3f58b992f4c1ae06cf6103d"

//当前设置的宽、高
#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SafeAreaTopHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 35 : 20)
#define SafeAreaBottomHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 64 : 49)

#define BILI [UIScreen mainScreen].bounds.size.width/375
#define BILIY ([UIScreen mainScreen].bounds.size.height-SafeAreaTopHeight-SafeAreaBottomHeight)/(667-SafeAreaTopHeight-SafeAreaBottomHeight)


#define USERCC 640/750/2


//设置颜色值
#define UIColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(1.0)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//获取当前图片
#define UIIMAGE(x) [UIImage imageNamed:x]

#define APPKEY @"123"

#define USERINFO @"USERINFO"

#define APP_STORE_ID @"1239646034"



#define XunFeiAPPID @"5b446050"


#endif /* ConstDefine_h */
