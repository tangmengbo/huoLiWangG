//
//  MapStatic_DanLi.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MapStatic_DanLi.h"

static MAMapView *_mapView = nil;

@implementation MapStatic_DanLi



+ (MAMapView *)shareMAMapView {
    @synchronized(self) {
       // [MAMapServices sharedServices].apiKey = kAMapSearchApplicationSecretKey;
        
        if (_mapView == nil) {
            CGRect frame = CGRectMake(0, 0, VIEW_WIDTH,  VIEW_HEIGHT-(SafeAreaTopHeight+
44*BILIY));
            _mapView = [[MAMapView alloc] initWithFrame:frame];
            _mapView.autoresizingMask =
            UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            _mapView.showsUserLocation = YES;
            //      _mapView.rotateEnabled = YES;
            //      _mapView.rotateCameraEnabled = YES;
            _mapView.zoomEnabled = YES;
        }
        _mapView.frame = [UIScreen mainScreen].bounds;
        return _mapView;
    }
}


- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}


- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    return self;
}
//重写allocWithZone保证分配内存alloc相同
+ (id)allocWithZone:(NSZone *)zone {
    
    @synchronized (self) {
        
        if (_mapView == nil) {
            NSLog(@"构造");
            _mapView = [super allocWithZone:zone];
            return _mapView;
        }
        else return _mapView;
    }
    return nil;
}

//保证copy相同
+ (id)copyWithZone:(NSZone *)zone {
    return _mapView;
}

@end
