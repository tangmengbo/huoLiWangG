//
//  CloudClientRequest.m
//  Discuz2
//
//  Created by rexshi on 11/10/11.
//  Copyright (c) 2011 rexshi. All rights reserved.
//

#import "CloudClientRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#import "Common.h"

@implementation CloudClientRequest

@synthesize request = _request;
@synthesize delegate = _delegate;
@synthesize finishSelector = _finishSelector;
@synthesize finishErrorSelector = _finishErrorSelector;

#pragma mark - private

/**
 *  get the information of the device and system
 *  "i386"          simulator
 *  "iPod1,1"       iPod Touch
 *  "iPhone1,1"     iPhone
 *  "iPhone1,2"     iPhone 3G
 *  "iPhone2,1"     iPhone 3GS
 *  "iPad1,1"       iPad
 *  "iPhone3,1"     iPhone 4
 */
- (NSString*)getDeviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *device = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return device;
}

#pragma mark - init

- (id)init
{
    self = [super init];
    if (self) {
        self.registerState = NO;
    }
    
    return self;
}

- (void)dealloc
{
    [_request clearDelegatesAndCancel];
//    [_request release]; _request = nil;
//    [super dealloc];
}


- (NSString *)getRequestUrl:(NSString *)tempmod
{
    NSString *url = [NSString stringWithFormat:@"%@%@", HTTP_REQUESTURL, tempmod];
    return url;
}




- (void)cancel
{
    [_request clearDelegatesAndCancel];
}



