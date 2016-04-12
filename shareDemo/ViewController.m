//
//  ViewController.m
//  shareDemo
//
//  Created by 余华俊 on 16/4/8.
//  Copyright © 2016年 hackxhj. All rights reserved.
//

#import "ViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "TencentOpenAPI/QQApiInterface.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "WXApiRequestHandler.h"
#import "Constant.h"
#import "WXApiManager.h"


#import "YHShareMusic.h"

#import "YHshareView.h"


@interface ViewController ()<TencentSessionDelegate,WXApiManagerDelegate>
 
@end

@implementation ViewController
{
    
 }

- (void)viewDidLoad {
    [super viewDidLoad];
 
     [WXApiManager sharedManager].delegate = self;

}

- (IBAction)shareToqqUser:(id)sender {
    
 
    
   int ret= [YHShareMusic shareMusic:0 platform:0 title:@"你好" description:@"描述文件" imgurl:@"http://avatar.csdn.net/B/D/1/1_z343929897.jpg" musicUrl:@"http:www.baidu.com/1.mp1" mainUrl:@"www.baidu.com"];
   [self handleSendResult:ret];


    
}

- (IBAction)shareQzone:(id)sender {
 
    
     int ret=[YHShareMusic shareMusic:1 platform:0 title:@"你好" description:@"描述文件" imgurl:@"http://avatar.csdn.net/B/D/1/1_z343929897.jpg" musicUrl:@"http:www.baidu.com/1.mp1" mainUrl:@"www.baidu.com"];
    
      [self handleSendResult:ret];
}


- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        default:
        {
            break;
        }
    }
}


- (IBAction)sharewechatsec:(id)sender
{
 
 
    
     [YHShareMusic shareMusic:0 platform:1 title:@"你好" description:@"描述文件" imgurl:@"http://avatar.csdn.net/B/D/1/1_z343929897.jpg" musicUrl:@"http:www.baidu.com/1.mp1" mainUrl:@"www.baidu.com"];
    
    
    
    
}

- (IBAction)sharewechatpyq:(id)sender
{
 

    [YHShareMusic shareMusic:1 platform:1 title:@"你好" description:@"描述文件" imgurl:@"http://avatar.csdn.net/B/D/1/1_z343929897.jpg" musicUrl:@"http:www.baidu.com/1.mp3" mainUrl:@"www.baidu.com"];
    
 
    
}
#pragma mark - WXApiManagerDelegate


- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response {
    NSString *strTitle = [NSString stringWithFormat:@"消息提示"];
    NSString *strMsg = [NSString stringWithFormat:@"错误代码:%d", response.errCode];
    
//    if(response.errCode==0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
//                                                        message:@"分享成功"
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
//    }else
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
//                                                        message:strMsg
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    
    
}


- (IBAction)show:(id)sender {
    
    YHshareView *showView=[YHshareView new];
    [showView showShareView:self.view title:@"标题" description:@"描述文件"imgurl:@"http://avatar.csdn.net/B/D/1/1_z343929897.jpg" musicUrl:@"http://www.baidu.com/1.mp3" mainUrl:@"http://www.baidu.com/"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
