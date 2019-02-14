//
//  ZhengCeXuanChuanListViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JYCarousel.h"

@interface ZhengCeXuanChuanListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,JYCarouselDelegate>
{
    int mainTableViewSection;
    int pageIndex;
}

@property(nonatomic,strong)NSString * titleStr;
@property(nonatomic,strong)NSString * type;

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSArray * lunBoList;
@property(nonatomic,strong)NSMutableArray * sourceListArray;

@property(nonatomic,strong)UIImageView * noContenImageView;
@property(nonatomic,strong)UILabel * lubBoTitleLable;
@end
