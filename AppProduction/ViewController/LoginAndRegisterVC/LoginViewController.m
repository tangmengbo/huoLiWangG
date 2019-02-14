//
//  LoginViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "EditPWViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.hidden = YES;
    
    self.loadingViewAlsoFullScreen = @"yes";
    
    self.cloudClient = [CloudClient getInstance];
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomImageView.image = [UIImage imageNamed:@"logo_in_image"];
    bottomImageView.userInteractionEnabled = YES;
    [self.view addSubview:bottomImageView];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.alpha = 0.4;
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomTap)];
    [bottomView addGestureRecognizer:tap];
    
    [self initLoactionManger];
    [self initLoginView];
}
-(void)initLoactionManger
{
    self.locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;    //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        self.location = location;
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            self.detailAddress = [NSString stringWithFormat:@"%@%@%@%@%@%@",regeocode.province,regeocode.city,regeocode.district,regeocode.street,regeocode.number,regeocode.POIName];
        }
    }];
//    self.locationManager = [[AMapLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    self.locationManager.distanceFilter = 1;
//    self.locationManager.locatingWithReGeocode = YES;
//    //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
//    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
//    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
//        self.locationManager.allowsBackgroundLocationUpdates = YES;
//    }
//    [self.locationManager setLocatingWithReGeocode:YES];
//    //开始持续定位
//    [self.locationManager startUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    self.location = location;
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
        self.detailAddress = [NSString stringWithFormat:@"%@%@%@%@%@%@",reGeocode.province,reGeocode.city,reGeocode.district,reGeocode.street,reGeocode.number,reGeocode.POIName];
        [self cleanUpAction];
    }
}

- (void)cleanUpAction
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:nil];
    
}
-(void)initLoginView
{
    
    UIImageView * logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-80*BILI)/2, 80*BILI, 80*BILI, 80*BILI)];
    logoImageView.image = [UIImage imageNamed:@"180logo"];
    [self.view addSubview:logoImageView];
    
//    UIImageView * accountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(133*BILI/2, 566*BILI/2, 17*BILI, 20*BILI)];
//    accountImageView.image = [UIImage imageNamed:@"icon_zhanghu"];
//    [self.view addSubview:accountImageView];
    
    UILabel * accountLable = [[UILabel alloc] initWithFrame:CGRectMake(133*BILI/2, 566*BILI/2, 40*BILI, 20*BILI)];
    accountLable.textColor = [UIColor whiteColor];
    accountLable.font = [UIFont systemFontOfSize:15*BILI];
    accountLable.text= @"账号:";
    [self.view addSubview:accountLable];
    
    self.accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(accountLable.frame.origin.x+accountLable.frame.size.width+12*BILI, accountLable.frame.origin.y, 244*BILI-(accountLable.frame.origin.x+accountLable.frame.size.width+12*BILI), 20*BILI)];
    self.accountTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.accountTextField.placeholder = @"请输入手机号";
    self.accountTextField.textColor = [UIColor whiteColor];
    self.accountTextField.tintColor = [UIColor whiteColor];
    [self.accountTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:self.accountTextField];
    
    UIView * telBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(130*BILI/2, 617*BILI/2, 244*BILI, 1*BILI)];
    telBottomLineView.layer.borderColor = [[UIColor whiteColor] CGColor];
    telBottomLineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:telBottomLineView];
    
    
    
