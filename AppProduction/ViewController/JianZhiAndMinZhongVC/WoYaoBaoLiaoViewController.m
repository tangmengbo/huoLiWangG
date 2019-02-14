//
//  WoYaoBaoLiaoViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WoYaoBaoLiaoViewController.h"

@interface WoYaoBaoLiaoViewController ()

@end

@implementation WoYaoBaoLiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    maxImageSelected = 5;
    self.imageArray = [NSMutableArray array];
    imageIndex = 0;
    
    self.cloudClient = [CloudClient getInstance];
    
    [self getCurrentLocation];
    
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"我要爆料";
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.userInfo = [defaults objectForKey:USERINFO];
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI, 0, 50*BILI, self.navView.frame.size.height)];
    [rightButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [self.navView addSubview:rightButton];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];

    self.jingGuoTextView = [[UITextView alloc] initWithFrame:CGRectMake(13*BILI, 13*BILI, VIEW_WIDTH-26*BILI, 100*BILIY)];
    self.jingGuoTextView.font = [UIFont systemFontOfSize:16*BILI];
    self.jingGuoTextView.zw_placeHolder = @"描述爆料事件经过...";
    self.jingGuoTextView.textColor = UIColorFromRGB(0x787878);
    self.jingGuoTextView.tag = 101;
    [self.mainScrollView addSubview:self.jingGuoTextView];
    
    UIButton * jieGuoStartButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI-13*BILI, self.jingGuoTextView.frame.origin.y+self.jingGuoTextView.frame.size.height+10*BILIY, 50*BILI, 50*BILI)];
    [jieGuoStartButton addTarget:self action:@selector(jieGuoBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:jieGuoStartButton];
    
    self.voiceHeightBottomView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200*BILI)/2, (VIEW_HEIGHT-200*BILI)/2, 200*BILI, 200*BILI)];
    self.voiceHeightBottomView.hidden = YES;
    self.voiceHeightBottomView.alpha = 0.5;
    self.voiceHeightBottomView.layer.cornerRadius = 8*BILI;
    self.voiceHeightBottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.voiceHeightBottomView];
    
    self.voiceHeightImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-100*BILI)/2, (VIEW_HEIGHT-100*BILI)/2, 100*BILI, 100*BILI)];
    self.voiceHeightImageView.hidden = YES;
    self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_1"];
    [self.view addSubview:self.voiceHeightImageView];
    
    UIImageView * jieGuoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((50-21/1.5)*BILI/2, (50-32/1.5)*BILI/2, 21*BILI/1.5, 32*BILI/1.5)];
    jieGuoImageView.image = [UIImage imageNamed:@"huatong_gray"];
    [jieGuoStartButton addSubview:jieGuoImageView];
    
    self.imageContentView = [[UIView alloc] initWithFrame:CGRectMake(15*BILI, jieGuoStartButton.frame.origin.y+jieGuoStartButton.frame.size.height, VIEW_WIDTH-30*BILI, 0)];
    [self.mainScrollView addSubview:self.imageContentView];
    
    [self initImageContentView];
}
-(void)initImageContentView
{
    [self.imageContentView removeAllSubviews];
    float imageHeight = (VIEW_WIDTH-30*BILI-15*BILI)/4;
    
    for (int i=0; i<self.imageArray.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i%4)*(imageHeight+5*BILI), (imageHeight+5*BILI)*(i/4), imageHeight, imageHeight)];
        imageView.userInteractionEnabled = YES;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [self.imageArray objectAtIndex:i];
        [self.imageContentView addSubview:imageView];
        
        UIImageView * imageDelete = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.size.width-21*BILI, 0, 21*BILI, 21*BILI)];
        imageDelete.image = [UIImage imageNamed:@"create_dongtai_shanchu"];
        [imageView addSubview:imageDelete];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.size.width-30*BILI, 0, 30*BILI, 30*BILI)];
        button.tag = i;
        [button addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
    }
    if(self.imageArray.count==maxImageSelected)
    {
        
    }
    else
    {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((self.imageArray.count%4)*(imageHeight+5*BILI), (imageHeight+5*BILI)*(self.imageArray.count/4), imageHeight, imageHeight)];
        [button setImage:[UIImage imageNamed:@"checkPhoto"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addMediaButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.imageContentView addSubview:button];
    }
    float nowHeight;
    if (self.imageArray.count<=3)
    {
        
        nowHeight = imageHeight+5*BILI;
    }
    else
    {
        nowHeight = (imageHeight+5*BILI)*2;
    }
    //self.imageContentView.frame = CGRectMake(self.imageContentView.frame.origin.x, self.imageContentView.frame.origin.y, VIEW_WIDTH-26*BILI, nowHeight);
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, nowHeight+5*BILI, VIEW_WIDTH, 1)];
    lineView.backgroundColor =UIColorFromRGB(0xE4E4E4);
    [self.imageContentView addSubview:lineView];
    
    UIImageView * locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y+(60-17)*BILI/2, 12*BILI, 17*BILI)];
    locationImageView.image = [UIImage imageNamed:@"location"];
    [self.imageContentView addSubview:locationImageView];
    
    self.addressTextView = [[UITextView alloc] initWithFrame:CGRectMake(locationImageView.frame.origin.x+locationImageView.frame.size.width+10, lineView.frame.origin.y+1, self.imageContentView.frame.size.width-(locationImageView.frame.origin.x+locationImageView.frame.size.width+10), 60*BILI)];
    self.addressTextView.font = [UIFont systemFontOfSize:16*BILI];
    self.addressTextView.textColor = UIColorFromRGB(0x4A4A4A);
    //self.addressTextView.numberOfLines = 2;
    self.addressTextView.editable = NO;
    self.addressTextView.text = self.detailAddress;
    [self.imageContentView addSubview:self.addressTextView];
    
    UIView * addressLineView = [[UIView alloc] initWithFrame:CGRectMake(-15*BILI, self.addressTextView.frame.origin.y+self.addressTextView.frame.size.height, VIEW_WIDTH*2, 15*BILI)];
    addressLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.imageContentView addSubview:addressLineView];
    
    UIImageView * xiaoRenImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, addressLineView.frame.origin.y+addressLineView.frame.size.height+(50-17)*BILI/2, 17*BILI, 17*BILI)];
    xiaoRenImageView.image = [UIImage imageNamed: @"xiaoren"];
    [self.imageContentView addSubview:xiaoRenImageView];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(xiaoRenImageView.frame.origin.x+xiaoRenImageView.frame.size.width+10*BILI, addressLineView.frame.origin.y+addressLineView.frame.size.height, 100, 50*BILI)];
    nameLable.textColor =UIColorFromRGB(0x787878);
    nameLable.font = [UIFont systemFontOfSize:16*BILI];
    nameLable.text = @"联系人";
    [self.imageContentView addSubview:nameLable];
    
    UILabel * nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLable.frame.origin.y, self.imageContentView.frame.size.width, 50*BILI)];
    nameLable1.textColor =UIColorFromRGB(0x787878);
    nameLable1.font = [UIFont systemFontOfSize:16*BILI];
    nameLable1.text = [self.userInfo objectForKey:@"realname"];
    nameLable1.textAlignment = NSTextAlignmentRight;
    [self.imageContentView addSubview:nameLable1];
    
    UIView * nameLineView = [[UIView alloc] initWithFrame:CGRectMake(-15*BILI, nameLable1.frame.origin.y+nameLable1.frame.size.height, VIEW_WIDTH*2, 1)];
    nameLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.imageContentView addSubview:nameLineView];
    
    UIImageView *riQiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nameLineView.frame.origin.y+nameLineView.frame.size.height+(50-17)*BILI/2, 17*BILI, 17*BILI)];
    riQiImageView.image = [UIImage imageNamed: @"naozhong"];
    [self.imageContentView addSubview:riQiImageView];
    
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(xiaoRenImageView.frame.origin.x+xiaoRenImageView.frame.size.width+10*BILI, nameLineView.frame.origin.y+nameLineView.frame.size.height, 100, 50*BILI)];
    telLable.textColor =UIColorFromRGB(0x787878);
    telLable.font = [UIFont systemFontOfSize:16*BILI];
    telLable.text = @"联系电话";
    [self.imageContentView addSubview:telLable];
    
    
    UILabel * telLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, telLable.frame.origin.y, self.imageContentView.frame.size.width, 50*BILI)];
    telLable1.textColor =UIColorFromRGB(0x787878);
    telLable1.font = [UIFont systemFontOfSize:16*BILI];
    telLable1.textAlignment = NSTextAlignmentRight;
    telLable1.text = [self.userInfo objectForKey:@"tel"];
    [self.imageContentView addSubview:telLable1];
    
    UIView * telLableLineView = [[UIView alloc] initWithFrame:CGRectMake(-15*BILI, telLable1.frame.origin.y+telLable1.frame.size.height, VIEW_WIDTH*2, 1)];
    telLableLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.imageContentView addSubview:telLableLineView];
    
    
    
    UIImageView * timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, telLableLineView.frame.origin.y+telLableLineView.frame.size.height+(50-17)*BILI/2, 17*BILI, 17*BILI)];
    timeImageView.image = [UIImage imageNamed: @"naozhong"];
    [self.imageContentView addSubview:timeImageView];
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(xiaoRenImageView.frame.origin.x+xiaoRenImageView.frame.size.width+10*BILI, telLableLineView.frame.origin.y+telLableLineView.frame.size.height, 100, 50*BILI)];
    timeLable.textColor =UIColorFromRGB(0x787878);
    timeLable.font = [UIFont systemFontOfSize:16*BILI];
    timeLable.text = @"爆料时间";
    [self.imageContentView addSubview:timeLable];
    
    NSDictionary * dataDic = [Common getNowDateAndWeek];
    
    UILabel * timeLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, timeLable.frame.origin.y, self.imageContentView.frame.size.width, 50*BILI)];
    timeLable1.textColor =UIColorFromRGB(0x787878);
    timeLable1.font = [UIFont systemFontOfSize:16*BILI];
    timeLable1.textAlignment = NSTextAlignmentRight;
    timeLable1.text = [NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]];
    [self.imageContentView addSubview:timeLable1];
    
    UIView * timeLineView = [[UIView alloc] initWithFrame:CGRectMake(-15*BILI, timeLable1.frame.origin.y+timeLable1.frame.size.height, VIEW_WIDTH*2, 1)];
    timeLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.imageContentView addSubview:timeLineView];
    
    
    self.imageContentView.frame = CGRectMake(self.imageContentView.frame.origin.x, self.imageContentView.frame.origin.y, self.imageContentView.frame.size.width, timeLineView.frame.origin.y+timeLineView.frame.size.height);
    
    if (timeLineView.frame.origin.y+timeLineView.frame.size.height>self.mainScrollView.frame.size.height+20) {
        
         [self.mainScrollView setContentSize: CGSizeMake(VIEW_WIDTH, self.imageContentView.frame.origin.y+self.imageContentView.frame.size.height)];
    }
    else
    {
        [self.mainScrollView setContentSize: CGSizeMake(VIEW_WIDTH, self.mainScrollView.frame.size.height+20)];
    }
   
    
    
    
    
}
- (void)getCurrentLocation
{
    self.myLocation = [[CLLocationManager alloc]init];
    self.myLocation.delegate = self;
    if ([self.myLocation respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.myLocation requestWhenInUseAuthorization];
    }
    self.myLocation.desiredAccuracy = kCLLocationAccuracyBest;
    self.myLocation.distanceFilter = kCLDistanceFilterNone;
    [self.myLocation startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currlocation = [locations objectAtIndex:0];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:currlocation.coordinate.latitude longitude:currlocation.coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray * placemarks, NSError * error)
     {
         
         CLLocation *newLocation = locations[0];
         oldCoordinate = newLocation.coordinate;
         NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
         
         if (placemarks.count > 0) {
             CLPlacemark *plmark = [placemarks objectAtIndex:0];
             self.detailAddress = [NSString stringWithFormat:@"%@%@%@%@ ",plmark.administrativeArea,plmark.locality,plmark.subLocality,plmark.thoroughfare];
             self.addressTextView.text = self.detailAddress;
         }
     }];
    [manager stopUpdatingLocation];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
        [self.jingGuoTextView resignFirstResponder];
        
    
}
-(void)deleteImageButtonClick:(id)sender
{
    
    UIButton * button = (UIButton *)sender;
    [self.imageArray removeObjectAtIndex:button.tag];
    [self initImageContentView];
}
-(void)addMediaButtonClick
{
    [self.jingGuoTextView resignFirstResponder];
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showInView:self.view.window];
    
    
}
#pragma UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0)
    {
        //拍摄照片或者视频
        [self addMeidFromCamera];
        
        
    }
    else if (buttonIndex == 1)
    {
        //从手机选取视频或者照片
        [self addMediaFromLibaray];
    }
    
}
- (void)addMeidFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController = [[UIImagePickerController alloc] init] ;
        self.imagePickerController.delegate = self;
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.allowsEditing = YES;
        
        [self presentModalViewController:self.imagePickerController animated:YES];
    } else {
        [Common showAlert:nil message:@"您的设备不支持此种方式上传照片"];
    }
    
}
-(void)addMediaFromLibaray
{
    TZImagePickerController *imagePickController;
    
    NSInteger count = 0;
    count = maxImageSelected - self.imageArray.count;
    imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
    //是否 在相册中显示拍照按钮
    imagePickController.allowTakePicture = NO;
    //是否可以选择显示原图
    imagePickController.allowPickingOriginalPhoto = NO;
    
    //是否 在相册中可以选择照片
    imagePickController.allowPickingImage= YES;
    //是否 在相册中可以选择视频
    imagePickController.allowPickingVideo = NO;
    
    
    [self.navigationController presentViewController:imagePickController animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   //判断是否设置头像
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    [self dismissModalViewControllerAnimated:YES];
    
    [self.imageArray addObject:image];
    [self initImageContentView];
}

#pragma mark - TZImagePickerController Delegate
//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    
    [[LLImagePickerManager manager] getMediaInfoFromAsset:[assets objectAtIndex:0] completion:^(NSString *name, id pathData) {
        
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
        model.name = name;
        model.uploadType = pathData;
        model.image = photos[0];
        for (UIImage * image in photos) {
            
            [self.imageArray addObject:image];
        }
        [self initImageContentView];
    }];
    
    
}

