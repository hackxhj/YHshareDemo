//
//  YHShareMusic.m
//  shareDemo
//
//  Created by 余华俊 on 16/4/8.
//  Copyright © 2016年 hackxhj. All rights reserved.
//

#import "YHShareMusic.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WXApiManager.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import "WXApiRequestHandler.h"
#import "WeiboSDK.h"

#define TALKCELLGAP 90
#define TALKCELLSECTIONGAP 20
#define GAPWIDTH 10

@interface YHShareMusic ()

@end

@implementation YHShareMusic

+(void)regQQAuth:(NSString*)sid
{
    [[TencentOAuth alloc] initWithAppId:sid
                            andDelegate:[UIApplication sharedApplication]];
}
+(void)regWeChatAuth:(NSString*)sid
{
    [WXApi registerApp:sid];
}

+(void)regWeibo:(NSString*)sid
{
    [WeiboSDK registerApp:sid];
}

+(BOOL)AppopenUrl:(NSURL*)url
{
    BOOL wxret= [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    BOOL qqret=[TencentOAuth HandleOpenURL:url];
    if(wxret==YES&&qqret==YES)
        return YES;
    else
        return NO;
}
+(BOOL)ApphandleOpenURL:(NSURL*)url
{
    BOOL wxret=[WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    BOOL qqret= [TencentOAuth HandleOpenURL:url];
    if(wxret==YES&&qqret==YES)
        return YES;
    else
        return NO;
}


+(int)shareMusic:(int)type platform:(int)plat title:(NSString*)title description:(NSString*)descr imgurl:(NSString*)img musicUrl:(NSString*)musicurl mainUrl:(NSString*)mainurl;
{
    int  qqcodeRet=0;
    if(plat==0)//qq平台
    {
        int  qqcodeRet=[self shareQQWithType:type title:title description:descr imgurl:img musicUrl:musicurl mainUrl:mainurl];
        
        
    }else if(plat==1)//微信
    {
        [self shareWeChatWithType:type title:title description:descr imgurl:img musicUrl:musicurl mainUrl:mainurl];
    }else if(plat==2)//新浪微博
    {
        [self shareSinaWithType:type title:title description:descr imgurl:img musicUrl:musicurl mainUrl:mainurl];
    }
    return qqcodeRet;
    
}




+(QQApiSendResultCode)shareQQWithType:(int)type title:(NSString*)title description:(NSString*)descr imgurl:(NSString*)img musicUrl:(NSString*)musicurl mainUrl:(NSString*)mainurl;
{
    //分享跳转URL
    NSString *url = mainurl;
    //分享图预览图URL地址
    NSString *previewImageUrl = img;
    //音乐播放的网络流媒体地址
    NSString *flashURL =musicurl;
    QQApiAudioObject *audioObj =[QQApiAudioObject
                                 objectWithURL :[NSURL URLWithString:url]
                                 title:title
                                 description:descr
                                 previewImageURL:[NSURL URLWithString:previewImageUrl]];
    //设置播放流媒体地址
    
    audioObj.flashURL=[NSURL URLWithString:flashURL];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:audioObj];
    QQApiSendResultCode sent;
    if(type==0)
        //将内容分享到qq
        sent = [QQApiInterface sendReq:req];
    else
        //将被容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
    // [self handleSendResult:sent];
    return sent;
}

+(void)shareWeChatWithType:(int)type title:(NSString*)title description:(NSString*)descr imgurl:(NSString*)img musicUrl:(NSString*)musicurl mainUrl:(NSString*)mainurl;
{
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
    UIImage *result = [UIImage imageWithData:data];
    NSData *yasuodata=[YHShareMusic changeAndCutDownImageWithData:result];
    
    result = [UIImage imageWithData:yasuodata];
    
    if(type==0)//微信好友
        [WXApiRequestHandler sendMusicURL:mainurl
                                  dataURL:musicurl
                                    Title:title
                              Description:descr
                               ThumbImage:result
                                  InScene:WXSceneSession];
    else
        [WXApiRequestHandler sendMusicURL:mainurl
                                  dataURL:musicurl
                                    Title:title
                              Description:descr
                               ThumbImage:result
                                  InScene:WXSceneTimeline];
}



+(void)shareSinaWithType:(int)type title:(NSString*)title description:(NSString*)descr imgurl:(NSString*)img musicUrl:(NSString*)musicurl mainUrl:(NSString*)mainurl
{
    if(type==0)//微博正文
    {
        NSData * imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
        
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = @"http://www.lovereadingbooks.com/";
        authRequest.scope = @"all";
        
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
        UIImage *result = [UIImage imageWithData:data];
        NSData *yasuodata=[YHShareMusic changeAndCutDownImageWithData:result];
        
        
        WBMessageObject *message = [WBMessageObject message];
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = title;
        webpage.description = descr;
        webpage.thumbnailData = yasuodata;
        webpage.webpageUrl =  mainurl;
        message.mediaObject = webpage;
        
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
        request.userInfo = @{@"ShareMessageFrom": @"YHShareMusic",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        BOOL istrue=[WeiboSDK sendRequest:request];
    }
}

//图片压缩 b
+(NSData *)changeAndCutDownImageWithData:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation([self changImageSizeWithImage:image], 0.3);
    // NSData *imageData = UIImageJPEGRepresentation( image, 0.8);
    return imageData;
}

+(UIImage *)changImageSizeWithImage:(UIImage *)image{
    if (image.size.width < ([UIScreen mainScreen].bounds.size.width - TALKCELLGAP * 1.3 + GAPWIDTH)) {
        return image;
    }else{
        float height = image.size.height;
        height = height / (image.size.width / ([UIScreen mainScreen].bounds.size.width - TALKCELLGAP * 1.3 + GAPWIDTH));
        UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width - TALKCELLGAP * 1.3 + GAPWIDTH, height));
        [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - TALKCELLGAP * 1.3 + GAPWIDTH, height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        
        return newImage;
    }
}



@end
