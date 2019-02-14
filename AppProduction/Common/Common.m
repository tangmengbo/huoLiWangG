//
//  Common.m
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-10.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import "Common.h"
#import <sys/utsname.h>
#import <Security/Security.h>
//获取idfa
#import <AdSupport/ASIdentifierManager.h>
@implementation Common

+(NSString *)getFileToDocuments:(NSString *)url
{
    NSString *resultFilePath = @"";
    
    
    
    NSString *destFilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[url substringFromIndex:7] ] ; // 去除域名，组合成本地文件PATH
    NSString *destFolderPath = [destFilePath stringByDeletingLastPathComponent];
    
    // 判断路径文件夹是否存在不存在则创建
    if (! [[NSFileManager defaultManager] fileExistsAtPath:destFolderPath]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:destFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 判断该文件是否已经下载过
    if ([[NSFileManager defaultManager] fileExistsAtPath:destFilePath]) {
        resultFilePath = destFilePath;
        return destFilePath;
    }
    else
    {
        return nil;
    }
    
    
}


+ (BOOL)strNilOrEmpty:(NSString *)string
{
    if ([string isKindOfClass:[NSString class]])
    {
        if (string.length > 0)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}

// 弹出系统警告框
+ (UIAlertView *)showAlert:(NSString *)title message:(NSString *)msg {
    NSString *strAlertOK = @"确定";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:strAlertOK
                                          otherButtonTitles:nil];
    [alert show];
    return alert;
}
+ (UIAlertView * )showNetWorkAlert :(id)deleagte message:(NSString *)message tag:(int)tag

{
    NSString *strAlertOK = @"确定";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:deleagte
                                          cancelButtonTitle:strAlertOK
                                          otherButtonTitles:nil];
    alert.tag = tag;
    [alert show];
    return alert;
}
+ (NSString *)strTrim:(NSString *)string{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//去掉两端的空格
}

#pragma mark -
#pragma mark 清除web缓存

+ (void)clearWebCache{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>= 6.0)
    {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    }
}

#pragma mark -
#pragma mark 验证邮箱是否合法
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(NSString*)getChineseCalendarWithDate:(NSDate *)date
{
    //定义农历数据:
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯", @"戊辰", @"己巳", @"庚午", @"辛未", @"壬申", @"癸酉",
                             @"甲戌", @"乙亥", @"丙子", @"丁丑", @"戊寅", @"己卯", @"庚辰", @"辛己", @"壬午", @"癸未",
                             @"甲申", @"乙酉", @"丙戌", @"丁亥", @"戊子", @"己丑", @"庚寅", @"辛卯", @"壬辰", @"癸巳",
                             @"甲午", @"乙未", @"丙申", @"丁酉", @"戊戌", @"己亥", @"庚子", @"辛丑", @"壬寅", @"癸丑",
                             @"甲辰", @"乙巳", @"丙午", @"丁未", @"戊申", @"己酉", @"庚戌", @"辛亥", @"壬子", @"癸丑",
                             @"甲寅", @"乙卯", @"丙辰", @"丁巳", @"戊午", @"己未", @"庚申", @"辛酉", @"壬戌", @"癸亥", nil];
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月",
                            @"七月", @"八月", @"九月", @"十月", @"冬月", @"腊月", nil];
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    NSCalendar* localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    NSString *chineseCal_str =[NSString stringWithFormat: @"农历:%@%@%@",y_str,m_str,d_str];// @"%@_%@_%@",y_str,m_str,d_str
    return chineseCal_str;
}

+ (NSDate*)getNSDateByString:(NSString*)string formate:(NSString*)formate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+ (NSString*)getDateStringByFormateString:(NSString*)formateString date:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formateString];
    NSString *strDate = [formatter stringFromDate:date];
    return strDate;
}

+ (NSInteger)getYearFromDate:(NSDate*)fromDate{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy"];
    NSInteger ym = [[dateFormater stringFromDate:fromDate] intValue];
    return ym;
}

+ (NSString *)getYearStrFromDate:(NSDate*)fromDate
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy"];
    return [dateFormater stringFromDate:fromDate] ;
}

