//
//  ZongZhiTongJiFenXiViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface ZongZhiTongJiFenXiViewController : BaseViewController
{
    BOOL alsoShouFeiLei;
}

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)UIView * contentView;

@property(nonatomic,strong)NSDictionary * nowInfo;

@property(nonatomic,strong)NSString * fenLeiType;
@property(nonatomic,strong)UIScrollView * fenLeiView;
@property(nonatomic,strong)NSMutableArray * sourceArray;

@property(nonatomic,strong)NSString * month;
@property(nonatomic,strong)NSString * jiDu;
@property(nonatomic,strong)NSString * year;

@property(nonatomic,strong)UIButton * monthButton;
@property(nonatomic,strong)UIButton * jiDuButton;
@property(nonatomic,strong)UIButton * yearButton;

@end
