//
//  EditPassWorldViewController.h
//  tcmy
//
//  Created by 唐蒙波 on 2017/11/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface EditPassWorldViewController : BaseViewController

@property(nonatomic,strong)CloudClient * cloudClient;


@property(nonatomic,strong)UITextField * oldPassWorldTextField;

@property(nonatomic,strong)UITextField * xinPWTextField1;

@property(nonatomic,strong)UITextField * xinPWTextField2;


@end