+(NSInteger)getMonthFromDate:(NSDate*)fromDate{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"MM"];
    NSInteger ym = [[dateFormater stringFromDate:fromDate] intValue];
    return ym;
}

+(NSString *)getTimestamp:(NSDate *)date
{
    NSString *timeString = @"";
    if([date isKindOfClass:[NSDate class]])
    {
      timeString = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    }
    return timeString;
}

+(NSString*)getMonthChat:(NSDate *)date
{
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"MM"];
    NSInteger mm = [[dateFormater stringFromDate:date] intValue];
    NSString *tempMonth= @"";
    switch (mm) {
        case 1:
            tempMonth = @"JAN";
            break;
        case 2:
            tempMonth = @"FEB";
            break;
        case 3:
            tempMonth = @"MAY";
            break;
        case 4:
            tempMonth = @"APR";
            break;
        case 5:
            tempMonth = @"MAR";
            break;
        case 6:
            tempMonth = @"JUN";
            break;
        case 7:
            tempMonth = @"JUL";
            break;
        case 8:
            tempMonth = @"AUG";
            break;
        case 9:
            tempMonth = @"SEP";
            break;
        case 10:
            tempMonth = @"OCT";
            break;
        case 11:
            tempMonth = @"NOV";
            break;
        case 12:
            tempMonth = @"DEC";
            break;
    }
    [dateFormater setDateFormat:@"dd"];
    tempMonth = [tempMonth stringByAppendingString:[NSString stringWithFormat:@" %ld",[[dateFormater stringFromDate:date] integerValue]]];
    return tempMonth;
}

+(NSString *)timestampToDate:(NSString *)interval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString * dateString= [dateFormater stringFromDate:date];
    return dateString;
}
+(NSString *)timestampToDateHaoMiao:(NSString *)interval
{
    NSString * haoMiao = [interval substringWithRange:NSMakeRange(interval.length-3, 3)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]/1000];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString * dateString= [[dateFormater stringFromDate:date] stringByAppendingString:[NSString stringWithFormat:@".%@",haoMiao]];
    return dateString;
}
//图片缩放到指定大小尺寸
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    
    CGSize imgsize =size;
    
    UIGraphicsBeginImageContext(imgsize);
    [img drawInRect:CGRectMake(0, 0, imgsize.width, imgsize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//根据当前的经纬判断当前的位置信息
+(NSString *)getLoctionWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
{
    __block NSString *locationName = @"";

    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray * placemarks, NSError * error)
     {
         if (placemarks.count > 0)
         {
             CLPlacemark *plmark = [placemarks objectAtIndex:0];
             NSString *country = plmark.country;
             NSString *city = plmark.locality;
             locationName = [NSString stringWithFormat:@"%@%@",country,city];
         }
     }];
    return locationName;
}


