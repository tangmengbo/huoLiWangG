//
//  KaoHePingBiListViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface KaoHePingBiListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL alsoShouFeiLei;
    
    int mainTableViewSection;
    int pageIndex;
    

}

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSMutableArray * kaoHeList;

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
