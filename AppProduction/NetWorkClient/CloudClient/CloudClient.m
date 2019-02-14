//
//  CloudClient.m
//  Discuz2
//
//  Created by rexshi on 11/10/11.
//  Copyright (c) 2011 rexshi. All rights reserved.
//

#import "CloudClient.h"

@implementation CloudClient

+ (CloudClient *)getInstance
{
    CloudClient *client = [[[CloudClient alloc] init] autorelease];
    return client;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.client = [[CloudClientRequest alloc] init];
        _client.delegate = self;
        _client.finishSelector = @selector(finish:errorInfo:);
        _client.finishErrorSelector = @selector(finishError:errorInfo:);
    }
    
    return self;
}

- (void)dealloc
{
    [_client release];
    [super dealloc];
}

#pragma mark - CloudClientRequestDelegate

- (void) finish:(NSDictionary *)delegateInfo errorInfo:(NSDictionary *)result
{
    id object = [delegateInfo objectForKey:@"delegate"];
    NSString *selectorName = [delegateInfo objectForKey:@"selector"];
    
    NSArray *parts = [selectorName componentsSeparatedByString:@":"];
    int count = [parts count];
    if (count == 2) {
        [object performSelector:NSSelectorFromString(selectorName) withObject:result];
    } else if (count == 3) {
        [object performSelector:NSSelectorFromString(selectorName) withObject:result withObject:self];
    } else {
        return;
    }
}

- (void) finishError:(NSDictionary *)delegateInfo errorInfo:(NSDictionary *)errorInfo
{
    id object = [delegateInfo objectForKey:@"delegate"];
    NSString *errorSelectorName = [delegateInfo objectForKey:@"errorSelector"];
    
    NSArray *parts = [errorSelectorName componentsSeparatedByString:@":"];
    int count = [parts count];
    if (count == 2) {
        [object performSelector:NSSelectorFromString(errorSelectorName) withObject:errorInfo];
    } else if (count == 3) {
        [object performSelector:NSSelectorFromString(errorSelectorName) withObject:errorInfo withObject:self];
    } else {
        return;
    }
}

#pragma mark - user

-(void)setToastView:(UIView *)toastView
{
    _client.toastView = toastView;

}


//测试
-(void)login:(NSString *)api
    username:(NSString *)username
   passworld:(NSString *)passworld
         lot:(NSString *)lot
         lat:(NSString *)lat
     address:(NSString *)address
  devicetype:(NSString *)devicetype
    delegate:(id)delegate
    selector:(SEL)selector
errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:username forKey:@"username"];
    [params setObject:passworld forKey:@"password"];
    [params setObject:lot forKey:@"lot"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:address forKey:@"address"];
    [params setObject:devicetype forKey:@"devicetype"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//2.5用户退出接口
-(void)exitLogin:(NSString *)api
        username:(NSString *)username
        delegate:(id)delegate
        selector:(SEL)selector
   errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:username forKey:@"username"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//8.2入户走访（户主）列表接口
-(void)ruHuZouFangHuZhuList:(NSString *)api
                   pagesize:(NSString *)pagesize
                     pageno:(NSString *)pageno
                   keywords:(NSString *)keywords
                   delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    [params setObject:keywords forKey:@"keywords"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//8.3入户走访（户主）详情接口
-(void)ruHuZouFangHuZhuDetailMes:(NSString *)api
                        holderid:(NSString *)holderid
                        delegate:(id)delegate
                        selector:(SEL)selector
                   errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:holderid forKey:@"holderid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.12入户走访信息登记上报接口
-(void)ruHuZouFangShangBao:(NSString *)api
                  holderid:(NSString *)holderid
                 visitdate:(NSString *)visitdate
              visitcontent:(NSString *)visitcontent
                  xgpgcode:(NSString *)xgpgcode
                       lot:(NSString *)lot
                       lat:(NSString *)lat
                   address:(NSString *)address
                    imgids:(NSString *)imgids
                  delegate:(id)delegate
                  selector:(SEL)selector
             errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:holderid forKey:@"holderid"];
    [params setObject:visitdate forKey:@"visitdate"];
    [params setObject:visitcontent forKey:@"visitcontent"];
    [params setObject:xgpgcode forKey:@"xgpgcode"];
    [params setObject:lot forKey:@"lot"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:address forKey:@"address"];
    [params setObject:imgids forKey:@"imgids"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//宣传轮播图
-(void)luoBoTuList:(NSString *)api
              type:(NSString *)type
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector
{
    
        NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
        [params setObject:type forKey:@"type"];
        
        [_client callMethodWithMod:api
                            params:nil
                      headerParams:params
                        postParams:params
                             files:nil
                           cookies:nil
                            header:nil
                          delegate:delegate
                          selector:selector
                     errorSelector:errorSelector];
    
}
//1.2政策宣传信息列表
-(void)zhengCeXuanChuanList:(NSString *)api
                   pagesize:(NSString *)pagesize
                     pageno:(NSString *)pageno
                       type:(NSString *)type
                   delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:type forKey:@"type"];
     [params setObject:pagesize forKey:@"pagesize"];
     [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
    
}
//1.4我的爆料信息列表
-(void)baoLiaoList:(NSString *)api
          pagesize:(NSString *)pagesize
            pageno:(NSString *)pageno
          keywords:(NSString *)keywords
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:keywords forKey:@"keywords"];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//1.4.3 以奖代补考核办法H5查看接口
-(void)jiangLiH5:(NSString *)api
        delegate:(id)delegate
        selector:(SEL)selector
   errorSelector:(SEL)errorSelector
{
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:nil
                    postParams:nil
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//1.5我要爆料信息上报接口
-(void)baoLiaoShangBao:(NSString *)api
           tipoffplace:(NSString *)tipoffplace
               content:(NSString *)content
                   lot:(NSString *)lot
                   lat:(NSString *)lat
              photoids:(NSString *)photoids
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:tipoffplace forKey:@"tipoffplace"];
    [params setObject:content forKey:@"content"];
    [params setObject:lot forKey:@"lot"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:photoids forKey:@"photoids"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//1.4.1 我要爆料信息图片提交接口
-(void)BaoLiaoUploadImage:(NSString *)api
                     file:(NSData *)file
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    
    NSArray * files = [[NSArray alloc] initWithObjects:file, nil];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:files
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//2.2用户更新手机号信息接口
-(void)editTel:(NSString *)api
        newtel:(NSString *)newtel
      delegate:(id)delegate
      selector:(SEL)selector
 errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:newtel forKey:@"newtel"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}

//2.3用户更新头像信息接口
-(void)editHeaderPhoto:(NSString *)api
                  file:(NSData *)file
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    
    NSArray * files = [[NSArray alloc] initWithObjects:file, nil];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:files
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}

//2.4用户修改密码接口
-(void)editPassWorld:(NSString *)api
              oldpsw:(NSString *)oldpsw
              newpsw:(NSString *)newpsw
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:oldpsw forKey:@"oldpsw"];
    [params setObject:newpsw forKey:@"newpsw"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//2.6民众注册接口
-(void)registerApi:(NSString *)api
            mobile:(NSString *)mobile
          realname:(NSString *)realname
               sex:(NSString *)sex
            idcard:(NSString *)idcard
           address:(NSString *)address
          smstoken:(NSString *)smstoken
            newpsw:(NSString *)newpsw
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:mobile forKey:@"mobile"];
    [params setObject:realname forKey:@"realname"];
    [params setObject:sex forKey:@"sex"];
    [params setObject:idcard forKey:@"idcard"];
    [params setObject:address forKey:@"address"];
    [params setObject:smstoken forKey:@"smstoken"];
    [params setObject:newpsw forKey:@"newpsw"];
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
///2.7发送短信验证码接口
-(void)getCheckNumber:(NSString *)api
               mobile:(NSString *)mobile
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:mobile forKey:@"mobile"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//2.8重设密码接口
-(void)resetPw:(NSString *)api
        mobile:(NSString *)mobile
        newpsw:(NSString *)newpsw
      smstoken:(NSString *)smstoken
      delegate:(id)delegate
      selector:(SEL)selector
 errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:mobile forKey:@"mobile"];
    [params setObject:newpsw forKey:@"newpsw"];
    [params setObject:smstoken forKey:@"smstoken"];
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//3 网格员实时定位上传接口
-(void)uploadAddress:(NSString *)api
                 lot:(NSString *)lot
                 lat:(NSString *)lat
             address:(NSString *)address
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:lot forKey:@"lot"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:address forKey:@"address"];
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.14入户走访信息详情接口  管控台账
-(void)GKTZ_ruHuDetail:(NSString *)api
                dataid:(NSString *)dataid
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:dataid forKey:@"dataid"];
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.2重点人员走访信息列表接口
-(void)zhongDianRenYuanZouFangMesList:(NSString *)api
                             pagesize:(NSString *)pagesize
                               pageno:(NSString *)pageno
                             keywords:(NSString *)keywords
                             delegate:(id)delegate
                             selector:(SEL)selector
                        errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:keywords forKey:@"keywords"];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.3重点人员走访信息详情接口
