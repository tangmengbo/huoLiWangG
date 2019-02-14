//
//  ShiJianDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface ShiJianDetailViewController : BaseViewController
{
    float jinDuDetailViewHeight;
}

@property(nonatomic,strong)NSString * eventid;

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIView * shiJianContentView;

@property(nonatomic,strong)UIView * jinDuDetailView;

@property(nonatomic,strong)NSArray * imageArray;

@property(nonatomic,strong)NSString * membertel;

@end
