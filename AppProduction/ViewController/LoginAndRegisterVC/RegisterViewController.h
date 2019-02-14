//
//  RegisterViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/8/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate>
{
    int stepSeconds;

}

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UITextField * telTextField;
@property(nonatomic,strong)UITextField * nameTextField;
@property(nonatomic,strong)UITextField * checkNumberTextField;

@property(nonatomic,strong)UITextField * passWorldRextField;
@property(nonatomic,strong)UITextField * passWorldAgainTextField;

@property(nonatomic,strong)UITextField * shenFenTextField;

@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,strong)UIButton * getCheckNumberButton;

@property(nonatomic,strong)UIImageView * manImageView;
@property(nonatomic,strong)UIImageView * womanImageView;

@property(nonatomic,strong)NSString * manOrWoman;

@property(nonatomic,strong)NSString * detailAddress;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic,strong) CLLocation * location;


@end