-(void)zhongDianRenYuanZouFangDetail:(NSString *)api
                              visitid:(NSString *)visitid
                            delegate:(id)delegate
                            selector:(SEL)selector
                       errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:visitid forKey:@"visitid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.13入户走访信息列表接口
-(void)ruHuZouFangXinXiList:(NSString *)api
                   pagesize:(NSString *)pagesize
                     pageno:(NSString *)pageno
                   keywords:(NSString *)keywords
                   delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:keywords forKey:@"keywords"];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.14入户走访信息详情接口
-(void)ruHuZouFangXinXiDetail:(NSString *)api
                       dataid:(NSString *)dataid
                     delegate:(id)delegate
                     selector:(SEL)selector
                errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:dataid forKey:@"dataid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}

//5.5重点场所巡查信息列表接口
-(void)zhongDianChangSuoXunChaList:(NSString *)api
                          pagesize:(NSString *)pagesize
                            pageno:(NSString *)pageno
                          keywords:(NSString *)keywords
                          delegate:(id)delegate
                          selector:(SEL)selector
                     errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:keywords forKey:@"keywords"];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.6重点场所巡查信息详情接口
-(void)zhongDianChangSuoXunChaDetail:(NSString *)api
                              patrolid:(NSString *)patrolid
                            delegate:(id)delegate
                            selector:(SEL)selector
                       errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:patrolid forKey:@"patrolid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.7重点场所信息列表接口
-(void)zhongDianChangSuoList:(NSString *)api
                    pagesize:(NSString *)pagesize
                      pageno:(NSString *)pageno
                    keywords:(NSString *)keywords
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:keywords forKey:@"keywords"];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.8重点场所信息详情接口
-(void)zhongDianChangSuoMes:(NSString *)api
                     dataid:(NSString *)dataid
                   delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:dataid forKey:@"dataid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}

//5.10一般场所巡查信息列表接口
-(void)yiBanChangSuoXunChaList:(NSString *)api
                pagesize:(NSString *)pagesize
                  pageno:(NSString *)pageno
                keywords:(NSString *)keywords
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:keywords forKey:@"keywords"];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.11一般场所巡查信息详情接口
-(void)yiBanChangSuoXunChaDetail:(NSString *)api
                    patrolid:(NSString *)patrolid
                  delegate:(id)delegate
                  selector:(SEL)selector
             errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:patrolid forKey:@"patrolid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}

//5.4重点场所巡查信息登记上报接口
-(void)zhongDianChangSuoXunChaShangBao:(NSString *)api
                                dataid:(NSString *)dataid
                          locataddress:(NSString *)locataddress
                            patroldate:(NSString *)patroldate
                         patrolcontent:(NSString *)patrolcontent
                           resolveflag:(NSString *)resolveflag
                              risktype:(NSString *)risktype
                              xgpgcode:(NSString *)xgpgcode
                                   lot:(NSString *)lot
                                   lat:(NSString *)lat
                                imgids:(NSString *)imgids
                              delegate:(id)delegate
                              selector:(SEL)selector
                         errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:dataid forKey:@"dataid"];
    [params setObject:locataddress forKey:@"locataddress"];
    [params setObject:patroldate forKey:@"patroldate"];
    [params setObject:patrolcontent forKey:@"patrolcontent"];
    [params setObject:resolveflag forKey:@"resolveflag"];
    [params setObject:risktype forKey:@"risktype"];
    [params setObject:xgpgcode forKey:@"xgpgcode"];
    [params setObject:lot forKey:@"lot"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:imgids forKey:@"imgids"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//5.9一般场所巡查信息登记上报接口

-(void)yiBanChangSuoXunChaShangBao:(NSString *)api
                            gridid:(NSString *)gridid
                         placename:(NSString *)placename
                       placeheader:(NSString *)placeheader
                         headertel:(NSString *)headertel
                      placeaddress:(NSString *)placeaddress
                      locataddress:(NSString *)locataddress
                        patroldate:(NSString *)patroldate
                     patrolcontent:(NSString *)patrolcontent
                       resolveflag:(NSString *)resolveflag
                          risktype:(NSString *)risktype
                          xgpgcode:(NSString *)xgpgcode
                               lot:(NSString *)lot
                               lat:(NSString *)lat
                            imgids:(NSString *)imgids
                          delegate:(id)delegate
                          selector:(SEL)selector
                     errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:gridid forKey:@"gridid"];
    [params setObject:placename forKey:@"placename"];
    [params setObject:placeheader forKey:@"placeheader"];
    [params setObject:headertel forKey:@"headertel"];
    [params setObject:placeaddress forKey:@"placeaddress"];
    
    [params setObject:locataddress forKey:@"locataddress"];
    [params setObject:patroldate forKey:@"patroldate"];
    [params setObject:patrolcontent forKey:@"patrolcontent"];
    [params setObject:resolveflag forKey:@"resolveflag"];
    [params setObject:risktype forKey:@"risktype"];
    [params setObject:xgpgcode forKey:@"xgpgcode"];
    [params setObject:lot forKey:@"lot"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:imgids forKey:@"imgids"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//6.3网格事件台账信息列表（处置和报告台账共用）接口
-(void)chuZhiAndBaoGaoTaiZhangList:(NSString *)api
                          pagesize:(NSString *)pagesize
                            pageno:(NSString *)pageno
                          keywords:(NSString *)keywords
                             sdate:(NSString *)sdate
                             edate:(NSString *)edate
                              type:(NSString *)type
                          delegate:(id)delegate
                          selector:(SEL)selector
                     errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:keywords forKey:@"keywords"];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
     [params setObject:type forKey:@"type"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}

