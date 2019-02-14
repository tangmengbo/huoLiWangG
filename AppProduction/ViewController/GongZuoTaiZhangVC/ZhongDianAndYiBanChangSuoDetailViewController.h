//
//  ZhongDianAndYiBanChangSuoDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface ZhongDianAndYiBanChangSuoDetailViewController : BaseViewController

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)NSString * patrolid;
@property(nonatomic,strong)NSString * fromWhere;
@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSArray * imageArray;

@end
