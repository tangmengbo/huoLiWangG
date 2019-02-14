//
//  GuiJiHuiFangDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import <MAMapKit/MAAnnotationView.h>
#import <MAMapKit/MAAnimatedAnnotation.h>

@interface GuiJiHuiFangDetailViewController : BaseViewController<MAMapViewDelegate>
{
    int index;
    int arryCount;
    
}

@property(nonatomic,strong)UIView * contentView;
@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UISearchBar * searchBar;

@property(nonatomic,strong)NSDictionary * info;
@property(nonatomic,strong) MAMapView * mapView;
@property(nonatomic,strong)MAAnimatedAnnotation * annotation;

@property(nonatomic,strong)UIView * pickRootView;
@property(nonatomic,strong)UIDatePicker * datePickView ;
@property(nonatomic,strong)NSString * nowDateStr;

@property(nonatomic,strong)NSArray * array;

@property(nonatomic,strong)UIButton * beginAndStopButton;

@end
