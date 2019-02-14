//
//  BaoGaoShenYueViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "BaoGaoShenYueTableViewCell.h"

@interface BaoGaoShenYueViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,ShangBaoBaoGaoViewControllerDelegate>
{
    int pageIndex;
    int sectionNumber;
}

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSMutableArray * sourceArray;

@property(nonatomic,strong)NSString * titleStr;

@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;
@end
