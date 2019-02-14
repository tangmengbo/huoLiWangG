//
//  ZhongDianRenQunXinXiViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface ZhongDianRenQunXinXiViewController : BaseViewController
{
   
}
@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)NSString * dataid;
@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSDictionary * info;

@end