- (void)callMethodWithMod:(NSString *)tempmod
                   params:(NSDictionary *)params
             headerParams:(NSDictionary *)headParams
               postParams:(NSMutableDictionary *)temppostParams
                    files:(NSArray *)files
                  cookies:(NSDictionary *)cookies
                   header:(NSDictionary *)header
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector
{
    NSString *url = [self getRequestUrl:tempmod];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                      delegate, @"delegate",
                                      NSStringFromSelector(selector), @"selector",
                                      NSStringFromSelector(errorSelector), @"errorSelector",
                                      nil];
    @try {
        ASIFormDataRequest *aRequest;
        
        // 禁用自动更新网络连接标示符状态
        [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:NO];
     
        
        if ([Common isValidDictionary:temppostParams]) {
            aRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
            [aRequest addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [aRequest addRequestHeader:@"Accept" value:@"application/json"];
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            
            NSDictionary * userInfo = [defaults objectForKey:USERINFO];

            if (userInfo)
            {
                 [aRequest setPostValue:[userInfo objectForKey:@"token"] forKey:@"token"];
                 [aRequest setPostValue:[userInfo objectForKey:@"userid"] forKey:@"userid"];
                NSNumber * number = [userInfo objectForKey:@"logintype"];
                 [aRequest setPostValue:[NSString stringWithFormat:@"%d",number.intValue] forKey:@"logintype"];
                
            }
            for (NSString *key in  temppostParams) {
                NSString *value = [temppostParams objectForKey:key];
                [aRequest setPostValue:value forKey:key];
            }
            
            // files
            if([Common isValidArray:files]){
                for (NSData * data in files)
                {
                    //[aRequest setData:data  withFileName:@"tmb.png" andContentType:@"image/png" forKey:@"file"];
                    [aRequest setData:data forKey:@"file"];
                }
            }
            
        } else {
            
            aRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
            [aRequest addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [aRequest addRequestHeader:@"Accept" value:@"application/json"];
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary * userInfo = [defaults objectForKey:USERINFO];
            
            if (userInfo)
            {
                [aRequest setPostValue:[userInfo objectForKey:@"token"] forKey:@"token"];
                [aRequest setPostValue:[userInfo objectForKey:@"userid"] forKey:@"userid"];
                NSNumber * number = [userInfo objectForKey:@"logintype"];
                [aRequest setPostValue:[NSString stringWithFormat:@"%d",number.intValue] forKey:@"logintype"];
                
            }
            
            // files
            if([Common isValidArray:files]){
                for (NSData * data in files)
                {
                    //[aRequest setData:data  withFileName:@"tmb.png" andContentType:@"image/png" forKey:@"file"];
                    [aRequest setData:data forKey:@"file"];
                }
            }
        }
        
        // delegate
        [aRequest setDelegate:self];
        
        // userinfo
        aRequest.userInfo = userInfo;
        
        // support GZip
        [aRequest setAllowCompressedResponse:YES];
        
       
        
        // charset
        aRequest.defaultResponseEncoding = NSUTF8StringEncoding;
        
        // user-agent
        [aRequest setUserAgent:@"iOS_Client"];
        
        [aRequest setTimeOutSeconds:20];
        
        // cookie
        aRequest.useCookiePersistence = NO;
        
        
        //+++++++++++++++++++++++++++++++
        [aRequest setAuthenticationScheme:@"https"];
        [aRequest setValidatesSecureCertificate:NO];//是否验证服务器端证书，如果此项为yes那么服务器端证书必须为合法的证书机构颁发的，而不能是自己用openssl 或java生成的证书
        //+++++++++++++++++++++++++++++++
        
        self.request = aRequest;
        
        // start request
        [aRequest startAsynchronous];
    }
    @catch (NSException *exception) {
        @throw exception;
    }
}


#pragma mark - ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    @try {
        NSString *json = [request responseString];

        json = [json stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        // 检查结果
        if (!([json isKindOfClass:[NSString class]] && [(NSString*)json length] > 0)) {
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"1", @"code",
                                       @"服务器返回为空内容", @"message", nil];
            
            [_delegate performSelector:_finishErrorSelector
                            withObject:request.userInfo
                            withObject:errorInfo];
            
            
            [request.downloadCache removeCachedDataForRequest:request];
            
            UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)] ;
            tipButton.enabled = NO;
            tipButton.alpha = 0.8;
            tipButton.layer.cornerRadius = 20;
            tipButton.backgroundColor = [UIColor blackColor];
            [tipButton setTitle:@"服务器返回为空内容" forState:UIControlStateNormal];
            [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
            tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.toastView addSubview:tipButton];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            tipButton.alpha = 0;
            [UIView commitAnimations];
            
            return;
        }
                
        // 不是json
        if (json == nil
            || [json isKindOfClass:[NSNull class]]
            ||(![json hasPrefix:@"{"] && ![json hasPrefix:@"["])) {
            NSString *code = @"2"; 
            NSString *message = @"服务器返回数据格式错误";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                       code, @"code",
                                       message, @"message", nil];
            
            [_delegate performSelector:_finishErrorSelector
                            withObject:request.userInfo
                            withObject:errorInfo];
            
            [request.downloadCache removeCachedDataForRequest:request];
            
            UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40) ];
            tipButton.enabled = NO;
            tipButton.alpha = 0.8;
            tipButton.layer.cornerRadius = 20;
            tipButton.backgroundColor = [UIColor blackColor];
            [tipButton setTitle:@"服务器返回数据格式错误" forState:UIControlStateNormal];
            [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
            tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.toastView addSubview:tipButton];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            tipButton.alpha = 0;
            [UIView commitAnimations];
            

            
            return;
        }
        
        NSDictionary *items = [json JSONValue];
        
        int code = [[items objectForKey:@"error_code"] intValue];
        NSString *message = [items objectForKey:@"infomsg"];
        
       
        if (code != 0) {
            
            
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSString stringWithFormat:@"%d", code], @"code",
                                       message, @"message", nil];
            
            [_delegate performSelector:_finishErrorSelector
                            withObject:request.userInfo
                            withObject:errorInfo];
            
            
            
            [request.downloadCache removeCachedDataForRequest:request];
            
            
            UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
            tipButton.enabled = NO;
            tipButton.alpha = 0.8;
            tipButton.layer.cornerRadius = 20;
            tipButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            tipButton.backgroundColor = [UIColor blackColor];
            [tipButton setTitle:message forState:UIControlStateNormal];
            [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
            tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.toastView addSubview:tipButton];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            tipButton.alpha = 0;
            [UIView commitAnimations];
            
            if (code==9) {
                
                AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate resetNotLoginTabBar];
                
                UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
                tipButton.enabled = NO;
                tipButton.alpha = 0.8;
                tipButton.layer.cornerRadius = 20;
                tipButton.titleLabel.adjustsFontSizeToFitWidth = YES;
                tipButton.backgroundColor = [UIColor blackColor];
                [tipButton setTitle:message forState:UIControlStateNormal];
                [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
                tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
                
                [[UIApplication sharedApplication].keyWindow addSubview:tipButton];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:3];
                tipButton.alpha = 0;
                [UIView commitAnimations];
            }
            
            return;
        }
        
        //id result = [items objectForKey:@"data"];
        id resultData;
        if ([[items objectForKey:@"body"] isKindOfClass:[NSDictionary class]]||[[items objectForKey:@"body"] isKindOfClass:[NSArray class]]) {
            
          resultData  = [items objectForKey:@"body"];

        }
        else if ([[items objectForKey:@"items"] isKindOfClass:[NSArray class]])
        {
            resultData  = [items objectForKey:@"items"];
        }
        else if ([[items objectForKey:@"result"] isKindOfClass:[NSDictionary class]])
        {
            resultData  = [items objectForKey:@"result"];
        }
        else if ([[items objectForKey:@"result"] isKindOfClass:[NSArray class]])
        {
            resultData  = [items objectForKey:@"result"];
        }
        else
        {
            resultData = [items objectForKey:@"result"];
        }
        
        // 执行回调        
        [_delegate performSelector:_finishSelector
                        withObject:request.userInfo
                        withObject:resultData];
    }
    @catch (NSException *exception)
    {
        NSLog(@"网络请求异常，请稍后重试:%@",request);
        NSDictionary * info;
        NSString * state = [Common netWorkState];
        
        if ([@"网络不可用" isEqualToString:state]) {
            
            info  = [[NSDictionary alloc] initWithObjectsAndKeys:@"当前没有网络连接",@"message", nil];
            UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
            tipButton.enabled = NO;
            tipButton.alpha = 0.8;
            tipButton.layer.cornerRadius = 20;
            tipButton.backgroundColor = [UIColor blackColor];
            [tipButton setTitle:@"当前没有网络连接" forState:UIControlStateNormal];
            [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
            tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.toastView addSubview:tipButton];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            tipButton.alpha = 0;
            [UIView commitAnimations];

        }
        else
        {
            info = [[NSDictionary alloc] initWithObjectsAndKeys:@"网络加载失败,请重试",@"message", nil];
            
            UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
            tipButton.enabled = NO;
            tipButton.alpha = 0.8;
            tipButton.layer.cornerRadius = 20;
            tipButton.backgroundColor = [UIColor blackColor];
            [tipButton setTitle:@"网络加载失败,请重试" forState:UIControlStateNormal];
            [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
            tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.toastView addSubview:tipButton];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            tipButton.alpha = 0;
            [UIView commitAnimations];
        }

       
        [_delegate performSelector:_finishErrorSelector
                        withObject:info
                        withObject:info];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    NSString * state = [Common netWorkState];
    NSDictionary * info;
    if ([@"3" isEqualToString:state]) {
        
        info  = [[NSDictionary alloc] initWithObjectsAndKeys:@"当前没有网络连接",@"message", nil];
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];
        [tipButton setTitle:@"当前没有网络连接" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        if(self.toastView)
        {
            [self.toastView addSubview:tipButton];
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];
        
    }
    else
    {
        info = [[NSDictionary alloc] initWithObjectsAndKeys:@"网络加载失败,请重试",@"message", nil];
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];
        [tipButton setTitle:@"网络加载失败,请重试" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        if(self.toastView)
        {
             [self.toastView addSubview:tipButton];
        }
       
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];
    }
    [_delegate performSelector:_finishErrorSelector
                    withObject:request.userInfo
                    withObject:info];
    
    
}

@end
