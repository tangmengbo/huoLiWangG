//
//  EditTelViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface EditTelViewController : BaseViewController<UITextFieldDelegate>

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)NSString * telStr;


@property(nonatomic,strong)UITextField * telTextField;


@end
