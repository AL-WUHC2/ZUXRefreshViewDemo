//
//  Constant.h
//  ZUXRefreshViewDemo
//
//  Created by Char Aznable on 15-3-25.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUXRefreshViewDemo_Constant_h
#define ZUXRefreshViewDemo_Constant_h

#define IOS7_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"]!=NSOrderedAscending)

#define statusBarHeight     (IOS7_OR_LATER?20:0)

#define IS_IPHONE4          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE5          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE6          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE6P         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define DeviceScale         (IS_IPHONE6P?1.29375:(IS_IPHONE6?1.171875:1.0))

#endif
