//
//  BaoGaoChuLiViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"


@interface BaoGaoChuLiViewController : BaseViewController<UIScrollViewDelegate>
{
    BOOL alsoShouFeiLei;
    int selectTipIndex;

}
@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)NSString * shiJianFenLeiStr;
@property(nonatomic,strong)NSString * shiJianGuiMoStr;
@property(nonatomic,strong)NSString * shiJianJiBieStr;
@property(nonatomic,strong)NSString * shiJianXingZhiStr;

@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;

@property(nonatomic,strong)UIView * voiceHeightBottomView;
@property(nonatomic,strong)UIImageView * voiceHeightImageView;

@property(nonatomic,strong)NSMutableArray * tipButtonArray;

@property(nonatomic,strong)UIScrollView * fenLeiView;


@property(nonatomic,strong)UIButton * fenLeiButton;
@property(nonatomic,strong)UILabel * fenLeiLable;

@property(nonatomic,strong)UIButton * guiMoButton;
@property(nonatomic,strong)UILabel * guiMoLable;

@property(nonatomic,strong)UIButton * jiBieButton;
@property(nonatomic,strong)UILabel * jiBieLable;

@property(nonatomic,strong)UIButton * xingZhiButton;
@property(nonatomic,strong)UILabel * xingZhiLable;

@property(nonatomic,strong)NSMutableArray * sourceArray;
@property(nonatomic,strong)NSString * shiJianType;

@property(nonatomic,strong)UITextView * neiRongTextView;

@end
