//
//  WorkPlatformHomeViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface WorkPlatformHomeViewController : BaseViewController<AMapLocationManagerDelegate>

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIView * zouFangBottomView;
@property(nonatomic,strong)UIImageView * zouFangImageView;

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) CLLocation * location;
@property (nonatomic, strong) CLLocation * location2;

@property (nonatomic,strong)NSString * detailAddress;

@property (nonatomic,strong)NSTimer * timer;


@end
