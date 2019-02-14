//
//  TelephoneRegistViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/1/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface EditPWViewController : BaseViewController
{
    int stepSeconds;

}

@property(nonatomic,strong)UITextField * telTextField;
@property(nonatomic,strong)UITextField * checkNumberTextField;
@property(nonatomic,strong)UITextField * passWorldRextField;
@property(nonatomic,strong)UITextField * passWorldAgainTextField;

@property(nonatomic,strong)NSString * cityName;

@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,strong)UIButton * getCheckNumberButton;


@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)NSString * alsoForgetPassWorld;

@end
