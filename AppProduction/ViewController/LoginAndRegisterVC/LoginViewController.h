//
//  LoginViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController<CLLocationManagerDelegate,AMapLocationManagerDelegate>
{
    
}

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UITextField * accountTextField;
@property(nonatomic,strong)UITextField * passWorldTextField;

@property(nonatomic, strong) CLLocationManager *myLocation;

@property(nonatomic,strong)NSString * detailAddress;


@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic,strong) CLLocation * location;



@end