+ (BOOL) isValidString:(id)input
{
    if (!input) {
        return NO;
    }
    if(input==nil)
    {
        return NO;
    }
    if([input isKindOfClass:[NSNull class]] )
    {
        return NO;
    }
    if ((NSNull *)input == [NSNull null]) {
        return NO;
    }
    if (![input isKindOfClass:[NSString class]]) {
        return NO;
    }
    if (!input &&[input isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

+ (BOOL) isValidDictionary:(id)input
{
    if (!input) {
        return NO;
    }
    if ((NSNull *)input == [NSNull null]) {
        return NO;
    }
    if (![input isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    if ([input count] <= 0) {
        return NO;
    }
    return YES;
}

+ (BOOL) isValidArray:(id)input
{
    if (!input) {
        return NO;
    }
    if ((NSNull *)input == [NSNull null]) {
        return NO;
    }
    if (![input isKindOfClass:[NSArray class]]) {
        return NO;
    }
    if ([input count] <= 0) {
        return NO;
    }
    return YES;
}
+(NSString *)getShenHeStatusStr
{
    NSUserDefaults * shenHeDefaults = [NSUserDefaults standardUserDefaults];
    NSString * shenHeStatus = [shenHeDefaults objectForKey:@"appAlsoInreview"];
    return shenHeStatus;
}

+(NSString *)getNowUserID {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"userId"];
}


+(NSString *)getCurrentUserName {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"nick"];
}
+(NSString *)getCurrentUserAnchorType
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * info = [userDefaults objectForKey:USERINFO];
    NSNumber * numberType = [info objectForKey:@"accountType"];
    NSString * typeStr = [NSString stringWithFormat:@"%d",numberType.intValue];
    return typeStr;
}
+(NSString *)getCurrentAvatarpath {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"avatarUrl"];
}
+(NSString *)getVIPStatus{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"isVip"];

}
+(NSString *)getRoleStatus
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    return [userInfo objectForKey:@"role"];

}
//较验用户名
+ (BOOL)validateUserName:(NSString*)number {
    BOOL res = YES;
    if(![Common isValidString:number])
        return NO;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//较验电话号码
+(BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    if(![Common isValidString:number])
        return NO;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//较验钱数
+(BOOL)validateMoneyNumber:(NSString*)number {
    BOOL res = YES;
    if(![Common isValidString:number])
        return NO;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//较验钱数
+(BOOL)validateMoneyNumberWithPoint:(NSString*)number {
    BOOL res = YES;
    if(![Common isValidString:number])
        return NO;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+(CGSize)setSize:(NSString *)message withCGSize:(CGSize)cgsize  withFontSize:(float)fontSize
{

    
    CGSize  size = [message boundingRectWithSize:cgsize  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size;
}



//+(UIImage *)generateImageForGalleryWithImage:(UIImage *)image
//{
//    UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:image];
//    tmpImageView.frame                  = CGRectMake(0.0f, 0.0f, image.size.width, image.size.width);
//    tmpImageView.layer.borderColor      = [UIColor whiteColor].CGColor;
//    tmpImageView.layer.borderWidth      = 0.0;
//    tmpImageView.layer.shouldRasterize  = YES;
//    
//    UIImage *tmpImage   = [UIImage imageFromView:tmpImageView];
//    
//    return [tmpImage transparentBorderImage:1.0f];
//}

+(NSString *)getobjectForKey:(id)object
{
    NSString *temp = @"";
    if(object  && ![object isEqual:[NSNull class]] &&![object isEqual:[NSNull null]])
    {
        temp = object;
    }
    return temp;
}

+(NSString *)integerToString:(CGFloat)tfloat
{
    return [NSString stringWithFormat:@"%ld",(NSInteger)tfloat];
}

+(NSString *)getReadableDateFromTimestamp:(NSString *)stamp
{
    NSString *_timestamp;
    
    NSTimeInterval createdAt = [stamp doubleValue];
    
    // Calculate distance time string
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
    if (distance < 0) distance = 0;
    
    if (distance < 30) {
        _timestamp = @"刚刚";
    }
    else if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"小时前" : @"小时前"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = ((distance / 60 / 60 / 24) + ((distance % (60 * 60 * 24))>0?1:0));
        if (distance == 1) {
            _timestamp = @"昨天";
        } else if (distance == 2) {
            _timestamp = @"前天";
        } else {
            _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"天前" : @"天前"];
        }
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"周前" : @"周前"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yy-MM-dd"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    
    return _timestamp;
}

+(void)showNetworkIndicator
{
    UIApplication* app=[UIApplication sharedApplication];
    app.networkActivityIndicatorVisible=YES;
}

+(void)hideNetworkIndicator
{
    UIApplication* app=[UIApplication sharedApplication];
    app.networkActivityIndicatorVisible=NO;
}


+(NSString*)uuid
{
    NSString *chars=@"abcdefghijklmnopgrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    assert(chars.length==62);
    int len=chars.length;
    NSMutableString* result=[[NSMutableString alloc] init];
    for(int i=0;i<24;i++){
        int p=arc4random_uniform(len);
        NSRange range=NSMakeRange(p, 1);
        [result appendString:[chars substringWithRange:range]];
    }
    return result;
}

#pragma mark - time

+(int64_t)int64OfStr:(NSString*)str
{
    return [str longLongValue];
}

+(NSString*)strOfInt64:(int64_t)num
{
    return [[NSNumber numberWithLongLong:num] stringValue];
}

+(UIButton * )showToastView:(NSString *)message view:(UIView *)view;
{
    CGSize oneLineSize = [Common setSize:message withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:12*BILI];

    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-oneLineSize.width-20)/2,(VIEW_HEIGHT-40*BILI)/2, oneLineSize.width+20, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];
    [tipButton setTitle:message forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];
    
    return tipButton;
}

//发布时间与当前时间的间隔
+ (NSString *)intervalSinceNow: (NSDate *) theDate
{
    
    NSTimeInterval late=[theDate timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"NO";
    
    NSTimeInterval cha=now-late;
    if (cha/60>2)
    {
    
        timeString=@"YES";
        
    }
    return timeString;
}
//获取当前时间与星期
+(NSDictionary *)getNowDateAndWeek
{
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    NSString * year= [NSString stringWithFormat:@"%d",(int)[comps year]];
    NSString * month = [NSString stringWithFormat:@"%d",(int)[comps month]];
    NSString * day = [NSString stringWithFormat:@"%d",(int)[comps day]];
    NSString * jiDu ;
    if ([@"1" isEqualToString:month]||[@"2" isEqualToString:month]||[@"3" isEqualToString:month]) {
        
        jiDu = @"1";
    }
    else if ([@"4" isEqualToString:month]||[@"5" isEqualToString:month]||[@"6" isEqualToString:month])
    {
        jiDu = @"2";
    }
    else if ([@"7" isEqualToString:month]||[@"8" isEqualToString:month]||[@"9" isEqualToString:month])
    {
        jiDu = @"3";
    }
    else
    {
        jiDu = @"4";
    }
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:year,@"year",jiDu,@"jiDu",month,@"month",day,@"day",[arrWeek objectAtIndex:week-1],@"week", nil];
    return dic;
}
+(NSString *)getWeekFromDate:(NSDate*)date
{
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    NSString * year= [NSString stringWithFormat:@"%d",(int)[comps year]];
    NSString * month = [NSString stringWithFormat:@"%d",(int)[comps month]];
    NSString * day = [NSString stringWithFormat:@"%d",(int)[comps day]];
    NSString * str = [arrWeek objectAtIndex:week-1];
    return str;
    
    
}
+ (NSString*)getDayFromDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    NSString * day = [NSString stringWithFormat:@"%d",(int)[comps day]];
    return day;
}
+ (NSString*)getDeviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *device = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return device;
}
+(NSString *)netWorkState
{
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        NSLog(@"有wifi");
        return @"wifi连接";
        
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        return @"手机流量";
        
    } else { // 没有网络
        
        NSLog(@"没有网络");
        return @"网络不可用";
    }

