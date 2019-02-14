//
//  RegisterViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/8/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"注册";
    self.titleLale.textColor = [UIColor whiteColor];
    
    
    self.cloudClient = [CloudClient getInstance];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.mainScrollView addGestureRecognizer:tap];
    
    
    UILabel * telTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, 0, 80*BILI, 50*BILI)];
    telTipLable.textColor = [UIColor blackColor];
    telTipLable.alpha = 0.6;
    telTipLable.font = [UIFont systemFontOfSize:15*BILI];
    telTipLable.text = @"手机号码:";
    telTipLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:telTipLable];
    
    self.telTextField = [[UITextField alloc] initWithFrame:CGRectMake(telTipLable.frame.origin.x+telTipLable.frame.size.width+0*BILI, 0, VIEW_WIDTH-(telTipLable.frame.origin.x+telTipLable.frame.size.width+15*BILI), 50*BILI)];
    self.telTextField.font = [UIFont systemFontOfSize:18*BILI];
    self.telTextField.textColor = [UIColor blackColor];
    self.telTextField.alpha = 0.6;
    self.telTextField.tag = 11;
    self.telTextField.delegate = self;
    self.telTextField.returnKeyType = UIReturnKeyNext;
    [self.mainScrollView addSubview:self.telTextField];
    
    [self.telTextField becomeFirstResponder];
    
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, telTipLable.frame.origin.y+telTipLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
    lineView1.backgroundColor = [UIColor blackColor];
    lineView1.alpha = 0.1;
    [self.mainScrollView addSubview:lineView1];
    
    
    UILabel * nameLbale = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, lineView1.frame.origin.y+lineView1.frame.size.height, 80*BILI, 50*BILI)];
    nameLbale.textColor = [UIColor blackColor];
    nameLbale.alpha = 0.6;
    nameLbale.font = [UIFont systemFontOfSize:15*BILI];
    nameLbale.text = @"真实姓名:";
    [self.mainScrollView addSubview:nameLbale];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(telTipLable.frame.origin.x+telTipLable.frame.size.width+0*BILI, lineView1.frame.origin.y+lineView1.frame.size.height, VIEW_WIDTH-(telTipLable.frame.origin.x+telTipLable.frame.size.width+15*BILI), 50*BILI)];
    self.nameTextField.font = [UIFont systemFontOfSize:18*BILI];
    self.nameTextField.textColor = [UIColor blackColor];
    self.nameTextField.alpha = 0.6;
    self.nameTextField.tag = 2;
    self.nameTextField.delegate = self;
    self.nameTextField.returnKeyType = UIReturnKeyNext;
    [self.mainScrollView addSubview:self.nameTextField];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, nameLbale.frame.origin.y+nameLbale.frame.size.height, VIEW_WIDTH, 1*BILI)];
    lineView2.backgroundColor = [UIColor blackColor];
    lineView2.alpha = 0.1;
    [self.mainScrollView addSubview:lineView2];
    
    UILabel * checkNumberipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, lineView2.frame.origin.y+lineView2.frame.size.height, 105*BILI, 50*BILI)];
    checkNumberipLable.textColor = [UIColor blackColor];
    checkNumberipLable.alpha = 0.6;
    checkNumberipLable.font = [UIFont systemFontOfSize:15*BILI];
    checkNumberipLable.text = @"验 证 码:";
    [self.mainScrollView addSubview:checkNumberipLable];
    
    self.checkNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(telTipLable.frame.origin.x+telTipLable.frame.size.width+0*BILI, lineView2.frame.origin.y+lineView2.frame.size.height, VIEW_WIDTH-(telTipLable.frame.origin.x+telTipLable.frame.size.width+0*BILI+100*BILI), 50*BILI)];
    self.checkNumberTextField.font = [UIFont systemFontOfSize:18*BILI];
    self.checkNumberTextField.textColor = [UIColor blackColor];
    self.checkNumberTextField.alpha = 0.6;
    self.checkNumberTextField.returnKeyType = UIReturnKeyNext;
    self.checkNumberTextField.tag = 3;
    self.checkNumberTextField.delegate = self;
    [self.mainScrollView addSubview:self.checkNumberTextField];
    
    self.getCheckNumberButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-90*BILI, checkNumberipLable.frame.origin.y, 75*BILI, 50*BILI)];
    self.getCheckNumberButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.getCheckNumberButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCheckNumberButton addTarget:self action:@selector(getCheckNumberButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.getCheckNumberButton setTitleColor:UIColorFromRGB(0x5077AA) forState:UIControlStateNormal];
    self.getCheckNumberButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:self.getCheckNumberButton];
    
    UIView * checkLineineView = [[UIView alloc] initWithFrame:CGRectMake(0, checkNumberipLable.frame.origin.y+checkNumberipLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
    checkLineineView.backgroundColor = [UIColor blackColor];
    checkLineineView.alpha = 0.1;
    [self.mainScrollView addSubview:checkLineineView];
    
    UILabel * passWorldTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, checkLineineView.frame.origin.y+checkLineineView.frame.size.height, 80*BILI, 50*BILI)];
    passWorldTipLable.textColor = [UIColor blackColor];
    passWorldTipLable.alpha = 0.6;
    passWorldTipLable.font = [UIFont systemFontOfSize:15*BILI];
    passWorldTipLable.text = @"设置密码:";
    [self.mainScrollView addSubview:passWorldTipLable];
    
    self.passWorldRextField = [[UITextField alloc] initWithFrame:CGRectMake(passWorldTipLable.frame.origin.x+passWorldTipLable.frame.size.width+0*BILI, checkLineineView.frame.origin.y+checkLineineView.frame.size.height, VIEW_WIDTH-(passWorldTipLable.frame.origin.x+passWorldTipLable.frame.size.width+15*BILI), 50*BILI)];
    self.passWorldRextField.font = [UIFont systemFontOfSize:18*BILI];
    self.passWorldRextField.textColor = [UIColor blackColor];
    self.passWorldRextField.alpha = 0.6;
    self.passWorldRextField.secureTextEntry = YES;
    self.passWorldRextField.tag = 12;
    self.passWorldRextField.delegate = self;
    self.passWorldRextField.returnKeyType = UIReturnKeyNext;
    [self.mainScrollView addSubview:self.passWorldRextField];
    
    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, passWorldTipLable.frame.origin.y+passWorldTipLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
    lineView3.backgroundColor = [UIColor blackColor];
    lineView3.alpha = 0.1;
    [self.mainScrollView addSubview:lineView3];
    
    UILabel * passWorldAgainTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, lineView3.frame.origin.y+lineView3.frame.size.height, 80*BILI, 50*BILI)];
    passWorldAgainTipLable.textColor = [UIColor blackColor];
    passWorldAgainTipLable.alpha = 0.6;
    passWorldAgainTipLable.font = [UIFont systemFontOfSize:15*BILI];
    passWorldAgainTipLable.text = @"重复密码:";
    [self.mainScrollView addSubview:passWorldAgainTipLable];
    
    self.passWorldAgainTextField = [[UITextField alloc] initWithFrame:CGRectMake(passWorldTipLable.frame.origin.x+passWorldTipLable.frame.size.width+0*BILI, lineView3.frame.origin.y+lineView3.frame.size.height, VIEW_WIDTH-(passWorldAgainTipLable.frame.origin.x+passWorldAgainTipLable.frame.size.width+15*BILI), 50*BILI)];
    self.passWorldAgainTextField.font = [UIFont systemFontOfSize:18*BILI];
    self.passWorldAgainTextField.textColor = [UIColor blackColor];
    self.passWorldAgainTextField.alpha = 0.6;
    self.passWorldAgainTextField.secureTextEntry = YES;
    self.passWorldAgainTextField.tag= 13;
    self.passWorldAgainTextField.delegate = self;
    self.passWorldAgainTextField.returnKeyType = UIReturnKeyNext;
    [self.mainScrollView addSubview:self.passWorldAgainTextField];
    
    UIView * lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, passWorldAgainTipLable.frame.origin.y+passWorldAgainTipLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
    lineView4.backgroundColor = [UIColor blackColor];
    lineView4.alpha = 0.1;
    [self.mainScrollView addSubview:lineView4];
    
    
    UILabel * fenFenLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, lineView4.frame.origin.y+lineView4.frame.size.height, 80*BILI, 50*BILI)];
    fenFenLable.textColor = [UIColor blackColor];
    fenFenLable.alpha = 0.6;
    fenFenLable.font = [UIFont systemFontOfSize:15*BILI];
    fenFenLable.text = @"身份证号:";
    [self.mainScrollView addSubview:fenFenLable];
    
    self.shenFenTextField = [[UITextField alloc] initWithFrame:CGRectMake(passWorldTipLable.frame.origin.x+passWorldTipLable.frame.size.width+0*BILI, lineView4.frame.origin.y+lineView4.frame.size.height, VIEW_WIDTH-(fenFenLable.frame.origin.x+fenFenLable.frame.size.width+15*BILI), 50*BILI)];
    self.shenFenTextField.font = [UIFont systemFontOfSize:18*BILI];
    self.shenFenTextField.textColor = [UIColor blackColor];
    self.shenFenTextField.alpha = 0.6;
    self.shenFenTextField.tag = 18;
    self.shenFenTextField.delegate = self;
    self.shenFenTextField.returnKeyType = UIReturnKeyNext;
    [self.mainScrollView addSubview:self.shenFenTextField];
    
    UIView * lineView5 = [[UIView alloc] initWithFrame:CGRectMake(0, fenFenLable.frame.origin.y+fenFenLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
    lineView5.backgroundColor = [UIColor blackColor];
    lineView5.alpha = 0.1;
    [self.mainScrollView addSubview:lineView5];
    
    
    UILabel * sexLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, lineView5.frame.origin.y+lineView5.frame.size.height, 105*BILI, 50*BILI)];
    sexLable.textColor = [UIColor blackColor];
    sexLable.alpha = 0.6;
    sexLable.font = [UIFont systemFontOfSize:15*BILI];
    sexLable.text = @"性      别:";
    [self.mainScrollView addSubview:sexLable];
    
    UIView * lineView6 = [[UIView alloc] initWithFrame:CGRectMake(0, sexLable.frame.origin.y+sexLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
    lineView6.backgroundColor = [UIColor blackColor];
    lineView6.alpha = 0.1;
    [self.mainScrollView addSubview:lineView6];
    
    UIButton * manButton = [[UIButton alloc] initWithFrame:CGRectMake(sexLable.frame.origin.x+sexLable.frame.size.width+20*BILI, sexLable.frame.origin.y, 100*BILI, 50*BILI)];
    [manButton addTarget:self action:@selector(manButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:manButton];
    
    self.manImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 15*BILI, 20*BILI, 20*BILI)];
    self.manImageView.image = [UIImage imageNamed:@"unselect"];
    [manButton addSubview:self.manImageView];
    
    UILabel * manLanle = [[UILabel alloc] initWithFrame:CGRectMake(self.manImageView.frame.origin.x+self.manImageView.frame.size.width+5*BILI, 0, 40, 50*BILI)];
    manLanle.font = [UIFont systemFontOfSize:20*BILI];
    manLanle.textColor = [UIColor blackColor];
    manLanle.text = @"男";
    manLanle.alpha = 0.6;
    [manButton addSubview:manLanle];
    
    
    
    UIButton * womanButton = [[UIButton alloc] initWithFrame:CGRectMake(manButton.frame.origin.x+manButton.frame.size.width, sexLable.frame.origin.y, 100*BILI, 50*BILI)];
    [womanButton addTarget:self action:@selector(womanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:womanButton];
    
    self.womanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 15*BILI, 20*BILI, 20*BILI)];
    self.womanImageView.image = [UIImage imageNamed:@"unselect"];
    [womanButton addSubview:self.womanImageView];
    
    UILabel * womanLanle = [[UILabel alloc] initWithFrame:CGRectMake(self.manImageView.frame.origin.x+self.manImageView.frame.size.width+5*BILI, 0, 40, 50*BILI)];
    womanLanle.font = [UIFont systemFontOfSize:20*BILI];
    womanLanle.textColor = [UIColor blackColor];
    womanLanle.text = @"女";
    womanLanle.alpha = 0.6;
    [womanButton addSubview:womanLanle];

    
    
    
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI,lineView6.frame.origin.y+35*BILI/2, VIEW_WIDTH-30*BILI, 32*BILI)];
    tipLable.textColor = [UIColor blackColor];
    tipLable.font = [UIFont systemFontOfSize:15*BILI];
    tipLable.alpha = 0.6;
    tipLable.adjustsFontSizeToFitWidth = YES;
    tipLable.text = @"温馨提示: 注册成功,此账号和密码将作为您的登录账号和密码,请妥善保存";
    //[self.view addSubview:tipLable];
    
    UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(13*BILI, tipLable.frame.origin.y+tipLable.frame.size.height+35*BILI/2, VIEW_WIDTH-26*BILI, 45*BILI)];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.layer.cornerRadius = 45*BILI/2;
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    registerButton.backgroundColor = UIColorFromRGB(0x5077AA);
    [self.mainScrollView addSubview:registerButton];
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, registerButton.frame.origin.y+registerButton.frame.size.height+200*BILI)];
    
    [self initLoactionManger];
    
}
-(void)initLoactionManger
{
    self.locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;    //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        self.location = location;
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            self.detailAddress = [NSString stringWithFormat:@"%@%@%@%@%@",regeocode.province,regeocode.city,regeocode.street,regeocode.number,regeocode.POIName];
        }
    }];
}
-(void)viewTap
{
    [self.telTextField resignFirstResponder];
    [self.checkNumberTextField resignFirstResponder];
    [self.passWorldRextField resignFirstResponder];
    [self.passWorldAgainTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.shenFenTextField resignFirstResponder];
}
-(void)manButtonClick
{
    self.manImageView.image = [UIImage imageNamed:@"selected"];
    self.womanImageView.image = [UIImage imageNamed:@"unselect"];
    self.manOrWoman = @"1";
}
-(void)womanButtonClick
{
    self.womanImageView.image = [UIImage imageNamed:@"selected"];
    self.manImageView.image = [UIImage imageNamed:@"unselect"];
    self.manOrWoman = @"2";
}
-(void)getCheckNumberButtonClick
{
    [self viewTap];
    if (self.telTextField.text.length==11)
    {
        [self showNewLoadingView:@"验证码获取中..." view:self.view];
        [self.cloudClient getCheckNumber:@"loginUser!sendSmsCode.do"
                                  mobile:self.telTextField.text
                                delegate:self
                                selector:@selector(getCheckNumberSuccess:)
                           errorSelector:@selector(getError:)];
        
    }
    else
    {
        [Common showToastView:@"请输入正确的手机号码" view:self.view];
    }
    
    
}
-(void)getCheckNumberSuccess:(NSDictionary *)info
{
    self.getCheckNumberButton.enabled = NO;
    stepSeconds = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daoShu) userInfo:nil repeats:YES];
    [self hideNewLoadingView];
    [Common showToastView:@"验证码已发送,请注意查收" view:self.view];
}
-(void)getError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}

