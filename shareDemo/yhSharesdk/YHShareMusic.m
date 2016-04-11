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
  
        
    }else
    {
        [self shareWeChatWithType:type title:title description:descr imgurl:img musicUrl:musicurl mainUrl:mainurl];
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
 
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
    result = [UIImage imageWithData:data];
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






@end