//5.2重点人员走访信息列表接口
-(void)zhongDianRenYuanList:(NSString *)api
                   pagesize:(NSString *)pagesize
                     pageno:(NSString *)pageno
                   keywords:(NSString *)keywords
                   delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:keywords forKey:@"keywords"];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//8.5重点人员信息详情接口
-(void)zhongDianRenYuanDetail:(NSString *)api
                       dataid:(NSString *)dataid
                     delegate:(id)delegate
                     selector:(SEL)selector
                errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:dataid forKey:@"dataid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//重点人员走访信息登记上报接口
-(void)zhongDianRenYuanZouFangShangBao:(NSString *)api
                                dataid:(NSString *)dataid
                             visitdate:(NSString *)visitdate
                          visitcontent:(NSString *)visitcontent
                              xgpgcode:(NSString *)xgpgcode
                                   lot:(NSString *)lot
                                   lat:(NSString *)lat
                               address:(NSString *)address
                                imgids:(NSString *)imgids
                              delegate:(id)delegate
                              selector:(SEL)selector
                         errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:dataid forKey:@"dataid"];
    [params setObject:visitdate forKey:@"visitdate"];
    [params setObject:visitcontent forKey:@"visitcontent"];
    [params setObject:xgpgcode forKey:@"xgpgcode"];
    [params setObject:lot forKey:@"lot"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:address forKey:@"address"];
    [params setObject:imgids forKey:@"imgids"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//事件图片上传(文件流)接口    targettype(上传来源代码：1重点人员走访2重点场所巡查3事件上报4入户走访)
-(void)imageUpload:(NSString *)api
              file:(NSData *)file
        targettype:(NSString *)targettype
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:targettype forKey:@"targettype"];
    
    NSArray * files = [[NSArray alloc] initWithObjects:file, nil];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:files
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}

