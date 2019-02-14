//
//  BaoLiaoDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaoLiaoDetailViewController : BaseViewController
{
    int sourceImageIndex;
}
@property(nonatomic,strong)NSDictionary * info;
@property(nonatomic,strong)NSMutableArray * photoArray;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@end
