//
//  YiBAnChangSuoViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface YiBAnChangSuoViewController : BaseViewController<CLLocationManagerDelegate,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    int selectTipIndex;
    
    int maxImageSelected;
    
    BOOL alsoScroll;
    
    BOOL alsoShouFeiLei;
    
    CLLocationCoordinate2D oldCoordinate;
    
    int imageIndex;

}
@property(nonatomic,strong)NSString * shiJianType;

@property(nonatomic,strong)NSString * grid;

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSArray * gridlist;

@property(nonatomic,strong)NSString * manYiType;//满意度
//risktype  隐患分类代码:
@property(nonatomic,strong)NSString * risktype;
@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic, strong) CLLocationManager * myLocation;

@property(nonatomic,strong)UITextField * mingChengTextField;
@property(nonatomic,strong)UITextField * fuZeRenTextField;
@property(nonatomic,strong)UITextField * telTextField;
@property(nonatomic,strong)UILabel * suoShuWangGeLable;
@property(nonatomic,strong)UITextView * addressTextView;
@property(nonatomic,strong)NSString * detailAddress;

@property(nonatomic,strong)UILabel * riQiLable;

@property(nonatomic,strong)UIView * fenLeiView;
@property(nonatomic,strong)NSArray * fenLeiArray;
@property(nonatomic,strong)UILabel * fenLeiLable;

@property(nonatomic,strong)UITextView * neiRongTextView;

@property(nonatomic,strong)NSString * shiFouJieJue;//是否解决

@property(nonatomic,strong)NSMutableArray * tipButtonArray;

@property(nonatomic,strong)UIView * imageContentView;
@property(nonatomic,strong)NSMutableArray * imageArray;

@property(nonatomic,strong)NSString * imageIdStr;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;


@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;

@property (nonatomic, strong) NSString * result;

@property(nonatomic,strong)UIView * voiceHeightBottomView;
@property(nonatomic,strong)UIImageView * voiceHeightImageView;

@end
