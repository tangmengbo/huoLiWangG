//
//  GuiJiHuiFangDetailViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GuiJiHuiFangDetailViewController.h"
#import "MapStatic_DanLi.h"


@interface GuiJiHuiFangDetailViewController ()

@end

@implementation GuiJiHuiFangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    
    self.titleLale.text = @"轨迹回放";
    self.titleLale.textColor = [UIColor whiteColor];
    self.cloudClient = [CloudClient getInstance];
    self.array = [NSMutableArray array];
    
    NSDate *select = [NSDate date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd";
    self.nowDateStr = [selectDateFormatter stringFromDate:select];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.contentView];

    
    [AMapServices sharedServices].enableHTTPS = YES;
    
    
    [self getDataSource];

    
    [self initPickView];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    self.mapView.delegate = nil;
    self.mapView.showsUserLocation = NO;
    [self.mapView removeFromSuperview];

    
}
-(void)initPickView
{
    self.pickRootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT*5)];
    self.pickRootView.backgroundColor = [UIColor blackColor];
    self.pickRootView.alpha = 0.5;
    [self.view addSubview:self.pickRootView];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickRootViewTap)];
    [self.pickRootView addGestureRecognizer:tapGesture];
    
    self.datePickView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-162, VIEW_WIDTH, 162)];
    self.datePickView.datePickerMode=UIDatePickerModeDate;
    [self.view addSubview:self.datePickView];
    self.datePickView.maximumDate = [NSDate date];
    self.datePickView.backgroundColor = [UIColor whiteColor];
    [self.datePickView addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    self.datePickView.hidden = YES;
    self.pickRootView.hidden = YES;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //设置日期最大及最小值
    
}
#pragma mark - 实现oneDatePicker的监听方法
-(void)oneDatePickerValueChanged:(UIDatePicker *) sender
{
    NSDate *select = [sender date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd";
    self.nowDateStr = [selectDateFormatter stringFromDate:select];
    self.searchBar.text = self.nowDateStr;
    
}
-(void)timeButtonClick
{
    self.datePickView.hidden = NO;
    self.pickRootView.hidden = NO;
}

-(void)pickRootViewTap
{
    self.datePickView.hidden = YES;
    self.pickRootView.hidden = YES;
    
    [self getDataSource];
}

-(void)getDataSource
{
    [self.cloudClient guiJiHuiFangList:@"runReplay.do"
                                   day:self.nowDateStr
                              memberid:[self.info objectForKey:@"memberid"]
                              delegate:self
                              selector:@selector(getGuiJiListSuccess:)
                         errorSelector:@selector(getGuiJiListError:)];
}
-(void)getGuiJiListSuccess:(NSArray *)array
{
    [self.contentView removeAllSubviews];
    
    self.mapView = [MapStatic_DanLi shareMAMapView];//[[MAMapView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mapView.delegate = self;
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    [self.mapView setZoomLevel:16 animated:YES];
    [self.contentView addSubview:self.mapView];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(13*BILI, 8*BILI, VIEW_WIDTH-26*BILI, 50)];// 初始化
    [self.searchBar setShowsCancelButton:NO];// 是否显示取消按钮
    [self.searchBar setTintColor:[UIColor blackColor]];// 搜索框的颜色，当设置此属性时，barStyle将失效
    [self.searchBar setTranslucent:YES];// 设置是否透明
    [self.contentView addSubview:self.searchBar];
    self.searchBar.text = self.nowDateStr;
    
    UIButton * timeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.origin.y, VIEW_WIDTH, 50)];
    timeButton.backgroundColor = [UIColor clearColor];
    [timeButton addTarget:self action:@selector(timeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:timeButton];
    
    
    self.beginAndStopButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-100*BILI, VIEW_HEIGHT-80*BILI-(self.navView.frame.origin.y+self.navView.frame.size.height), 50*BILI, 50*BILI)];
    [self.beginAndStopButton setBackgroundColor:UIColorFromRGB(0xFE9052)];
    [self.beginAndStopButton setTitle:@"开始" forState:UIControlStateNormal];
    [self.beginAndStopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.beginAndStopButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.beginAndStopButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.beginAndStopButton.layer.cornerRadius = 25*BILI;
    [self.contentView addSubview:self.beginAndStopButton];
    
   
    
    
    
    if (array.count==0)
    {
         [Common showToastView:@"未记录到轨迹" view:self.view];
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView removeOverlays:self.mapView.overlays];
    }
    else
    {
        
        self.array = array;
        
        arryCount = (int)self.array.count;

        CLLocationCoordinate2D commonPolylineCoords[self.array.count];
        
        for (int i=0; i<self.array.count; i++) {
            NSDictionary * info = [self.array objectAtIndex:i];
            commonPolylineCoords[i].latitude = [[info objectForKey:@"lat"] floatValue];
            commonPolylineCoords[i].longitude = [[info objectForKey:@"lot"] floatValue];
            if (i==array.count/2) {
                
                 self.mapView.centerCoordinate = CLLocationCoordinate2DMake([[info objectForKey:@"lat"] floatValue], [[info objectForKey:@"lot"] floatValue]);
            }
        }
        
       

        //构造折线对象 添加折现
        MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:self.array.count];
        [self.mapView addOverlay: commonPolyline];
        
        
        for (int i=0; i<self.array.count; i++) {
            NSDictionary * info = [self.array objectAtIndex:i];
            
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake([[info objectForKey:@"lat"] floatValue], [[info objectForKey:@"lot"] floatValue]);
            index = i;
            pointAnnotation.title = @"";
            [self.mapView addAnnotation:pointAnnotation];//地图上添加点
        }
        
        
        //地图上添加移动动画
        MAAnimatedAnnotation *anno = [[MAAnimatedAnnotation alloc] init];
        anno.coordinate = commonPolylineCoords[0];
        self.annotation = anno;
        self.annotation.title = @" ";
        [self.mapView addAnnotation:self.annotation];
        
        
        
    }
}
-(void)startButtonClick
{
    CLLocationCoordinate2D commonPolylineCoords[self.array.count];
    for (int i=0; i<self.array.count; i++) {
        NSDictionary * info = [self.array objectAtIndex:i];
        commonPolylineCoords[i].latitude = [[info objectForKey:@"lat"] floatValue];
        commonPolylineCoords[i].longitude = [[info objectForKey:@"lot"] floatValue];
    }

    if ([@"开始" isEqualToString:self.beginAndStopButton.titleLabel.text]) {
        
        [self.beginAndStopButton setTitle:@"停止" forState:UIControlStateNormal];
        [self.annotation addMoveAnimationWithKeyCoordinates:commonPolylineCoords
                                                      count:self.array.count
                                               withDuration:20
                                                   withName:nil completeCallback:^(BOOL isFinished) {
                                                       
                                                       
                                                   }];
    }
    else
    {
        [self.beginAndStopButton setTitle:@"开始" forState:UIControlStateNormal];
        for (MAAnnotationMoveAnimation *animation in [self.annotation allMoveAnimations]) {
            [animation cancel];
        }
        self.annotation.movingDirection = 0;
        self.annotation.coordinate = commonPolylineCoords[0];
    }
    
    
   

}
-(void)demo
{
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;
    
    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;
    
    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;
    
    commonPolylineCoords[3].latitude = 39.902136;
    commonPolylineCoords[3].longitude = 116.44095;
    
    
    MAPointAnnotation *pointAnnotation1 = [[MAPointAnnotation alloc] init];
    MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc] init];
    MAPointAnnotation *pointAnnotation3 = [[MAPointAnnotation alloc] init];
    MAPointAnnotation *pointAnnotation4 = [[MAPointAnnotation alloc] init];
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
    
    [self.mapView addOverlay: commonPolyline];
    
    self.annotation = [[MAAnimatedAnnotation alloc] init];
    self.annotation.coordinate = commonPolylineCoords[0];
    self.annotation.movingDirection = 0;
    [self.mapView addAnnotation:self.annotation];
    
    
    [self.annotation addMoveAnimationWithKeyCoordinates:commonPolylineCoords
                                                  count:4
                                           withDuration:20
                                               withName:nil completeCallback:^(BOOL isFinished) {
                                                   
                                                   
                                               }];
    
    pointAnnotation1.coordinate = CLLocationCoordinate2DMake(39.832136, 116.34095);
    index = 0;
    [self.mapView addAnnotation:pointAnnotation1];
    pointAnnotation2.coordinate = CLLocationCoordinate2DMake(39.832136, 116.42095);
    index = 1;
    [self.mapView addAnnotation:pointAnnotation2];
    pointAnnotation3.coordinate = CLLocationCoordinate2DMake(39.902136, 116.42095);
    index = 2;
    [self.mapView addAnnotation:pointAnnotation3];
    pointAnnotation4.coordinate = CLLocationCoordinate2DMake(39.902136, 116.44095);
    index = 3;
    [self.mapView addAnnotation:pointAnnotation4];
}
-(void)getGuiJiListError:(NSDictionary *)info
{
    [Common showToastView:@"未记录到轨迹" view:self.view];
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeImage  = [UIImage imageNamed:@"arrowTexture"];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            if(self.array.count>0)
            {
                annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
                NSDictionary * info = [self.array objectAtIndex:0];
                NSDictionary * info1 = [self.array objectAtIndex:self.array.count-1];
                if (annotation.coordinate.latitude==[[info objectForKey:@"lat"] floatValue]&&annotation.coordinate.longitude ==[[info objectForKey:@"lot"] floatValue])
                {
                    annotationView.image = [UIImage imageNamed:@"icon_qidian"];//userPosition
                    annotationView.centerOffset = CGPointMake(0,-18);
                    if ([annotationView.annotation.title isEqualToString:@" "]) {
                        
                        annotationView.image = [UIImage imageNamed:@"userPosition"];
                        annotationView.centerOffset = CGPointMake(0,0);
                    }
                }
                else if (annotation.coordinate.latitude==[[info1 objectForKey:@"lat"] floatValue]&&annotation.coordinate.longitude ==[[info1 objectForKey:@"lot"] floatValue])
                {
                    
                    annotationView.image = [UIImage imageNamed:@"icon_zhongdain"];
                    annotationView.centerOffset = CGPointMake(0,0);
                }
                else
                {
                    //annotationView.image = [UIImage imageNamed:@"dianPoint"];
                    //设置中心点偏移，使得标注底部中间点成为经纬度对应点
                    annotationView.centerOffset = CGPointMake(0,0);
                }
            }
            
        }


        return annotationView;
    }
   
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
