//
//  ChuZhiDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface ChuZhiDetailViewController : BaseViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,CLLocationManagerDelegate>
{
    BOOL alsoShouFeiLei;
    
    int selectTipIndex;
    
    int maxImageSelected;
    
    int imageIndex ;
    
    CLLocationCoordinate2D oldCoordinate;
    
}
@property(nonatomic,strong)NSString * grid;
@property(nonatomic,strong)NSString * shiJianFenLeiStr;
@property(nonatomic,strong)NSString * shiJianGuiMoStr;
@property(nonatomic,strong)NSString * shiJianJiBieStr;
@property(nonatomic,strong)NSString * shiJianXingZhiStr;
@property(nonatomic,strong)NSString * manYiType;
@property(nonatomic,strong)NSString * chuLiFangShi;
@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)NSString * imageIdStr;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UITextField * mingChengTextField;

@property(nonatomic,strong)UITextView * faShengWeiZhiTextField;

@property(nonatomic,strong)UIView * gengDuoView;

@property(nonatomic,strong)UIButton * fenLeiButton;
@property(nonatomic,strong)UILabel * fenLeiLable;
@property(nonatomic,strong)UIScrollView * fenLeiView;

@property(nonatomic,strong)UIButton * guiMoButton;
@property(nonatomic,strong)UILabel * guiMoLable;
@property(nonatomic,strong)UIView * guiMoView;

@property(nonatomic,strong)UIButton * jiBieButton;
@property(nonatomic,strong)UILabel * jiBieLable;
@property(nonatomic,strong)UIView * jiBieView;

@property(nonatomic,strong)UIButton * xingZhiButton;
@property(nonatomic,strong)UILabel * xingZhiLable;
@property(nonatomic,strong)UIView * xingZhiView;

@property(nonatomic,strong)NSMutableArray * sourceArray;
@property(nonatomic,strong)NSString * shiJianType;


@property(nonatomic,strong)UIButton * zhanKaiShouQiButton;
@property(nonatomic,strong)UILabel * zhanKaiShouQiLable;
@property(nonatomic,strong)UIImageView * zhanKaiShouQiImageView;

@property(nonatomic,strong)UIView * contentView;
@property(nonatomic,strong)UILabel * suoShuWangGeLable;

@property(nonatomic,strong)UITextView * neiRongTextView;
@property(nonatomic,strong)UITextView * jieGuoTextView;
@property(nonatomic,strong)UILabel * chuLiFangShiLable;

@property(nonatomic,strong)NSMutableArray * tipButtonArray;

@property(nonatomic, strong) CLLocationManager * myLocation;
@property(nonatomic,strong)UITextView * addressTextView;
@property(nonatomic,strong)NSString * detailAddress;

@property(nonatomic,strong)UIView * imageContentView;
@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@property(nonatomic,strong)NSMutableArray * imageArray;

@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;

@property(nonatomic,strong)NSString * neiRongOrJieGuo;

@property (nonatomic, strong) NSString * result;

@property(nonatomic,strong)UIView * voiceHeightBottomView;
@property(nonatomic,strong)UIImageView * voiceHeightImageView;


@end
