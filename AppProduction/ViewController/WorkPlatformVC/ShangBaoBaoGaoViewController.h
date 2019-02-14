//
//  ShangBaoBaoGaoViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@protocol ShangBaoBaoGaoViewControllerDelegate
@required

- (void)shagBaoBaoGaoSuccess;
@end


@interface ShangBaoBaoGaoViewController : BaseViewController<UIScrollViewDelegate,UIActionSheetDelegate,CLLocationManagerDelegate>
{
    int maxImageSelected;
    BOOL alsoShouFeiLei;
    CLLocationCoordinate2D oldCoordinate;
    int imageIndex;
}
@property (nonatomic, assign) id<ShangBaoBaoGaoViewControllerDelegate> delegate;

@property(nonatomic,strong)NSString * grid;
@property(nonatomic,strong)NSString * shiJianFenLeiStr;
@property(nonatomic,strong)NSString * shiJianGuiMoStr;
@property(nonatomic,strong)NSString * shiJianJiBieStr;
@property(nonatomic,strong)NSString * shiJianXingZhiStr;

@property(nonatomic,strong)NSString * imageIdStr;


@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UITextField * mingChengTextField;

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

@property(nonatomic, strong) CLLocationManager * myLocation;
@property(nonatomic,strong)UITextView * addressTextView;
@property(nonatomic,strong)NSString * detailAddress;

@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@property(nonatomic,strong)UIView * imageContentView;


@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;
@property(nonatomic,strong)UIView * voiceHeightBottomView;
@property(nonatomic,strong)UIImageView * voiceHeightImageView;

@end