-(void)daoShu
{
    stepSeconds --;
    [self.getCheckNumberButton setTitleColor:UIColorFromRGB(0xcdcdcd) forState:UIControlStateNormal];
    [self.getCheckNumberButton setTitle:[NSString stringWithFormat:@"%d秒",stepSeconds] forState:UIControlStateNormal];
    if(stepSeconds == 0)
    {
        [self.getCheckNumberButton setTitleColor:UIColorFromRGB(0x5077AA) forState:UIControlStateNormal];
        [self.getCheckNumberButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getCheckNumberButton.enabled = YES;
        [self.timer invalidate];
        return;
    }
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag==11) {
        
        [self.nameTextField becomeFirstResponder];
    }
    if (textField.tag==2) {
        
        [self.checkNumberTextField becomeFirstResponder];
    }
    if (textField.tag==3) {
        
        [self.passWorldRextField becomeFirstResponder];
    }
    if (textField.tag==12) {
        
        [self.passWorldAgainTextField becomeFirstResponder];
    }
    if (textField.tag==13) {
        
        [self.shenFenTextField becomeFirstResponder];
    }
    NSLog(@"点击了搜索");
    
    return YES;
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==11) {
        
        if (textField.text.length>=11 && ![@"" isEqualToString:string]) {
            
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    if (textField.tag==12||textField.tag==13) {
        
        if (textField.text.length>=12 && ![@"" isEqualToString:string]) {
            
            return NO;
        }
        else
        {
            return YES;
        }
    }
    if (textField.tag==18) {
        
        if (textField.text.length>=18 && ![@"" isEqualToString:string]) {
            
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return YES;
}
-(void)registerButtonClick
{
    if (self.telTextField.text.length!=11) {
        
        [Common showToastView:@"请输入正确的手机号码" view:self.view];
        return;
    }
    if ([Common isEmpty:self.checkNumberTextField.text]) {
        
        [Common showToastView:@"验证码不能为空" view:self.view];
        return;
    }
    if(self.shenFenTextField.text.length!=18)
    {
        [Common showToastView:@"请输入正确的身份证号码" view:self.view];
        return;
    }
    if (self.passWorldRextField.text.length<6||self.passWorldRextField.text.length>12) {
        
        [Common showToastView:@"密码6-12位" view:self.view];
        return;
    }
    if (![self.passWorldRextField.text isEqualToString:self.passWorldAgainTextField.text]) {
        
        [Common showToastView:@"两次输入的密码不一致" view:self.view];
        return;
    }
    if(!self.manOrWoman)
    {
        [Common showToastView:@"请选择性别" view:self.view];
        return;
    }
    [self viewTap];
    [self showNewLoadingView:@"注册中..." view:self.view];
    [self.cloudClient registerApi:@"loginUser!regInfo.do"
                           mobile:self.telTextField.text
                         realname:self.nameTextField.text
                              sex:self.manOrWoman
                           idcard:self.shenFenTextField.text
                          address:[Common getobjectForKey:self.detailAddress]
                         smstoken:self.checkNumberTextField.text
                           newpsw:self.passWorldRextField.text
                            delegate:self
                            selector:@selector(registerSuccess:)
                       errorSelector:@selector(getError:)];
}
-(void)registerSuccess:(NSDictionary *)info
{
    [Common showToastView:@"注册成功,请返回登录" view:self.view];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.timer invalidate];
    self.timer = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