//    UIImageView * pwImageView = [[UIImageView alloc] initWithFrame:CGRectMake(accountLable.frame.origin.x, telBottomLineView.frame.origin.y+telBottomLineView.frame.size.height+59*BILI/2, 17*BILI, 20*BILI)];
//    pwImageView.image = [UIImage imageNamed:@"icon_mima"];
//    [self.view addSubview:pwImageView];
    
    UILabel * pwLable = [[UILabel alloc] initWithFrame:CGRectMake(accountLable.frame.origin.x, telBottomLineView.frame.origin.y+telBottomLineView.frame.size.height+59*BILI/2, 40*BILI, 20*BILI)];
    pwLable.textColor = [UIColor whiteColor];
    pwLable.font = [UIFont systemFontOfSize:15*BILI];
    pwLable.text= @"密码:";
    [self.view addSubview:pwLable];
    
    
    self.passWorldTextField = [[UITextField alloc] initWithFrame:CGRectMake(pwLable.frame.origin.x+pwLable.frame.size.width+12*BILI, pwLable.frame.origin.y, 244*BILI-(pwLable.frame.origin.x+pwLable.frame.size.width+12*BILI), 20*BILI)];
    self.passWorldTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.passWorldTextField.placeholder = @"请输入密码";
    self.passWorldTextField.secureTextEntry = YES;
    self.passWorldTextField.textColor = [UIColor whiteColor];
    self.passWorldTextField.tintColor = [UIColor whiteColor];
    [self.passWorldTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:self.passWorldTextField];
    
    
    
    UIView * checkNumberBottomView = [[UIView alloc] initWithFrame:CGRectMake(telBottomLineView.frame.origin.x, telBottomLineView.frame.origin.y+telBottomLineView.frame.size.height+111*BILI/2, 244*BILI, 1*BILI)];
    checkNumberBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:checkNumberBottomView];
    
    
    UIButton * telLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(64*BILI, checkNumberBottomView.frame.origin.y+ checkNumberBottomView.frame.size.height+27*BILI, VIEW_WIDTH-128*BILI, 40*BILI)];
    telLoginButton.backgroundColor = UIColorFromRGB(0x5077AA);
    telLoginButton.layer.cornerRadius = 8*BILI;
    [telLoginButton setTitle:@"登录" forState:UIControlStateNormal];
    [telLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    telLoginButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [telLoginButton addTarget:self action:@selector(telLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:telLoginButton];
    
    
    UIButton * forgetPassWorldButton = [[UIButton alloc] initWithFrame:CGRectMake(64*BILI, telLoginButton.frame.origin.y+telLoginButton.frame.size.height+15*BILI, 100*BILI, 40*BILI)];
    [forgetPassWorldButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPassWorldButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [forgetPassWorldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetPassWorldButton addTarget:self action:@selector(forgetPassWorldButtonClick) forControlEvents:UIControlEventTouchUpInside];
    forgetPassWorldButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    forgetPassWorldButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:forgetPassWorldButton];

    
    
    
    UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(211*BILI, telLoginButton.frame.origin.y+ telLoginButton.frame.size.height+15*BILI, 100*BILI, 40*BILI)];
    [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    [self.view addSubview:registerButton];
    
    

}
-(void)bottomTap
{
    [self.passWorldTextField resignFirstResponder];
    [self.accountTextField resignFirstResponder];
}
-(void)registerButtonClick
{
    RegisterViewController * vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)telLoginButtonClick
{
    
    if ([Common isEmpty:self.accountTextField.text] )
    {
        [Common showToastView:@"账号格式有误" view:self.view];
        return;
    }
    if([Common isEmpty:self.passWorldTextField.text])
    {
        [Common showToastView:@"密码格式有误" view:self.view];
        return;
    }
    if (!self.location) {

        [Common showToastView:@"获取登录位置失败,不能进行登录" view:self.view];
    }
    [self showNewLoadingView:@"登录中..." view:self.view];
    
    [self bottomTap];
   
    [self.cloudClient login:@"loginApp.do"
                   username:self.accountTextField.text
                  passworld:self.passWorldTextField.text
                        lot:[NSString stringWithFormat:@"%f",self.location.coordinate.longitude]
                        lat:[NSString stringWithFormat:@"%f",self.location.coordinate.latitude]
                    address:[Common getobjectForKey:self.detailAddress]
                 devicetype:@"2"
                   delegate:self
                   selector:@selector(loginSuccess:)
              errorSelector:@selector(loginError:)];
}
-(void)loginSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:info forKey:USERINFO];
    [defaults synchronize];
    [self cleanUpAction];
    NSNumber * typeNumber = [info objectForKey:@"logintype"];
    if (typeNumber.intValue==1)//网格长

    {
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate resetWangGeZhangTabBar];

    }
    else if (typeNumber.intValue==2)//网格员(专职)
    {
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate resetWanGeYuanTabBar];
    }
    else if (typeNumber.intValue==3||typeNumber.intValue==6)//兼职网格员 民众
    {
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate resetJianZhiAndMinZhongTabBar];
    }
    else if (typeNumber.intValue==4)//综治
    {
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate resetZongZhiTabBar];
    }
    
    
}
-(void)loginError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)forgetPassWorldButtonClick
{
    EditPWViewController * vc = [[EditPWViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//- (void)getCurrentLocation
//{
//    self.myLocation = [[CLLocationManager alloc]init];
//    self.myLocation.delegate = self;
//    if ([self.myLocation respondsToSelector:@selector(requestWhenInUseAuthorization)])
//    {
//        [self.myLocation requestWhenInUseAuthorization];
//    }
//    self.myLocation.desiredAccuracy = kCLLocationAccuracyBest;
//    self.myLocation.distanceFilter = kCLDistanceFilterNone;
//    [self.myLocation startUpdatingLocation];
//}
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//
//    CLLocation *currlocation = [locations objectAtIndex:0];
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:currlocation.coordinate.latitude longitude:currlocation.coordinate.longitude];
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray * placemarks, NSError * error)
//     {
//
//         CLLocation *newLocation = locations[0];
//         oldCoordinate = newLocation.coordinate;
//         NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
//
//         if (placemarks.count > 0) {
//             CLPlacemark *plmark = [placemarks objectAtIndex:0];
//             self.detailAddress = [NSString stringWithFormat:@"%@%@%@%@%@ ",plmark.administrativeArea,plmark.locality,plmark.subLocality,plmark.thoroughfare,plmark.name];
//         }
//     }];
//    [manager stopUpdatingLocation];
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
