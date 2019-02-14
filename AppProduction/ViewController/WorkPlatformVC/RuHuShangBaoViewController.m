//
//  RuHuShangBaoViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RuHuShangBaoViewController.h"


@interface RuHuShangBaoViewController ()

@end

@implementation RuHuShangBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [self initRecognizer];
    self.cloudClient = [CloudClient getInstance];
    
    selectTipIndex = 0;
     self.manYiType = @"01";
    imageIndex = 0;
    
    self.titleLale.text = @"入户上报";
    self.titleLale.textColor = [UIColor whiteColor];
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI, 0, 50*BILI, self.navView.frame.size.height)];
    [rightButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [self.navView addSubview:rightButton];
    
    maxImageSelected = 5;
    self.imageArray = [NSMutableArray array];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(13*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+13*BILI, VIEW_WIDTH-26*BILI, 100*BILIY)];
    self.textView.font = [UIFont systemFontOfSize:16*BILI];
    self.textView.zw_placeHolder = @"描述走访内容...";
    self.textView.textColor = UIColorFromRGB(0x787878);
    [self.view addSubview:self.textView];
    
    [self getCurrentLocation];
    
    UIButton * startButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI-13*BILI, self.textView.frame.origin.y+self.textView.frame.size.height+10*BILIY, 50*BILI, 50*BILI)];
    [startButton addTarget:self action:@selector(startBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIImageView * huaTongImageView = [[UIImageView alloc] initWithFrame:CGRectMake((50-21/1.5)*BILI/2, (50-32/1.5)*BILI/2, 21*BILI/1.5, 32*BILI/1.5)];
    huaTongImageView.image = [UIImage imageNamed:@"huatong_gray"];
    [startButton addSubview:huaTongImageView];
    
    
    self.imageContentView = [[UIView alloc] initWithFrame:CGRectMake(15*BILI, startButton.frame.origin.y+startButton.frame.size.height+5*BILI, VIEW_WIDTH-30*BILI, 30*BILI)];
    self.imageContentView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageContentView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomTap)];
    [self.imageContentView addGestureRecognizer:tap];
    
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
    
    
    [self initImageContentView];
   
}
-(void)tiJiaoButtonClick
{
    if (self.textView.text.length==0) {
        
        [Common showToastView:@"请填写内容" view:self.view];
        return;
    }
    if (self.detailAddress==nil) {
        
        [Common showToastView:@"无法获取到当前位置信息,不能进行提交" view:self.view];
        return;
    }
    
    [self showNewLoadingView:nil view:nil];
    
    if (self.imageArray.count>0) {
        
        [self uploadImage];
    }
    else
    {
        NSDictionary * dataDic = [Common getNowDateAndWeek];
        
        [self.cloudClient ruHuZouFangShangBao:@"patrolVisits!houseVisitAdd.do"
                                     holderid:[self.info objectForKey:@"holderid"]
                                    visitdate:[NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]]
                                 visitcontent:self.textView.text
                                     xgpgcode:self.manYiType
                                          lot:[NSString stringWithFormat:@"%f",oldCoordinate.longitude]
                                          lat:[NSString stringWithFormat:@"%f",oldCoordinate.latitude]
                                      address:self.detailAddress
                                       imgids:@""
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
        [self.cloudClient imageUpload:@"eventInfo!addImg.do"
                                 file:data
                           targettype:@"4"
                             delegate:self
                             selector:@selector(uploadImageSuccess:)
                        errorSelector:@selector(uploadImageError:)];//名
    }
    else
    {
        NSDictionary * dataDic = [Common getNowDateAndWeek];
        
        [self.cloudClient ruHuZouFangShangBao:@"patrolVisits!houseVisitAdd.do"
                                     holderid:[self.info objectForKey:@"holderid"]
                                    visitdate:[NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]]
                                 visitcontent:self.textView.text
                                     xgpgcode:self.manYiType
                                          lot:[NSString stringWithFormat:@"%f",oldCoordinate.longitude]
                                          lat:[NSString stringWithFormat:@"%f",oldCoordinate.latitude]
                                      address:self.detailAddress
                                       imgids:self.imageIdStr
                                     delegate:self
                                     selector:@selector(tiJiaoSuccess:)
                                errorSelector:@selector(tiJiaoError:)];
    }
    
}
-(void)uploadImageSuccess:(NSDictionary *)info
{
    if (imageIndex ==0) {
        
        self.imageIdStr = [info objectForKey:@"imgid"];
    }
    else
    {
        self.imageIdStr = [self.imageIdStr stringByAppendingString:[NSString stringWithFormat:@",%@",[info objectForKey:@"imgid"]]];
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
    [Common showToastView:@"提交成功" view:self.view];
    [self performSelector:@selector(tiJiaoSuccessPop) withObject:nil afterDelay:0.5];
    
}
-(void)tiJiaoSuccessPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tiJiaoError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)bottomTap
{
    [self.textView resignFirstResponder];
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
             self.detailAddress = [NSString stringWithFormat:@"%@%@%@%@%@ ",plmark.administrativeArea,plmark.locality,plmark.subLocality,plmark.thoroughfare,plmark.name];
             self.addressLable.text = self.detailAddress;
         }
     }];
    [manager stopUpdatingLocation];
    
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
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, nowHeight+5*BILI, VIEW_WIDTH, 1)];
    lineView.backgroundColor =UIColorFromRGB(0xE4E4E4);
    [self.imageContentView addSubview:lineView];
   
    UIImageView * locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y+(60-17)*BILI/2, 12*BILI, 17*BILI)];
    locationImageView.image = [UIImage imageNamed:@"location"];
    [self.imageContentView addSubview:locationImageView];
    
    self.addressLable = [[UILabel alloc] initWithFrame:CGRectMake(locationImageView.frame.origin.x+locationImageView.frame.size.width+10, lineView.frame.origin.y, self.imageContentView.frame.size.width-(locationImageView.frame.origin.x+locationImageView.frame.size.width+10), 60*BILI)];
    self.addressLable.font = [UIFont systemFontOfSize:16*BILI];
    self.addressLable.textColor = UIColorFromRGB(0x4A4A4A);
    self.addressLable.numberOfLines = 2;
    self.addressLable.text = self.detailAddress;
    [self.imageContentView addSubview:self.addressLable];
    
    
    
    UIView * addressLineView = [[UIView alloc] initWithFrame:CGRectMake(-15*BILI, self.addressLable.frame.origin.y+self.addressLable.frame.size.height, VIEW_WIDTH*2, 15*BILI)];
    addressLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.imageContentView addSubview:addressLineView];
    
    UIImageView * xiaoRenImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, addressLineView.frame.origin.y+addressLineView.frame.size.height+(50-17)*BILI/2, 17*BILI, 17*BILI)];
    xiaoRenImageView.image = [UIImage imageNamed: @"xiaoren"];
    [self.imageContentView addSubview:xiaoRenImageView];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(xiaoRenImageView.frame.origin.x+xiaoRenImageView.frame.size.width+10*BILI, addressLineView.frame.origin.y+addressLineView.frame.size.height, 100, 50*BILI)];
    nameLable.textColor =UIColorFromRGB(0x787878);
    nameLable.font = [UIFont systemFontOfSize:16*BILI];
    nameLable.text = @"姓    名";
    [self.imageContentView addSubview:nameLable];
    
    UILabel * nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLable.frame.origin.y, self.imageContentView.frame.size.width, 50*BILI)];
    nameLable1.textColor =UIColorFromRGB(0x787878);
    nameLable1.font = [UIFont systemFontOfSize:16*BILI];
    nameLable1.text = [self.info objectForKey:@"realname"];
    nameLable1.textAlignment = NSTextAlignmentRight;
    [self.imageContentView addSubview:nameLable1];
    
    UIView * nameLineView = [[UIView alloc] initWithFrame:CGRectMake(-15*BILI, nameLable1.frame.origin.y+nameLable1.frame.size.height, VIEW_WIDTH*2, 1)];
    nameLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.imageContentView addSubview:nameLineView];
    
    UIImageView *riQiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nameLineView.frame.origin.y+nameLineView.frame.size.height+(50-17)*BILI/2, 17*BILI, 17*BILI)];
    riQiImageView.image = [UIImage imageNamed: @"naozhong"];
    [self.imageContentView addSubview:riQiImageView];
    
    UILabel * riQiLable = [[UILabel alloc] initWithFrame:CGRectMake(xiaoRenImageView.frame.origin.x+xiaoRenImageView.frame.size.width+10*BILI, nameLineView.frame.origin.y+nameLineView.frame.size.height, 100, 50*BILI)];
    riQiLable.textColor =UIColorFromRGB(0x787878);
    riQiLable.font = [UIFont systemFontOfSize:16*BILI];
    riQiLable.text = @"走访日期";
    [self.imageContentView addSubview:riQiLable];
    
    NSDictionary * dataDic = [Common getNowDateAndWeek];
    UILabel * riQiLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, riQiLable.frame.origin.y, self.imageContentView.frame.size.width, 50*BILI)];
    riQiLable1.textColor =UIColorFromRGB(0x787878);
    riQiLable1.font = [UIFont systemFontOfSize:16*BILI];
    riQiLable1.text = [NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]];
    riQiLable1.textAlignment = NSTextAlignmentRight;
    [self.imageContentView addSubview:riQiLable1];
    
    UIView * riQiLable1LineView = [[UIView alloc] initWithFrame:CGRectMake(-15*BILI, riQiLable1.frame.origin.y+riQiLable1.frame.size.height, VIEW_WIDTH*2, 1)];
    riQiLable1LineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.imageContentView addSubview:riQiLable1LineView];
    
    UIImageView *pingGuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, riQiLable1LineView.frame.origin.y+riQiLable1LineView.frame.size.height+(50-17)*BILI/2, 17*BILI, 17*BILI)];
    pingGuImageView.image = [UIImage imageNamed: @"naozhong"];
    [self.imageContentView addSubview:pingGuImageView];
    
    UILabel * pingGuLable = [[UILabel alloc] initWithFrame:CGRectMake(xiaoRenImageView.frame.origin.x+xiaoRenImageView.frame.size.width+10*BILI, riQiLable1LineView.frame.origin.y+riQiLable1LineView.frame.size.height, 100, 50*BILI)];
    pingGuLable.textColor =UIColorFromRGB(0x787878);
    pingGuLable.font = [UIFont systemFontOfSize:16*BILI];
    pingGuLable.text = @"效果评估";
    [self.imageContentView addSubview:pingGuLable];
    
    self.tipButtonArray = [NSMutableArray array];
    
    float buttonWidth = (self.imageContentView.frame.size.width-(pingGuLable.frame.origin.x+90*BILI)-30*BILI)/4;
    
    for (int i=0; i<4; i++) {
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake(pingGuLable.frame.origin.x+90*BILI+(buttonWidth+10*BILI)*i, riQiLable1LineView.frame.origin.y+15*BILI, buttonWidth, 20*BILI)];
        tipButton.layer.cornerRadius = 10*BILI;
        [tipButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
        tipButton.layer.borderWidth =1;
        tipButton.layer.borderColor = [UIColorFromRGB(0x787878) CGColor];
        tipButton.tag = i;
        [tipButton addTarget:self action:@selector(tipButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tipButtonArray addObject:tipButton];
        if (i==selectTipIndex) {
            
            tipButton.layer.borderColor = [UIColorFromRGB(0xFE986C) CGColor];
            [tipButton setTitleColor:UIColorFromRGB(0xFE986C) forState:UIControlStateNormal];
        }
        if (i==0) {
            
            [tipButton setTitle:@"好" forState:UIControlStateNormal];
        }else if (i==1)
        {
            [tipButton setTitle:@"较好" forState:UIControlStateNormal];
        }
        else if (i==2)
        {
            [tipButton setTitle:@"一般" forState:UIControlStateNormal];
        }
        else if (i==3)
        {
            [tipButton setTitle:@"差" forState:UIControlStateNormal];
        }
        [self.imageContentView addSubview:tipButton];
        
    }
    
    
    UIView * pingGULable1LineView = [[UIView alloc] initWithFrame:CGRectMake(-15*BILI, pingGuLable.frame.origin.y+pingGuLable.frame.size.height, VIEW_WIDTH*2, 1)];
    pingGULable1LineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.imageContentView addSubview:pingGULable1LineView];

    
    self.imageContentView.frame = CGRectMake(self.imageContentView.frame.origin.x, self.imageContentView.frame.origin.y, self.imageContentView.frame.size.width, pingGULable1LineView.frame.origin.y+pingGULable1LineView.frame.size.height);
    
}
-(void)tipButtonClick:(id)sender
{
    UIButton * selectButton =(UIButton *)sender;

    if (selectButton.tag==0) {
        
        self.manYiType = @"01";
        
    }else if (selectButton.tag==1)
    {
         self.manYiType = @"02";
    }
    else if (selectButton.tag==2)
    {
         self.manYiType = @"03";
    }
    else if (selectButton.tag==3)
    {
         self.manYiType = @"04";
    }
    selectTipIndex = (int)selectButton.tag;
    for (int i=0; i<self.tipButtonArray.count; i++) {
        
        UIButton * button = [self.tipButtonArray objectAtIndex:i];
        [button setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
        button.layer.borderColor = [UIColorFromRGB(0x787878) CGColor];

    }
    selectButton.layer.borderColor = [UIColorFromRGB(0xFE986C) CGColor];
    [selectButton setTitleColor:UIColorFromRGB(0xFE986C) forState:UIControlStateNormal];
}
-(void)deleteImageButtonClick:(id)sender
{
    
    UIButton * button = (UIButton *)sender;
    [self.imageArray removeObjectAtIndex:button.tag];
    [self initImageContentView];
}
-(void)addMediaButtonClick
{
    [self.textView resignFirstResponder];
    
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

//////////////////////////////////讯飞录音
- (void)startBtnHandler{
    
    NSLog(@"%s[IN]",__func__);
    
    self.voiceHeightImageView.hidden = NO;
    self.voiceHeightBottomView.hidden = NO;

    
    if ([IATConfig sharedInstance].haveView == NO) {
        
        [self.textView resignFirstResponder];
        
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
    [self.textView resignFirstResponder];
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
    
    _iFlySpeechRecognizer = nil;
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    _result =[NSString stringWithFormat:@"%@%@", _textView.text,resultString];
    
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
    
    _textView.text = [NSString stringWithFormat:@"%@%@", _textView.text,resultFromJson];
    
    if (isLast){
        NSLog(@"ISR Results(json)：%@",  self.result);
    }
    self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_1"];
    self.voiceHeightImageView.hidden = YES;
    self.voiceHeightBottomView.hidden = YES;

    NSLog(@"_result=%@",_result);
    NSLog(@"resultFromJson=%@",resultFromJson);
    NSLog(@"isLast=%d,_textView.text=%@",isLast,_textView.text);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
