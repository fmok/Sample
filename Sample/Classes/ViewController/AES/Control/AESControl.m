//
//  AESControl.m
//  Sample
//
//  Created by wjy on 2018/8/16.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "AESControl.h"
#import "NSData+AES.h"
#import "GTMBase64.h"

/**
 plist name
 */
// 牌义
static NSString *const PlistName_CardMeaning_CN = @"cardMeaning-CN";
static NSString *const PlistName_CardMeaning_ja = @"cardMeaning-ja";
static NSString *const Plistname_CardMeaning_ko = @"cardMeaning-ko";
// 描述
static NSString *const PlistName_CardDes_CN = @"cardDes-CN";
static NSString *const PlistName_CardDes_ja = @"cardDes-ja";
static NSString *const PlistName_CardDes_ko = @"cardDes-ko";
// 【每日一占】
static NSString *const PlistName_DalilyTarotCards_CN = @"DalilyTarotCards-CN";
static NSString *const PlistName_DalilyTarotCards_ja = @"DalilyTarotCards-ja";
static NSString *const PlistName_DalilyTarotCards_ko = @"DalilyTarotCards-ko";
//
static NSString *const PlistName_TarotCards_CN = @"TarotCards-CN";
static NSString *const PlistName_TarotCards_ja = @"TarotCards-ja";
static NSString *const PlistName_TarotCards_ko = @"TarotCards-ko";

/**
 user-defined directory
 */
static NSString *const UDefinedDirectoryTarotCard = @"TarotCard";
static NSString *const UDefinedDirectoryCardMeaning = @"CardMeaning";
static NSString *const UDefinedDirectoryCardDescription = @"CardDescription";
static NSString *const UDefinedDirectoryDalilyTarotCard = @"DalilyTarotCard";


/**
 */
static NSString *const AESKey = @"efrVN9vy6MxuHrtG";
static NSString *const AESIv = @"N3nLasdhgypjZu3r";

@implementation AESControl

#pragma mark - AES
/******************************************************************************************
 加密：
 1、定义 key、iv；
 2、读取plist转相应类型（id），转NSData；
 3、AES；
 4、Base64；
 5、文件名 name MD5，写入本地 备用。
 *****************************************************************************************
 解密：
 1、文件名 name MD5
 2、拼接 filePath
 3、读取本地 base64Data
 4、base64Data -> AESData
 5、AESData -> NSData
 6、NSData -> 相应类型（id）
 *****************************************************************************************/
- (void)AESDeal
{
    // TarotCard
    [self AESEncryptWithFileName:PlistName_TarotCards_CN setType:[NSDictionary class] userDefinedDirectory:UDefinedDirectoryTarotCard];
    [self AESEncryptWithFileName:PlistName_TarotCards_ja setType:[NSDictionary class] userDefinedDirectory:UDefinedDirectoryTarotCard];
    [self AESEncryptWithFileName:PlistName_TarotCards_ko setType:[NSDictionary class] userDefinedDirectory:UDefinedDirectoryTarotCard];
    
    // CardMeaning
    [self AESEncryptWithFileName:PlistName_CardMeaning_CN setType:[NSArray class] userDefinedDirectory:UDefinedDirectoryCardMeaning];
    [self AESEncryptWithFileName:PlistName_CardMeaning_ja setType:[NSArray class] userDefinedDirectory:UDefinedDirectoryCardMeaning];
    [self AESEncryptWithFileName:Plistname_CardMeaning_ko setType:[NSArray class] userDefinedDirectory:UDefinedDirectoryCardMeaning];
    
    // CardDescription
    [self AESEncryptWithFileName:PlistName_CardDes_CN setType:[NSArray class] userDefinedDirectory:UDefinedDirectoryCardDescription];
    [self AESEncryptWithFileName:PlistName_CardDes_ja setType:[NSArray class] userDefinedDirectory:UDefinedDirectoryCardDescription];
    [self AESEncryptWithFileName:PlistName_CardDes_ko setType:[NSArray class] userDefinedDirectory:UDefinedDirectoryCardDescription];
    
    // 【每日一占】
    [self AESEncryptWithFileName:PlistName_DalilyTarotCards_CN setType:[NSDictionary class] userDefinedDirectory:UDefinedDirectoryDalilyTarotCard];
    [self AESEncryptWithFileName:PlistName_DalilyTarotCards_ja setType:[NSDictionary class] userDefinedDirectory:UDefinedDirectoryDalilyTarotCard];
    [self AESEncryptWithFileName:PlistName_DalilyTarotCards_ko setType:[NSDictionary class] userDefinedDirectory:UDefinedDirectoryDalilyTarotCard];
}

- (void)AESEncryptWithFileName:(NSString *)name setType:(Class)cls userDefinedDirectory:(NSString *)uDirectory
{
    // 读取 plist 到 cls
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    id dataObj = [[cls alloc] initWithContentsOfFile:plistPath];
    // cls 转 NSData
    NSError *error;
    NSData *dicData = [NSJSONSerialization dataWithJSONObject:dataObj options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        TTDPRINT(@"\n cls->data:\n %@ \n", error);
    }
    // AES
    NSData *AESData = [dicData AES128EncryptWithKey:AESKey iv:AESIv];
    // base64
    NSData *base64Data = [GTMBase64 encodeData:AESData];
    // name 进行 MD5
    NSString *md5Name = [FMUtility md5Hash:name];
    // 写入本地
    NSString *path = [self getCashesPathWithUserDefinedDirectory:uDirectory];
    NSString *filePath = [path stringByAppendingPathComponent:md5Name];
    [NSKeyedArchiver archiveRootObject:base64Data toFile:filePath];
}

- (NSString *)getCashesPathWithUserDefinedDirectory:(NSString *)uDirectory
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *basePath = [NSString stringWithFormat:@"%@/tarotInfo/",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
    TTDPRINT(@"\n********** Tarot info base path *********\n%@\n********** base path *********\n", basePath);
    NSString *path = [basePath stringByAppendingString:uDirectory];
    if (![mgr fileExistsAtPath:path]) {
        [mgr createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return path;
}

- (id)getTarotFormattedDataSourceWithFileName:(NSString *)name
{
    NSString *md5Name = [FMUtility md5Hash:name];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:md5Name ofType:nil];
    NSData *base64Data = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSData *AESData = [GTMBase64 decodeData:base64Data];
    NSData *objData = [AESData AES128DecryptWithKey:AESKey iv:AESIv];
    NSError *error;
    id jsonObj = nil;
    jsonObj = [NSJSONSerialization JSONObjectWithData:objData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        TTDPRINT(@"\n data->cls\n%@ \n", error);
    }
    return jsonObj;
}

@end
