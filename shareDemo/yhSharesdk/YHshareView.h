//
//  shareView.h
//  shareDemo
//
//  Created by 余华俊 on 16/4/11.
//  Copyright © 2016年 hackxhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHshareView : UIView


@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *descr;

@property(nonatomic,strong)NSString *img;

@property(nonatomic,strong)NSString *musicurl;

@property(nonatomic,strong)NSString *mainurl;



-(void)showShareView:(UIView*)view title:(NSString*)title description:(NSString*)descr imgurl:(NSString*)img musicUrl:(NSString*)musicurl mainUrl:(NSString*)mainurl;

@end
