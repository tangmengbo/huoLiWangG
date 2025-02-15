//
//  ImageCache.m
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-16.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import "ImageCache.h"

static ImageCache*     instance = nil;

@implementation ImageCache
@synthesize invalidationAge;

- (id)init
{
    if ((self = [super init]))
    {
        // Init the memory cache
        memCache = [[NSMutableDictionary alloc] init];
        
        // Init the disk cache
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
        
        // Init the operation queue
        cacheInQueue = [[NSOperationQueue alloc] init];
        cacheInQueue.maxConcurrentOperationCount = 1;
        cacheOutQueue = [[NSOperationQueue alloc] init];
        cacheOutQueue.maxConcurrentOperationCount = 1;
        
        self.invalidationAge = DEFAULT_CACHE_EXPIRATION;
        
        UIDevice *device = [UIDevice currentDevice];
        if ([device respondsToSelector:@selector(isMultitaskingSupported)] && device.multitaskingSupported)
        {
            // When in background, clean memory in order to have less chance to be killed
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(cleanDisk)
                                                         name:UIApplicationDidEnterBackgroundNotification
                                                       object:nil];
        }
    }
    
    return self;
}


#pragma mark SDImageCache (class methods)

+ (ImageCache *)sharedImageCache
{
    if (instance == nil)
    {
        instance = [[ImageCache alloc] init];
    }
    
    return instance;
}

#pragma mark SDImageCache (private)

/*
 *创建指定图片key的路径
 */
- (NSString *)cachePathForKey:(NSString *)key
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return [diskCachePath stringByAppendingPathComponent:filename];
}

/*
 *保存key和Data到物理存储
 *keyAndData[0] ->key
 *keyAndData[1] ->Data
 */
- (void)storeKeyWithDataToDisk:(NSArray *)keyAndData
{
    // Can't use defaultManager another thread
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSString *key = [keyAndData objectAtIndex:0];
    NSData *data = [keyAndData count] > 1 ? [keyAndData objectAtIndex:1] : nil;
    
    //如果有数据，则保存到物理存储上
    if (data)
    {
        [fileManager createFileAtPath:[self cachePathForKey:key] contents:data attributes:nil];
    }
    else
    {
        //如果没有data，则把UIImage转换为JPEG，并保存到物理存储上
        // If no data representation given, convert the UIImage in JPEG and store it
        // This trick is more CPU/memory intensive and doesn't preserve alpha channel
        UIImage *image = [self imageFromKey:key fromDisk:YES]; // be thread safe with no lock
        if (image)
        {
#if TARGET_OS_IPHONE
            [fileManager createFileAtPath:[self cachePathForKey:key] contents:UIImageJPEGRepresentation(image, (CGFloat)1.0) attributes:nil];
#else
            NSArray*  representations  = [image representations];
            NSData* jpegData = [NSBitmapImageRep representationOfImageRepsInArray: representations usingType: NSJPEGFileType properties:nil];
            [fileManager createFileAtPath:[self cachePathForKey:key] contents:jpegData attributes:nil];
#endif
        }
    }
}

/*
 *查找图片委托
 */
- (void)notifyDelegate:(NSDictionary *)arguments
{
    NSString *key = [arguments objectForKey:@"key"];
    id <ImageCacheDelegate> delegate = [arguments objectForKey:@"delegate"];
    NSDictionary *info = [arguments objectForKey:@"userInfo"];
    UIImage *image = [arguments objectForKey:@"image"];
    
    if (image)
    {
        [memCache setObject:image forKey:key];
        
        if ([delegate respondsToSelector:@selector(imageCache:didFindImage:forKey:userInfo:)])
        {
            [delegate imageCache:self didFindImage:image forKey:key userInfo:info];
        }
    }
    else
    {
        if ([delegate respondsToSelector:@selector(imageCache:didNotFindImageForKey:userInfo:)])
        {
            [delegate imageCache:self didNotFindImageForKey:key userInfo:info];
        }
    }
}

/*
 *查找物理缓存上的图片
 */
- (void)queryDiskCacheOperation:(NSDictionary *)arguments
{
    NSString *key = [arguments objectForKey:@"key"];
    NSMutableDictionary *mutableArguments = [arguments mutableCopy];
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[self cachePathForKey:key]];
    if (image)
    {
#ifdef ENABLE_SDWEBIMAGE_DECODER
        UIImage *decodedImage = [UIImage decodedImageWithImage:image];
        if (decodedImage)
        {
            image = decodedImage;
        }
#endif
        [mutableArguments setObject:image forKey:@"image"];
    }
    
    [self performSelectorOnMainThread:@selector(notifyDelegate:) withObject:mutableArguments waitUntilDone:NO];
}

