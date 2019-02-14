//
//  GZTZ_RuHuDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/8/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface GZTZ_RuHuDetailViewController : BaseViewController

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)NSString * dataid;
@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)NSArray * imageArray;


@end
