//
//  XDHeader.h
//  DevelopMent
//
//  Created by 容芳志 on 13-4-1.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#ifndef DevelopMent_XDHeader_h
#define DevelopMent_XDHeader_h

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define HOST_URL                @"http://www.dacheq.com/"
//#define HOST_URL                @"http://192.168.1.101:8010/"

#define API_DEVELOPIAMGE    @"assets/developimage/"           //根据图片名获取图片
#define API_APP             @"index.php/index/app"            //APP
#define API_TRADECLASS      @"index.php/index/tradeclass"     //获取行业列表
#define API_LEVEL           @"index.php/index/level"          // 获取级别列表
#define API_GETCITY         @"index.php/index/getCity"        // 获取市名
#define API_GETDEVELOP      @"index.php/index/getDevelop"     //开发区名称+图片+文字
#define API_INTRO           @"index.php/index/intro"          //简介
#define API_CLASS           @"index.php/index/class"          //分类
#define API_GETINDEX        @"index.php/index/getindex"       //指数
#define API_SEARCH          @"index.php/index/search"         //搜索页搜索数据
#define API_INDEXIMG        @"index.php/index/indexImg"       //首页图片


#endif
