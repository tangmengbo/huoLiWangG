//
//  ZhongDianRenQunShangBaoViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface ZhongDianRenQunShangBaoViewController : BaseViewController<UIImagePickerControllerDelegate,UIScrollViewDelegate,UITextViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate,TZImagePickerControllerDelegate>
{
    int maxImageSelected;
    int selectTipIndex;
    BOOL alsoShouFeiLei;
    
    int imageIndex;
    
    CLLocationCoordinate2D oldCoordinate;
}

@property(nonatomic,strong)NSDictionary * info;



@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)UILabel * suoShuWangGeLable;

@property(nonatomic,strong)NSMutableArray * tipButtonArray;

@property(nonatomic, strong) CLLocationManager * myLocation;

@property(nonatomic,strong)UIView * fenLeiView;
@property(nonatomic,strong)NSArray * fenLeiArray;

@property(nonatomic,strong)UITextView * addressTextView;
@property(nonatomic,strong)NSString  * detailAddress;

@property(nonatomic,strong)UITextView * neiRongTextView;

@property(nonatomic,strong)UIView * imageContentView;
@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@property(nonatomic,strong)NSMutableArray * imageArray;

@property(nonatomic,strong)NSString * imageIdStr;
@property(nonatomic,strong)NSString * manYiType;




@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;

@property (nonatomic, strong) NSString * result;

@property(nonatomic,strong)UIView * voiceHeightBottomView;
@property(nonatomic,strong)UIImageView * voiceHeightImageView;

@end
