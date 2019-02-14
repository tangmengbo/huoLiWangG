//
//  TongJiFenXiViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface TongJiFenXiViewController : BaseViewController
{
    BOOL alsoShouFeiLei;
}

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSString * fenLeiType;
@property(nonatomic,strong)UIScrollView * fenLeiView;
@property(nonatomic,strong)NSMutableArray * sourceArray;

@property(nonatomic,strong)NSDictionary * nowInfo;//本年,本月,本季度



@property(nonatomic,strong)NSString * month;
@property(nonatomic,strong)NSString * jiDu;
@property(nonatomic,strong)NSString * year;

@property(nonatomic,strong)NSArray * sjLeveArray;
@property(nonatomic,strong)NSArray * chuLiQingKuangArray;
@property(nonatomic,strong)NSArray * sjLeiBieArray;
@property(nonatomic,strong)NSArray * renKouGaiKuangArray;

@property(nonatomic,strong)UIButton * monthButton;
@property(nonatomic,strong)UIButton * jiDuButton;
@property(nonatomic,strong)UIButton * yearButton;

@end
