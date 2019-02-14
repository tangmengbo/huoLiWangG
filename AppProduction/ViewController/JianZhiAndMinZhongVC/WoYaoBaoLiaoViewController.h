//
//  WoYaoBaoLiaoViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@protocol WoYaoBaoLiaoViewControllerDelegate
@required

- (void)baoLiaoShangBaoSuccess;
@end

@interface WoYaoBaoLiaoViewController : BaseViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,CLLocationManagerDelegate>
{
    int maxImageSelected;
    int imageIndex;
    
    CLLocationCoordinate2D oldCoordinate;
}
@property (nonatomic, assign) id<WoYaoBaoLiaoViewControllerDelegate> delegate;

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)NSDictionary * userInfo;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UITextView * jingGuoTextView;



@property(nonatomic,strong)NSString * imageIdStr;
@property(nonatomic, strong) CLLocationManager * myLocation;
@property(nonatomic,strong)UITextView * addressTextView;
@property(nonatomic,strong)NSString * detailAddress;
@property(nonatomic,strong)UIView * imageContentView;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@property(nonatomic,strong)NSMutableArray * imageArray;

@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;
@property(nonatomic,strong)UIView * voiceHeightBottomView;
@property(nonatomic,strong)UIImageView * voiceHeightImageView;

@end
