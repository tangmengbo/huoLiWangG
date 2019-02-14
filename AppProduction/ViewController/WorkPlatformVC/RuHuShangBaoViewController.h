//
//  RuHuShangBaoViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "UITextView+ZWPlaceHolder.h"


@interface RuHuShangBaoViewController : BaseViewController<IFlySpeechRecognizerDelegate,IFlyPcmRecorderDelegate,UIActionSheetDelegate,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>
{
    int maxImageSelected;
    int selectTipIndex;
    
    int imageIndex;
    
    CLLocationCoordinate2D oldCoordinate;
}

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)NSDictionary * info;


@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;

@property(nonatomic,strong)UIView * voiceHeightBottomView;
@property(nonatomic,strong)UIImageView * voiceHeightImageView;

@property(nonatomic,strong)NSString * manYiType;

@property (nonatomic, strong) NSString * result;

@property(nonatomic,strong)UITextView * textView;

@property(nonatomic,strong)UIView * imageContentView;
@property(nonatomic,strong)NSMutableArray * imageArray;

@property(nonatomic,strong)NSString * imageIdStr;

@property(nonatomic,strong)UIImagePickerController * imagePickerController;

@property(nonatomic, strong) CLLocationManager * myLocation;

@property(nonatomic,strong)NSString * detailAddress;

@property(nonatomic,strong)UILabel * addressLable;

@property(nonatomic,strong)NSMutableArray * tipButtonArray;


@end
