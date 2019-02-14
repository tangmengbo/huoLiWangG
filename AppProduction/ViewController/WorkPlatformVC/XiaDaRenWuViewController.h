//
//  XiaDaRenWuViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "WangGeYuanListViewController.h"

@protocol XiaDaRenWuViewControllerDelegate
@required

- (void)xiaDaTaskSuccess;
@end

@interface XiaDaRenWuViewController : BaseViewController<UIScrollViewDelegate,WangGeYuanListViewControllerelegate>

@property (nonatomic, assign) id<XiaDaRenWuViewControllerDelegate> delegate;


@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)NSDictionary * selectInfo;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIButton * wangGeYuanButton;
@property(nonatomic,strong)UIButton * timeButton;
@property(nonatomic,strong)UITextField * titleTextField;

@property(nonatomic,strong)UITextView * neiRongTextView;

@property(nonatomic,strong)UIView * pickRootView;
@property(nonatomic,strong)UIDatePicker * datePickView ;
@property(nonatomic,strong)NSString * birthday;

@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;
@property(nonatomic,strong)UIView * voiceHeightBottomView;
@property(nonatomic,strong)UIImageView * voiceHeightImageView;


@end