-(void)tiJiaoButtonClick
{
    if (self.jingGuoTextView.text.length==0) {
        
        [Common showToastView:@"请填写爆料内容" view:self.view];
        return;
    }
    if (self.detailAddress==nil) {
        
        [Common showToastView:@"无法获取到当前位置信息,不能进行提交" view:self.view];
        return;
    }
    
    [self showNewLoadingView:@"正在提交..." view:nil];
    [self.jingGuoTextView resignFirstResponder];
    
    if (self.imageArray.count>0) {
        
        [self uploadImage];
    }
    else
    {
        [self.cloudClient baoLiaoShangBao:@"tipOffInfo!add.do"
                              tipoffplace:self.addressTextView.text
                                  content:self.jingGuoTextView.text
                                      lot:[NSString stringWithFormat:@"%f",oldCoordinate.longitude]
                                      lat:[NSString stringWithFormat:@"%f",oldCoordinate.latitude]
                                 photoids:@""
                                 delegate:self
                                 selector:@selector(tiJiaoSuccess:)
                            errorSelector:@selector(tiJiaoError:)];
    }
}
-(void)uploadImage
{
    if (imageIndex<self.imageArray.count) {
        
        UIImage * image = [self .imageArray objectAtIndex:imageIndex];
        NSData* data = UIImageJPEGRepresentation(image, 0.85f);
        [self.cloudClient BaoLiaoUploadImage:@"tipOffInfo!addPhoto.do"
                                        file:data
                                    delegate:self
                                    selector:@selector(uploadImageSuccess:)
                               errorSelector:@selector(uploadImageError:)];
    }
    else
    {
        
        [self.cloudClient baoLiaoShangBao:@"tipOffInfo!add.do"
                              tipoffplace:self.addressTextView.text
                                  content:self.jingGuoTextView.text
                                      lot:[NSString stringWithFormat:@"%f",oldCoordinate.longitude]
                                      lat:[NSString stringWithFormat:@"%f",oldCoordinate.latitude]
                                 photoids:self.imageIdStr
                                 delegate:self
                                 selector:@selector(tiJiaoSuccess:)
                            errorSelector:@selector(tiJiaoError:)];
    }
    
}
-(void)uploadImageSuccess:(NSDictionary *)info
{
    if (imageIndex ==0) {
        
        self.imageIdStr = [info objectForKey:@"photoid"];
    }
    else
    {
        self.imageIdStr = [self.imageIdStr stringByAppendingString:[NSString stringWithFormat:@",%@",[info objectForKey:@"photoid"]]];
    }
    imageIndex++;
    [self uploadImage];
}
-(void)uploadImageError:(NSDictionary *)info
{
    imageIndex++;
    [self uploadImage];
}
-(void)tiJiaoSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:@"爆料成功" view:self.view];
    [self performSelector:@selector(tiJiaoSuccessPop) withObject:nil afterDelay:0.5];
    
}
-(void)tiJiaoSuccessPop
{
    [self.delegate baoLiaoShangBaoSuccess];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tiJiaoError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)jieGuoBtnHandler
{
    [self startBtnHandler];
}
//////////////////////////////////讯飞录音
- (void)startBtnHandler{
    
    NSLog(@"%s[IN]",__func__);
    
    self.voiceHeightImageView.hidden = NO;
    self.voiceHeightBottomView.hidden = NO;
    
    
    if ([IATConfig sharedInstance].haveView == NO) {
        
        [self.jingGuoTextView resignFirstResponder];
        
        if(_iFlySpeechRecognizer == nil)
        {
            [self initRecognizer];
        }
        
        [_iFlySpeechRecognizer cancel];
        
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];
        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
            
        }
        else
        {
            [Common showToastView:NSLocalizedString(@"M_ISR_Fail", nil) view:self.view];
        }
    }
    
}

