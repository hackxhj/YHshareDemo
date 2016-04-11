//
//  shareView.m
//  shareDemo
//
//  Created by 余华俊 on 16/4/11.
//  Copyright © 2016年 hackxhj. All rights reserved.
//

#import "YHshareView.h"
#import "Masonry.h"
#import "YHShareMusic.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height



@protocol PlatItemViewDelegate <NSObject>

-(void)clickWithTag:(int)tag;

@end
// 子item
@interface PlatItemView : UIView
@property(nonatomic,strong)UIButton *btnIcon;
@property(nonatomic,strong)UILabel *showLable;
@property(nonatomic,weak)id<PlatItemViewDelegate>delegate;

@end


@implementation PlatItemView


-(id)initWithIconText:(UIImage*)icon:(NSString*)label
{
    if(self=[super init])
    {
        [self addSubview:self.btnIcon];
        [self addSubview:self.showLable];
        [self.btnIcon setImage:icon forState:0];
        [self.showLable setText:label];
        [self.btnIcon mas_makeConstraints:^(MASConstraintMaker *make) {
              make.size.mas_equalTo(CGSizeMake(58, 58));
              make.top.and.left.equalTo(self).offset(1);
         }];
        [self.showLable mas_makeConstraints:^(MASConstraintMaker *make) {
              make.size.mas_equalTo(CGSizeMake(58, 18));
              make.top.equalTo(self.btnIcon.mas_bottom).offset(1);
              make.left.equalTo(self.btnIcon.mas_left);
        }];
    }
    return self;
}



-(UIButton*)btnIcon
{
    if(!_btnIcon)
    {
        _btnIcon=[UIButton new];
        [_btnIcon addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnIcon;
}

-(UILabel*)showLable
{
    if(!_showLable)
    {
        _showLable=[UILabel new];
        _showLable.textAlignment=NSTextAlignmentCenter;
        _showLable.font=[UIFont systemFontOfSize:11];
    }
    return _showLable;
}


-(void)btnclick
{
    if([self.delegate respondsToSelector:@selector(clickWithTag:)])
    {
        [self.delegate clickWithTag:self.tag];
    }
}

@end



@interface YHshareView()<PlatItemViewDelegate>
@property(nonatomic,strong)UIView *grayView;
@property(nonatomic,strong)UIView *mainShowView;

@end
@implementation YHshareView


-(UIView*)grayView
{
    if(!_grayView)
    {
        _grayView=[UIView new];
        _grayView.backgroundColor=[UIColor blackColor];
        _grayView.alpha=0.3;
        UITapGestureRecognizer *tapGester=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissView)];
        [_grayView addGestureRecognizer:tapGester];
        
        
    }
    return  _grayView;
}


-(UIView*)mainShowView
{
    if(!_mainShowView)
    {
        _mainShowView=[UIView new];
        _mainShowView.backgroundColor=[UIColor whiteColor];
    }
    return  _mainShowView;
}


-(void)addmySubView
{
    self.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor=[UIColor clearColor];
    [self addSubview:self.grayView];
    [self addSubview:self.mainShowView];
    
    
    PlatItemView *show1=[[PlatItemView alloc]initWithIconText:[UIImage imageNamed:@"sns_icon_24"] :@"QQ"];
    show1.delegate=self;
    show1.tag=1001;
    PlatItemView *show2=[[PlatItemView alloc]initWithIconText:[UIImage imageNamed:@"sns_icon_6"] :@"QQ空间"];
    show2.tag=1002;
    show2.delegate=self;

    PlatItemView *show3=[[PlatItemView alloc]initWithIconText:[UIImage imageNamed:@"sns_icon_22"] :@"微信"];
    show3.tag=1003;
    show3.delegate=self;
    PlatItemView *show4=[[PlatItemView alloc]initWithIconText:[UIImage imageNamed:@"sns_icon_23"] :@"微信朋友圈"];
    show4.tag=1004;
    show4.delegate=self;
    [self.mainShowView addSubview:show1];
    [self.mainShowView addSubview:show2];
    [self.mainShowView addSubview:show3];
    [self.mainShowView addSubview:show4];
    
  //  int padding=10;
    int padding=(kScreenWidth-(4*60))/5;
    [show1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(60, 80));
         make.centerY.equalTo(self.mainShowView);
         make.left.equalTo(self.mainShowView).offset(padding);
    }];
    [show2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(show1);
        make.centerY.equalTo(self.mainShowView);
        make.left.equalTo(show1.mas_right).offset(padding);
    }];
    
    [show3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(show1);
        make.centerY.equalTo(self.mainShowView);
        make.left.equalTo(show2.mas_right).offset(padding);
    }];
    
    [show4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(show1);
        make.centerY.equalTo(self.mainShowView);
        make.left.equalTo(show3.mas_right).offset(padding);
    }];
    
    
    
}

-(void)addAutolayout
{
   [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.size.equalTo(self);
             make.left.and.top.equalTo(self);
          
      }];
    [self.mainShowView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.equalTo(self);
         make.height.equalTo(self).multipliedBy(0.2);
         make.bottom.equalTo(self);
        make.left.equalTo(self);
        
      }];
}


-(id)init
{
    if(self=[super init])
    {
        [self addmySubView];
        [self addAutolayout];
    }
    return  self;
}


-(void)showShareView:(UIView*)view title:(NSString*)title description:(NSString*)descr imgurl:(NSString*)img musicUrl:(NSString*)musicurl mainUrl:(NSString*)mainurl
{
    
    self.title=title;
    self.descr=descr;
    self.img=img;
    self.musicurl=musicurl;
    self.mainurl=mainurl;
    
    [view addSubview:self];
    
    
}
-(void)clickWithTag:(int)tag
{
    if(tag==1001)
    {
        int ret= [YHShareMusic shareMusic:0 platform:0 title:self.title description:self.descr imgurl:self.img musicUrl:self.musicurl mainUrl:self.mainurl];
        
    }else if(tag==1002)
    {
        int ret=[YHShareMusic shareMusic:1 platform:0 title:self.title description:self.descr imgurl:self.img musicUrl:self.musicurl mainUrl:self.mainurl];
 
        
    }else if(tag==1003)
    {
        [YHShareMusic shareMusic:0 platform:1 title:self.title description:self.descr imgurl:self.img musicUrl:self.musicurl mainUrl:self.mainurl];
        
    }else{
        [YHShareMusic shareMusic:1 platform:1 title:self.title description:self.descr imgurl:self.img musicUrl:self.musicurl mainUrl:self.mainurl];
        
    }
    [self dissView];
}


-(void)dissShareView
{
    [self removeFromSuperview];
}

-(void)dissView
{
    [self dissShareView];
}
@end