-(void)deleteImage:(NSString *)api
             imgid:(NSString *)imgid
        targettype:(NSString *)targettype
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:imgid forKey:@"imgid"];
    [params setObject:targettype forKey:@"targettype"];
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//6.1网格事件处置信息登记接口 eventInfo!eventSiteDisposalAdd.do
-(void)wangeGeShiJianChuZhi:(NSString *)api
                     gridid:(NSString *)gridid
               eventbigtype:(NSString *)eventbigtype
                 eventscope:(NSString *)eventscope
                eventnature:(NSString *)eventnature
                 eventlevel:(NSString *)eventlevel
                      title:(NSString *)title
                    content:(NSString *)content
                happenddate:(NSString *)happenddate
               eventaddress:(NSString *)eventaddress
                resolvetype:(NSString *)resolvetype
                    results:(NSString *)results
                   xgpgcode:(NSString *)xgpgcode
                        lot:(NSString *)lot
                        lat:(NSString *)lat
                    address:(NSString *)address
                     imgids:(NSString *)imgids
                   delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:gridid forKey:@"gridid"];
    [params setObject:eventbigtype forKey:@"eventbigtype"];
    [params setObject:eventscope forKey:@"eventscope"];
    [params setObject:eventnature forKey:@"eventnature"];
    [params setObject:eventlevel forKey:@"eventlevel"];
    [params setObject:title forKey:@"title"];
    [params setObject:content forKey:@"content"];
    [params setObject:happenddate forKey:@"happenddate"];
    [params setObject:eventaddress forKey:@"eventaddress"];
    [params setObject:resolvetype forKey:@"resolvetype"];
    [params setObject:results forKey:@"results"];
    [params setObject:xgpgcode forKey:@"xgpgcode"];
    [params setObject:lot forKey:@"lot"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:address forKey:@"address"];
    [params setObject:imgids forKey:@"imgids"];
    
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//6.2网格事件报告信息登记接口
-(void)wangGeShiJianShangBao:(NSString *)api
                      gridid:(NSString *)gridid
                eventbigtype:(NSString *)eventbigtype
                  eventscope:(NSString *)eventscope
                 eventnature:(NSString *)eventnature
                  eventlevel:(NSString *)eventlevel
                       title:(NSString *)title
                     content:(NSString *)content
                 happenddate:(NSString *)happenddate
                eventaddress:(NSString *)eventaddress
                         lot:(NSString *)lot
                         lat:(NSString *)lat
                     address:(NSString *)address
                      imgids:(NSString *)imgids
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:gridid forKey:@"gridid"];
    [params setObject:eventbigtype forKey:@"eventbigtype"];
    [params setObject:eventscope forKey:@"eventscope"];
    [params setObject:eventnature forKey:@"eventnature"];
    [params setObject:eventlevel forKey:@"eventlevel"];
    [params setObject:title forKey:@"title"];
    [params setObject:content forKey:@"content"];
    [params setObject:happenddate forKey:@"happenddate"];
    [params setObject:eventaddress forKey:@"eventaddress"];
    [params setObject:lot forKey:@"lot"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:address forKey:@"address"];
    [params setObject:imgids forKey:@"imgids"];
    
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}

//6.3 事件跟踪信息列表
-(void)shiJianGenZongList:(NSString *)api
                 pagesize:(NSString *)pagesize
                   pageno:(NSString *)pageno
                 keywords:(NSString *)keywords
                    sdate:(NSString *)sdate
                    edate:(NSString *)edate
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    [params setObject:keywords forKey:@"keywords"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//6.4报告信息详情接口
-(void)baoGaoDeetailMes:(NSString *)api
                eventid:(NSString *)eventid
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:eventid forKey:@"eventid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//6.5报告事件列表接口
-(void)baoGaoList:(NSString *)api
         pagesize:(NSString *)pagesize
           pageno:(NSString *)pageno
          eywords:(NSString *)keywords
            sdate:(NSString *)sdate
            edate:(NSString *)edate
         delegate:(id)delegate
         selector:(SEL)selector
    errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
// 6.7网格长待审阅事件列表接口
-(void)baoGaoShenYueList:(NSString *)api
                pagesize:(NSString *)pagesize
                  pageno:(NSString *)pageno
                keywords:(NSString *)keywords
                   sdate:(NSString *)sdate
                   edate:(NSString *)edate
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//6.8 网格长事件审阅信息登记接口
-(void)baoGaoShenYueChuLi:(NSString *)api
                  eventid:(NSString *)eventid
                     idea:(NSString *)idea
                   sbflag:(NSString *)sbflag
             eventbigtype:(NSString *)eventbigtype
               eventscope:(NSString *)eventscope
              eventnature:(NSString *)eventnature
               eventlevel:(NSString *)eventlevel
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:eventid forKey:@"eventid"];
    [params setObject:idea forKey:@"idea"];
    [params setObject:sbflag forKey:@"sbflag"];
    [params setObject:eventbigtype forKey:@"eventbigtype"];
    [params setObject:eventscope forKey:@"eventscope"];
    [params setObject:eventnature forKey:@"eventnature"];
    [params setObject:eventlevel forKey:@"eventlevel"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//7.1知识库信息列表接口
-(void)zhiShiKuList:(NSString *)api
           pagesize:(NSString *)pagesize
             pageno:(NSString *)pageno
           keywords:(NSString *)keywords
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    [params setObject:keywords forKey:@"keywords"];
    
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//7.2知识库信息详情H5接口
-(void)zhiShiKuXiangQingH5:(NSString *)api
                    dataid:(NSString *)dataid
                  delegate:(id)delegate
                  selector:(SEL)selector
             errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:dataid forKey:@"dataid"];
    
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}

