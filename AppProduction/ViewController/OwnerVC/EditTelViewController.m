//
//  EditTelViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EditTelViewController.h"

@interface EditTelViewController ()

@end

@implementation EditTelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cloudClient = [CloudClient getInstance];
    self.titleLale.text = @"手机号";
    self.titleLale.textColor = [UIColor whiteColor];
    
    [self setTabBarHidden];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [bottomView addGestureRecognizer:tap];
    
    UIButton * oldPassWorldButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI, VIEW_WIDTH, 45*BILI)];
    oldPassWorldButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:oldPassWorldButton];
    
    
    UILabel * settingLable = [[UILabel alloc] initWithFrame:CGRectMake(35*BILI/2, 0, 15*BILI*4.5, 45*BILI)];
    settingLable.font = [UIFont systemFontOfSize:15*BILI];
    settingLable.textColor = [UIColor blackColor];
    settingLable.alpha = 0.9;
    settingLable.text = @"+86：";
    [oldPassWorldButton addSubview:settingLable];
    
    self.telTextField = [[UITextField alloc] initWithFrame:CGRectMake(154*BILI/2, 0, 300*BILI, 45*BILI)];
    //self.telTextField.placeholder = self.telStr;
    self.telTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.telTextField.textColor = [UIColor blackColor];
    self.telTextField.alpha = 0.5;
    self.telTextField.delegate = self;
    self.telTextField.keyboardType = UIKeyboardTypeNumberPad;
    [oldPassWorldButton addSubview:self.telTextField];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.telStr attributes:
                                      @{NSForegroundColorAttributeName:[UIColor blackColor],
                                        NSFontAttributeName:self.telTextField.font
                                        }];
    self.telTextField.attributedPlaceholder = attrString;
    
    UIButton * editButton = [[UIButton alloc] initWithFrame:CGRectMake(35*BILI/2, 154*BILI/2+oldPassWorldButton.frame.origin.y+oldPassWorldButton.frame.size.height, 680*BILI/2, 40*BILI)];
    editButton.layer.cornerRadius = 8*BILI;
    editButton.backgroundColor = UIColorFromRGB(0x5077AA);
    [editButton setTitle:@"提交" forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editTelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editButton];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, editButton.frame.origin.y+editButton.frame.size.height+20*BILI, VIEW_WIDTH-26*BILI, 60*BILI)];
    tipLable.text = @"一个手机号只能作为一个账户的登录名";
    tipLable.textColor = [UIColor lightGrayColor];
    tipLable.font =[UIFont systemFontOfSize:18*BILI];
    tipLable.numberOfLines = 2;
    tipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLable];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length>=11 && ![@"" isEqualToString:string]) {
        
        return NO;
    }
    else
    {
        return YES;
    }
    
}
-(void)editTelButtonClick
{
    if (self.telTextField.text.length==0) {
        
        [Common showToastView:@"号码能为空" view:self.view];
        return;
    }
    [self showNewLoadingView:@"提交中..." view:self.view];

    [self.telTextField resignFirstResponder];
    [self.cloudClient editTel:@"loginUser!updateTel.do"
                       newtel:self.telTextField.text
                     delegate:self
                     selector:@selector(editTelSuccess:)
                errorSelector:@selector(editTelError:)];
}
-(void)editTelSuccess:(NSDictionary *) info
{
    [self hideNewLoadingView];
    [self performSelector:@selector(successPop) withObject:nil afterDelay:0.5];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate resetNotLoginTabBar];
    
    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    tipButton.backgroundColor = [UIColor blackColor];
    [tipButton setTitle:@"密码修改成功,请重新登录" forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [[UIApplication sharedApplication].keyWindow addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];
}
-(void)successPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editTelError:(NSDictionary *)info
{
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
    [self hideNewLoadingView];
}
-(void)viewTap
{
    [self.telTextField resignFirstResponder];
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