#pragma mark ImageCache

/*
 *缓存图片
 *
 **/
- (void)storeImage:(UIImage *)image imageData:(NSData *)data forKey:(NSString *)key toDisk:(BOOL)toDisk
{
    if (!image || !key)
    {
        return;
    }
    
    //缓存图片到内存上
    [memCache setObject:image forKey:key];
    
    //如果需要缓存到物理存储上，并data不为空，则把data缓存到物理存储上
    if (toDisk)
    {
        if (!data) return;
        NSArray *keyWithData;
        if (data)
        {
            keyWithData = [NSArray arrayWithObjects:key, data, nil];
        }
        else
        {
            keyWithData = [NSArray arrayWithObjects:key, nil];
        }
        //后台线程缓存图片到物理存储上
        [cacheInQueue addOperation:[[NSInvocationOperation alloc] initWithTarget:self
                                                                         selector:@selector(storeKeyWithDataToDisk:)
                                                                           object:keyWithData]];
    }
}

/*
 *保存图片到内存上，不保存到物理存储上
 */
- (void)storeImage:(UIImage *)image forKey:(NSString *)key
{
    [self storeImage:image imageData:nil forKey:key toDisk:YES];
}
/*
 *保存图片到内存上，不保存到物理存储上
 */
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk
{
    [self storeImage:image imageData:nil forKey:key toDisk:toDisk];
}

/*
 *通过key返回指定图片
 */
- (UIImage *)imageFromKey:(NSString *)key
{
    return [self imageFromKey:key fromDisk:YES];
}

/*
 *返回一张图像
 *key：图像的key
 *fromDisk：如果内存中没有图片，是否在物理存储上查找
 *return 返回查找到的图片，如果没有则返回nil
 */
- (UIImage *)imageFromKey:(NSString *)key fromDisk:(BOOL)fromDisk
{
    if (key == nil)
    {
        return nil;
    }
    
    UIImage *image = [memCache objectForKey:key];
    
    if (!image && fromDisk) //如果内存没有图片，并且可以在物理存储上查找，则返回物理存储上的图片
    {
        image = [[UIImage alloc] initWithContentsOfFile:[self cachePathForKey:key]];
        if (image)
        {
            [memCache setObject:image forKey:key];
        }
    }
    
    return image;
}

- (void)queryDiskCacheForKey:(NSString *)key delegate:(id <ImageCacheDelegate>)delegate userInfo:(NSDictionary *)info
{
    if (!delegate)
    {
        return;
    }
    
    if (!key)
    {
        if ([delegate respondsToSelector:@selector(imageCache:didNotFindImageForKey:userInfo:)])
        {
            [delegate imageCache:self didNotFindImageForKey:key userInfo:info];
        }
        return;
    }
    
    // First check the in-memory cache...
    UIImage *image = [memCache objectForKey:key];
    if (image)
    {
        // ...notify delegate immediately, no need to go async
        if ([delegate respondsToSelector:@selector(imageCache:didFindImage:forKey:userInfo:)])
        {
            [delegate imageCache:self didFindImage:image forKey:key userInfo:info];
        }
        return;
    }
    
    NSMutableDictionary *arguments = [NSMutableDictionary dictionaryWithCapacity:3];
    [arguments setObject:key forKey:@"key"];
    [arguments setObject:delegate forKey:@"delegate"];
    if (info)
    {
        [arguments setObject:info forKey:@"userInfo"];
    }
    [cacheOutQueue addOperation:[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(queryDiskCacheOperation:) object:arguments]];
}

/*
 *从内存和物理存储上移除指定图片
 */
- (void)removeImageForKey:(NSString *)key
{
    if (key == nil)
    {
        return;
    }
    
    [memCache removeObjectForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:[self cachePathForKey:key] error:nil];
}
/*
 *清除内存缓存区的图片
 */
- (void)clearMemory
{
    [cacheInQueue cancelAllOperations]; // won't be able to complete
    [memCache removeAllObjects];
}

/*
 *清除物理存储上的图片
 */
- (void)clearDisk
{
    [cacheInQueue cancelAllOperations];
    [[NSFileManager defaultManager] removeItemAtPath:diskCachePath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:NULL];
}
/*
 *清除过期缓存的图片
 */
- (void)cleanDisk
{
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-invalidationAge];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:diskCachePath];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [diskCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        if ([[[attrs fileModificationDate] laterDate:expirationDate] isEqualToDate:expirationDate])
        {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
}

@end