//    Reachability* reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
//    
//    NSString *status = @"";
//    
//    if (reach.isReachableViaWiFi) {
//        status =  @"wifi连接";
//    }
//    
//    if(![reach isReachable])
//    {
//        status = @"网络不可用";
//    }
//    if (reach.isReachableViaWWAN) {
//        
//        status = @"手机流量";
//    }
//    return status;
}
//获取图片格式
+(NSString *)contentTypeForImageData:(NSData *)data {
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
        case 0x52:
            
            if ([data length] < 12) {
                
                return nil;
                
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            
            if(testString!=nil && ![testString isKindOfClass:[NSNull class]])
            {
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                
                return @"webp";
                
            }
            }
            
            return nil;
            
    }
    
    return nil;
    
}
+(void)shakeAnimationForView:(UIView *) view
{
    // 获取到当前的View
    
    CALayer *viewLayer = view.layer;
    
    // 获取当前View的位置
    
    CGPoint position = viewLayer.position;
    
    // 移动的两个终点位置
    
    CGPoint x = CGPointMake(position.x + 15, position.y);
    
    CGPoint y = CGPointMake(position.x - 15, position.y);
    
    // 设置动画
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 设置运动形式
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    // 设置开始位置
    
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    
    // 设置结束位置
    
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    // 设置自动反转
    
    [animation setAutoreverses:YES];
    
    // 设置时间
    
    [animation setDuration:.06];
    
    // 设置次数
    
    [animation setRepeatCount:5];
    
    // 添加上动画
    
    [viewLayer addAnimation:animation forKey:nil];
    
    
    
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+(NSString *)getDeviceUUID;
{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSLog(@"%@",identifierForVendor);
    return identifierForVendor;
}
+(NSString *)getBenZhouYiShiJian:(NSString *)whichDay
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                         fromDate:now];
    
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 9 - weekDay;
    }
    
    NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"星期一开始 %@",[formater stringFromDate:firstDayOfWeek]);
    NSLog(@"当前 %@",[formater stringFromDate:now]);
    NSLog(@"星期天结束 %@",[formater stringFromDate:lastDayOfWeek]);
    
    
    if ([@"zhouYi" isEqualToString:whichDay]) {
        
        return [formater stringFromDate:firstDayOfWeek];
        
    }
    else if([@"jinTian" isEqualToString:whichDay])
    {
        return [formater stringFromDate:now];
    }
    else
    {
        [formater setDateFormat:@"yyyy-MM-dd "];
        [formater stringFromDate:now];
        
        NSString * nowStr = [formater stringFromDate:now];
        
        return [nowStr stringByAppendingString:@"00:00:00"];
    }
    
}
+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
//判断字符串是否为空或全是空格
+ (BOOL) isEmpty:(NSString *) str {
    
    if(!str) {
        
        return true;
        
    }else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        
        if([trimedString length] == 0) {
            
            return true;
            
            
        }else {
            
            
            return false;
            
            
        }
        
    }
    
    
}
//获取视频的第一帧
+ (UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}
+(NSString *)shiJianDistanceAlsoDaYu3Days:(NSString *)timestamp distance:(int)timeDistance;
{
    
    NSTimeInterval createdAt = [timestamp doubleValue];
    
    // Calculate distance time string
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
   if (distance >= 60 * 60 * 24 * timeDistance)
   {
       return @"大于3天";
   }
    else
    {
        return @"小于3天";
    }
}
+(NSString *)shiJianDistanceAlsoDaYu5Minutes:(NSString *)timestamp distance:(int)timeDistance;
{
    
    NSTimeInterval createdAt = [timestamp doubleValue];
    
    // Calculate distance time string
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
    if (distance >= 60 * timeDistance)
    {
        return @"大于5分钟";
    }
    else
    {
        return @"小于5分钟";
    }
}
+(NSString *)getDeviceIPIpAddresses

