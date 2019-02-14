//
//  XiaDaRenWuViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XiaDaRenWuViewController.h"

@interface XiaDaRenWuViewController ()

@end

@implementation XiaDaRenWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"下达任务";
    self.titleLale.textColor = [UIColor whiteColor];
    
    self.cloudClient = [CloudClient getInstance];
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI, 0, 50*BILI, self.navView.frame.size.height)];
    [rightButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [self.navView addSubview:rightButton];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.delegate = self;
    self.mainScrollView.tag = 100;
    [self.view addSubview:self.mainScrollView];
    
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
    
    UILabel * wangGeYuanLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, 75*BILI, 50*BILI)];
    wangGeYuanLable.text = @"网格员:";
    wangGeYuanLable.textColor = UIColorFromRGB(0x787878);
    wangGeYuanLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.mainScrollView addSubview:wangGeYuanLable];
    
    self.wangGeYuanButton = [[UIButton alloc] initWithFrame:CGRectMake(wangGeYuanLable.frame.origin.x+wangGeYuanLable.frame.size.width, wangGeYuanLable.frame.origin.y,  VIEW_WIDTH-(wangGeYuanLable.frame.origin.x+wangGeYuanLable.frame.size.width)-13*BILI,50*BILI)];
    [self.wangGeYuanButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    self.wangGeYuanButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.wangGeYuanButton addTarget:self action:@selector(wangGeYuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.wangGeYuanButton];
    
    UIView * wangGeYuanLineView = [[UIView alloc] initWithFrame:CGRectMake(0, wangGeYuanLable.frame.origin.y+wangGeYuanLable.frame.size.height, VIEW_WIDTH, 1)];
    wangGeYuanLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:wangGeYuanLineView];
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, wangGeYuanLineView.frame.origin.y+wangGeYuanLineView.frame.size.height, 75*BILI, 50*BILI)];
    timeLable.text = @"完成时限:";
    timeLable.textColor = UIColorFromRGB(0x787878);
    timeLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.mainScrollView addSubview:timeLable];
    
    self.timeButton = [[UIButton alloc] initWithFrame:CGRectMake(timeLable.frame.origin.x+timeLable.frame.size.width, timeLable.frame.origin.y,  VIEW_WIDTH-(timeLable.frame.origin.x+timeLable.frame.size.width)-13*BILI,50*BILI)];
    [self.timeButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    self.timeButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.timeButton addTarget:self action:@selector(timeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.timeButton];
    
    NSDictionary * dataDic = [Common getNowDateAndWeek];
    [self.timeButton setTitle: [NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]] forState:UIControlStateNormal];

    
    UIView * timeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, timeLable.frame.origin.y+timeLable.frame.size.height, VIEW_WIDTH, 1)];
    timeLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:timeLineView];

    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, timeLable.frame.origin.y+timeLable.frame.size.height, 75*BILI, 50*BILI)];
    titleLable.text = @"任务标题:";
    titleLable.textColor = UIColorFromRGB(0x787878);
    titleLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.mainScrollView addSubview:titleLable];
    
    
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(titleLable.frame.origin.x+titleLable.frame.size.width, titleLable.frame.origin.y, VIEW_WIDTH-(titleLable.frame.origin.x+titleLable.frame.size.width)-13*BILI, 50*BILI)];
    self.titleTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.titleTextField.textColor = UIColorFromRGB(0x787878);
    self.titleTextField.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:self.titleTextField];
    
    UIView * titleLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height, VIEW_WIDTH, 1)];
    titleLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:titleLineView];
    
    
    
    UILabel * taskNeiRongLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, titleLineView.frame.origin.y+1, 75*BILI, 100*BILI)];
    taskNeiRongLable.textColor =UIColorFromRGB(0x787878);
    taskNeiRongLable.font = [UIFont systemFontOfSize:16*BILI];
    taskNeiRongLable.text = @"任务内容:";
    [self.mainScrollView addSubview:taskNeiRongLable];
    
    self.neiRongTextView = [[UITextView alloc] initWithFrame:CGRectMake(taskNeiRongLable.frame.origin.x+taskNeiRongLable.frame.size.width, taskNeiRongLable.frame.origin.y, VIEW_WIDTH-80*BILI-13*BILI, 100*BILIY)];
    self.neiRongTextView.font = [UIFont systemFontOfSize:16*BILI];
    self.neiRongTextView.zw_placeHolder = @"任务内容...";
    self.neiRongTextView.textColor = UIColorFromRGB(0x787878);
    self.neiRongTextView.tag = 101;
    [self.mainScrollView addSubview:self.neiRongTextView];
    
    UIButton * startButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI-13*BILI, self.neiRongTextView.frame.origin.y+self.neiRongTextView.frame.size.height+10*BILIY, 50*BILI, 50*BILI)];
    [startButton addTarget:self action:@selector(startBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIImageView * huaTongImageView = [[UIImageView alloc] initWithFrame:CGRectMake((50-21/1.5)*BILI/2, (50-32/1.5)*BILI/2, 21*BILI/1.5, 32*BILI/1.5)];
    huaTongImageView.image = [UIImage imageNamed:@"huatong_gray"];
    [startButton addSubview:huaTongImageView];
    
    UIView * neiRongLineView = [[UIView alloc] initWithFrame:CGRectMake(0, startButton.frame.origin.y+startButton.frame.size.height+5*BILI, VIEW_WIDTH, 1)];
    neiRongLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:neiRongLineView];
    
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainScrollView.frame.size.height+10)];
    
    [self initPickView];
    
    
    
}
-(void)initPickView
{
    self.pickRootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT*5)];
    self.pickRootView.backgroundColor = [UIColor blackColor];
    self.pickRootView.alpha = 0.5;
    [self.view addSubview:self.pickRootView];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickRootViewTap)];
    [self.pickRootView addGestureRecognizer:tapGesture];
    
    self.datePickView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-162, VIEW_WIDTH, 162)];
    self.datePickView.datePickerMode=UIDatePickerModeDate;
    [self.view addSubview:self.datePickView];
    self.datePickView.maximumDate = [NSDate date];
    self.datePickView.backgroundColor = [UIColor whiteColor];
    [self.datePickView addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    self.datePickView.hidden = YES;
    self.pickRootView.hidden = YES;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *maxDate = [fmt dateFromString:@"2030-1-1"];
    //设置日期最大及最小值
    self.datePickView.maximumDate = maxDate;
    
}
#pragma mark - 实现oneDatePicker的监听方法
-(void)oneDatePickerValueChanged:(UIDatePicker *) sender
{
    NSDate *select = [sender date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString * selectData = [selectDateFormatter stringFromDate:select];
    self.birthday = [NSString stringWithFormat:@"%ld", (long)[select timeIntervalSince1970]];
    
    [self.timeButton setTitle:selectData forState:UIControlStateNormal];
}
-(void)timeButtonClick
{
    self.datePickView.hidden = NO;
    self.pickRootView.hidden = NO;
    [self.titleTextField resignFirstResponder];
    [self.neiRongTextView resignFirstResponder];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.titleTextField resignFirstResponder];
    [self.neiRongTextView resignFirstResponder];
}
-(void)pickRootViewTap
{
    self.datePickView.hidden = YES;
    self.pickRootView.hidden = YES;
}
-(void)wangGeYuanButtonClick
{
    WangGeYuanListViewController * vc = [[WangGeYuanListViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)selectWanGeYuan:(NSDictionary *)info
{
    self.selectInfo = info;
    [self.wangGeYuanButton setTitle:[info objectForKey:@"realname"] forState:UIControlStateNormal];
}
-(void)tiJiaoButtonClick
{
    if (!self.selectInfo) {
        
        [Common showToastView:@"请选择网格员" view:self.view];
        return;
    }
    if (self.titleTextField.text.length==0) {
        
        [Common showToastView:@"请填写任务标题" view:self.view];
        return;
    }
    if (self.neiRongTextView.text.length==0) {
        
        [Common showToastView:@"请填内容" view:self.view];
        return;
    }
    [self.cloudClient xiaDaTask:@"task!addTask.do"
                       taskname:self.titleTextField.text
                    taskcontent:self.neiRongTextView.text
                      tasklimit:self.timeButton.titleLabel.text
                          zrrid:[self.selectInfo objectForKey:@"memberid"]
                       delegate:self
                       selector:@selector(xiaDaSuccess:)
                  errorSelector:@selector(xiaDaError:)];
    
}
-(void)xiaDaSuccess:(NSDictionary *)info
{
    [self.delegate xiaDaTaskSuccess];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)xiaDaError:(NSDictionary *)info
{
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//////////////////////////////////讯飞录音
- (void)startBtnHandler{
    
    NSLog(@"%s[IN]",__func__);
    
    self.voiceHeightImageView.hidden = NO;
    self.voiceHeightBottomView.hidden = NO;
    
    
    if ([IATConfig sharedInstance].haveView == NO) {
        
        [self.neiRongTextView resignFirstResponder];
        
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
    [self.neiRongTextView resignFirstResponder];
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
    
    //_result =[NSString stringWithFormat:@"%@%@", _textView.text,resultString];
    
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
    
    self.neiRongTextView.text = [NSString stringWithFormat:@"%@%@", self.neiRongTextView.text,resultFromJson];
    
    self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_1"];
    self.voiceHeightImageView.hidden = YES;
    self.voiceHeightBottomView.hidden = YES;
    
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