// 9 网格员信息列表接口
-(void)wangGeYuanList:(NSString *)api
             pagesize:(NSString *)pagesize
               pageno:(NSString *)pageno
             keywords:(NSString *)keywords
                 type:(NSString *)type
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    [params setObject:keywords forKey:@"keywords"];
    [params setObject:type forKey:@"type"];

    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//10. 网格员轨迹回放接口
-(void)guiJiHuiFangList:(NSString *)api
                    day:(NSString *)day
               memberid:(NSString *)memberid
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:day forKey:@"day"];
    [params setObject:memberid forKey:@"memberid"];
    
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//11.1 任务处理列表接口  状态代码：1已处理0未处理（默认)
-(void)renWuChuLiList:(NSString *)api
             pagesize:(NSString *)pagesize
               pageno:(NSString *)pageno
                state:(NSString *)state
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    [params setObject:state forKey:@"state"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//11.2任务下达接口[为其它网格员指派（下达）任务信息，必须选择网格员（长），即zrrid字段]
-(void)xiaDaTask:(NSString *)api
        taskname:(NSString *)taskname
     taskcontent:(NSString *)taskcontent
       tasklimit:(NSString *)tasklimit
           zrrid:(NSString *)zrrid
        delegate:(id)delegate
        selector:(SEL)selector
   errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:taskname forKey:@"taskname"];
    [params setObject:taskcontent forKey:@"taskcontent"];
    [params setObject:tasklimit forKey:@"tasklimit"];
    [params setObject:zrrid forKey:@"zrrid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
    
}
//11.3我的下达任务列表接口[当前登录用户指派下达给别人的任务列表。]
-(void)woDeXiaDaList:(NSString *)api
            pagesize:(NSString *)pagesize
              pageno:(NSString *)pageno
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//11.4 我的下达任务详情接口
-(void)woDeXiaDaDetail:(NSString *)api
                taskid:(NSString *)taskid
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:taskid forKey:@"taskid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//12. 网格员考核评比结果列表接口

-(void)kaoHePingBiList:(NSString *)api
              pagesize:(NSString *)pagesize
                pageno:(NSString *)pageno
            assesstype:(NSString *)assesstype
                 month:(NSString *)month
               quarter:(NSString *)quarter
                  year:(NSString *)year
              keywords:(NSString *)keywords
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    [params setObject:assesstype forKey:@"assesstype"];
    [params setObject:month forKey:@"month"];
    [params setObject:quarter forKey:@"quarter"];
    [params setObject:year forKey:@"year"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//13.1网格列表（默认）接口
-(void)wangGeXinXi:(NSString *)api
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector
{
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:nil
                    postParams:nil
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//13.2网格列表详情接口
-(void)wangGeLieBiaoList:(NSString *)api
                  gridid:(NSString *)gridid
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:gridid forKey:@"gridid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//14.1公告广播列表
-(void)gongGaoYuJingAndMyMessageList:(NSString *)api
          pagesize:(NSString *)pagesize
            pageno:(NSString *)pageno
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:pagesize forKey:@"pagesize"];
    [params setObject:pageno forKey:@"pageno"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//14.2通知列表
-(void)tongZhiList:(NSString *)api
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
////14.5我的消息阅读状态改变接口
-(void)myMessageRead:(NSString *)api
             msgid:(NSString *)msgid
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:msgid forKey:@"msgid"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}

//15.1 网格长-统计分析接口
-(void)wangGeZhangTongJiFenXi:(NSString *)api
                         type:(NSString *)type
                        month:(NSString *)month
                      quarter:(NSString *)quarter
                         year:(NSString *)year
                     delegate:(id)delegate
                     selector:(SEL)selector
                errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:type forKey:@"type"];
    [params setObject:month forKey:@"month"];
    [params setObject:quarter forKey:@"quarter"];
    [params setObject:year forKey:@"year"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
//15.2领导-工作台统计分析
-(void)lingDaoTongJiFenXi:(NSString *)api
                     type:(NSString *)type
                    month:(NSString *)month
                  quarter:(NSString *)quarter
                     year:(NSString *)year
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector
{
    NSMutableDictionary * params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:type forKey:@"type"];
    [params setObject:month forKey:@"month"];
    [params setObject:quarter forKey:@"quarter"];
    [params setObject:year forKey:@"year"];
    
    [_client callMethodWithMod:api
                        params:nil
                  headerParams:params
                    postParams:params
                         files:nil
                       cookies:nil
                        header:nil
                      delegate:delegate
                      selector:selector
                 errorSelector:errorSelector];
}
@end
