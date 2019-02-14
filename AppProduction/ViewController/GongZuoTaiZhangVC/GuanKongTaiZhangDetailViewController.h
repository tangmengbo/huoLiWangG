//
//  GuanKongTaiZhangDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface GuanKongTaiZhangDetailViewController : BaseViewController

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)NSString * visitid;
@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSArray * imageArray;

@end
