//
//  BaoGaoDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "BaoGaoChuLiViewController.h"

@interface BaoGaoDetailViewController : BaseViewController

@property(nonatomic,strong)NSString * eventid;


@property(nonatomic,strong)NSString * fromWhere;

@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSArray * imageArray;

@property(nonatomic,strong)NSString * membertel;

@end
