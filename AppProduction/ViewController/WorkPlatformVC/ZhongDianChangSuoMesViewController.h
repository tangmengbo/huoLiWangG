//
//  ZhongDianChangSuoMesViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface ZhongDianChangSuoMesViewController : BaseViewController

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)NSString * dataid;

@property(nonatomic,strong)NSDictionary * info;

@end
