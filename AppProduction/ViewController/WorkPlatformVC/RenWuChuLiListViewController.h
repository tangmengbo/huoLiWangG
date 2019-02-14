//
//  RenWuChuLiListViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "RenWuChuLiListTableViewCell.h"
#import "RenWuDetailViewController.h"
#import "XiaDaRenWuViewController.h"

@interface RenWuChuLiListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,XiaDaRenWuViewControllerDelegate>
{
    int weiChuLiPageIndex;
    int yiChuLiPageIndex;
    int woDeXiaDaPageIndex;
    
    int weiChuLiTableViewSection;
    int yiChuLiTableViewSection;
    int woDeXiaDaTableViewSection;
    
    
    int nowTip;
}
@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UIView * sliderView;
@property(nonatomic,strong)UIButton * weiChuLiButton;
@property(nonatomic,strong)UIButton * yiChuLiButton;
@property(nonatomic,strong)UIButton * woDeXiaDaButton;

@property(nonatomic,strong)UITableView * weiChuLiTableView;
@property(nonatomic,strong)NSMutableArray * weiChuLiArray;
@property(nonatomic,strong)UITableView * yiChuLiTableView;
@property(nonatomic,strong)NSMutableArray * yiChuLiArray;
@property(nonatomic,strong)UITableView * woDeXiaDaTableView;
@property(nonatomic,strong)NSMutableArray * woDeXiaDaArray;

@property(nonatomic,strong)UIImageView * noContenImageView;

@end