{
    
    int sockfd =socket(AF_INET,SOCK_DGRAM, 0);
    
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE =4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            
            int len =sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                
                len = ifr->ifr_addr.sa_len;
                
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            
            
            
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
            
        }
        
    }
    
    close(sockfd);
    NSString *deviceIP =@"";
    
    for (int i=0; i < ips.count; i++)
        
    {
        
        if (ips.count >0)
            
        {
            
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
            
            
            
        }
        
    }
    
    NSLog(@"deviceIP========%@",deviceIP);
    return deviceIP;
    
}
//获取网格列表
+(NSArray *)getGridlist
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * info = [defaults objectForKey:USERINFO];
    
    return [info objectForKey:@"gridlist"];
}
//获取分类数据
+(NSMutableArray *)getFenLeiList
{
    NSArray * array = [[NSMutableArray alloc] initWithObjects:@"无",@"农村集体土地征用、流转",@"国有土地拆迁",@"城乡建设管理",@"土地、山林、水利资源权属",@"环境保护",@"计划生育",@"村务管理",@"劳动社保",@"医疗卫生",@"交通事故",@"学校教育",@"房产物业",@"消费者维权、产品质量安全",@"经济合同、金融借贷",@"人身伤害",@"婚姻家庭",@"邻里关系",@"边界管理",@" 民族宗教",@"企业改制",@"移民安置",@"行政执法",@"涉法涉诉",@"损害赔偿", nil];
    NSMutableArray * feiLeiArray = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info ;
        if (i<10) {
            
            info = [[NSDictionary alloc] initWithObjectsAndKeys:[array objectAtIndex:i],@"name",[NSString stringWithFormat:@"0%d",i],@"id", nil];
        }
        else
        {
            info = [[NSDictionary alloc] initWithObjectsAndKeys:[array objectAtIndex:i],@"name",[NSString stringWithFormat:@"%d",i],@"id", nil];
        }
        [feiLeiArray addObject:info];
    }
    return feiLeiArray;
}


@end
