//
//  YHShareMusic.h
//  shareDemo
//
//  Created by 余华俊 on 16/4/8.
//  Copyright © 2016年 hackxhj. All rights reserved.
//

#import <Foundation/Foundation.h>

 

@interface YHShareMusic : NSObject


+(void)regQQAuth:(NSString*)sid;
+(void)regWeChatAuth:(NSString*)sid;

+(BOOL)AppopenUrl:(NSURL*)url;
+(BOOL)ApphandleOpenURL:(NSURL*)url;


+(int)shareMusic:(int)type platform:(int)plat title:(NSString*)title description:(NSString*)descr imgurl:(NSString*)img musicUrl:(NSString*)musicurl mainUrl:(NSString*)mainurl;




@end