/**
 stop recording
 **/
-(void)stopBtnHandler{
    
    NSLog(@"%s",__func__);
    
    
    [_pcmRecorder stop];
    [_iFlySpeechRecognizer stopListening];
    [self.jingGuoTextView resignFirstResponder];
}
- (void) onVolumeChanged: (int)volume
{
    if (volume<=5)
    {
        self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_1"];
    }
    if (volume>5&&volume<10) {
        
        self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_2"];
    }
    else if(volume>=10&&volume<18)
    {
        self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_3"];
    }
    else if(volume>=18&&volume<25)
    {
        self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_4"];
    }
    else
    {
        self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_4"];
    }
}
-(void)refreshUIWithVoicePower : (NSInteger)voicePower
{
    
}
-(void)initRecognizer
{
    NSLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO) {
        
        //recognition singleton without view
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        }
        
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //set recognition domain
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
        _iFlySpeechRecognizer.delegate = self;
        
        if (_iFlySpeechRecognizer != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            
            //set timeout of recording
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //set VAD timeout of end of speech(EOS)
            [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //set VAD timeout of beginning of speech(BOS)
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //set network timeout
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //set sample rate, 16K as a recommended option
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            //set language
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //set accent
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            
            //set whether or not to show punctuation in recognition results
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
        
        //Initialize recorder
        if (_pcmRecorder == nil)
        {
            _pcmRecorder = [IFlyPcmRecorder sharedInstance];
        }
        
        _pcmRecorder.delegate = self;
        
        [_pcmRecorder setSample:[IATConfig sharedInstance].sampleRate];
        
        [_pcmRecorder setSaveAudioPath:nil];    //not save the audio file
    }
    
    
    if([[IATConfig sharedInstance].language isEqualToString:@"en_us"]){
        if([IATConfig sharedInstance].isTranslate){
            [self translation:NO];
        }
    }
    else{
        if([IATConfig sharedInstance].isTranslate){
            [self translation:YES];
        }
    }
    
}
-(void)translation:(BOOL) langIsZh
{
    
    if ([IATConfig sharedInstance].haveView == NO) {
        [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_SCH]];
        
        if(langIsZh){
            [_iFlySpeechRecognizer setParameter:@"cn" forKey:@"orilang"];
            [_iFlySpeechRecognizer setParameter:@"en" forKey:@"translang"];
        }
        else{
            [_iFlySpeechRecognizer setParameter:@"en" forKey:@"orilang"];
            [_iFlySpeechRecognizer setParameter:@"cn" forKey:@"translang"];
        }
        
        [_iFlySpeechRecognizer setParameter:@"translate" forKey:@"addcap"];
        
        [_iFlySpeechRecognizer setParameter:@"its" forKey:@"trssrc"];
    }
    
    
}
- (void)onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    [self stopBtnHandler];
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    
    NSString * resultFromJson =  nil;
    
    if([IATConfig sharedInstance].isTranslate){
        
        NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //The result type must be utf8, otherwise an unknown error will happen.
                                    [resultString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if(resultDic != nil){
            NSDictionary *trans_result = [resultDic objectForKey:@"trans_result"];
            
            if([[IATConfig sharedInstance].language isEqualToString:@"en_us"]){
                NSString *dst = [trans_result objectForKey:@"dst"];
                NSLog(@"dst=%@",dst);
                resultFromJson = [NSString stringWithFormat:@"%@\ndst:%@",resultString,dst];
            }
            else{
                NSString *src = [trans_result objectForKey:@"src"];
                NSLog(@"src=%@",src);
                resultFromJson = [NSString stringWithFormat:@"%@\nsrc:%@",resultString,src];
            }
        }
    }
    else{
        resultFromJson = [ISRDataHelper stringFromJson:resultString];
    }
    
        self.jingGuoTextView.text = [NSString stringWithFormat:@"%@%@", self.jingGuoTextView.text,resultFromJson];
    
    
    
    
    if (isLast){
    }
    self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_1"];
    self.voiceHeightImageView.hidden = YES;
    self.voiceHeightBottomView.hidden = YES;
    
    NSLog(@"resultFromJson=%@",resultFromJson);
    NSLog(@"isLast=%d,_textView.text=%@",isLast,self.jingGuoTextView.text);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
